import 'dart:convert';
import 'dart:typed_data';

import 'package:badsound_counter_app/core/framework/base_action.dart';
import 'package:rsocket/metadata/composite_metadata.dart';
import 'package:rsocket/payload.dart';
import 'package:rsocket/rsocket_connector.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../dependencies.config.dart';
import '../state/auth_store.dart';
import '../state/push_store.dart';

class SocketService {
  final authProvider = inject<AuthProvider>();
  final pushStore = inject<PushStore>();

  Payload routeAndDataPayload(String route, String data) {
    var compositeMetadata =
        CompositeMetadata.fromEntries([RoutingMetadata(route, List.empty())]);
    var metadataBytes = compositeMetadata.toUint8Array();
    var dataBytes = Uint8List.fromList(utf8.encode(data));
    return Payload.from(metadataBytes, dataBytes);
  }

  Future<void> connect() async {
    if (authProvider.authToken == null || pushStore.token == null) return;
    final data = jsonEncode({
      'accessToken': authProvider.authToken!.accessToken,
      'deviceToken': pushStore.token,
    });
    try {
      await RSocketConnector.create()
          .keepAlive(2000, 999999999)
          .connect('wss://gateway.chuyong.kr')
          .catchError((err, st) {
        Sentry.captureException(
          err,
          stackTrace: st,
        );
            BaseAction.errorSnackBar(message: err.toString());
          })
          .asStream()
          .asyncExpand((event) => event
              .requestStream!(routeAndDataPayload('/v1/event-gateway', data)))
          .map((event) => event!.getDataUtf8())
          .forEach((element) {
        pushStore.processMessage(jsonDecode(element ?? ''));
      });
    } catch (e, t) {
      print(
          "WebSocket Disconnection Detected!! try reconnect after 5 seconds..");
      await Sentry.captureException(
        e,
        stackTrace: t,
      );
      await Future.delayed(Duration(milliseconds: 5000));
      await connect();
    }
  }
}
