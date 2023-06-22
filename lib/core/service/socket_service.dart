import 'dart:convert';
import 'dart:typed_data';

import 'package:rsocket/metadata/composite_metadata.dart';
import 'package:rsocket/payload.dart';
import 'package:rsocket/rsocket_connector.dart';

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
    final data = jsonEncode({
      'accessToken': authProvider.authToken!.accessToken,
      'deviceToken': pushStore.token,
    });
    await RSocketConnector.create()
        .keepAlive(2000, 999999999)
        .connect('wss://gateway.chuyong.kr')
        .catchError((err) => print(err))
        .asStream()
        .asyncExpand((event) => event
            .requestStream!(routeAndDataPayload('/v1/event-gateway', data)))
        .map((event) => event!.getDataUtf8())
        .forEach((element) {
      pushStore.processMessage(jsonDecode(element ?? ''));
    });
  }
}
