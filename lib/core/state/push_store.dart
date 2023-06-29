import 'dart:convert';

import 'package:badsound_counter_app/core/api/model/chat_response.dart';
import 'package:badsound_counter_app/core/util/extension.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushStore {
  String? token;
  Function? chatMessageConsumer;

  //Related to FireBase Push Services
  // PushStore() {
  //   FirebaseMessaging.instance.getToken().then((value) {
  //     token = value;
  //     print("Firebase token: $token");
  //   });
  // }

  bool isPushAuthorized() => token != null;

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print('Handling a background message ${message.messageId}');
  }

  Future<void> initializeNotification() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(const AndroidNotificationChannel(
            'high_importance_channel', 'high_importance_notification',
            importance: Importance.max));

    await flutterLocalNotificationsPlugin
        .initialize(const InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"),
            iOS: DarwinInitializationSettings(
              requestSoundPermission: true,
              requestBadgePermission: true,
              requestAlertPermission: true,
            )));

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    token = await FirebaseMessaging.instance.getToken();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      processMessage(message.data);

      if (message.notification != null) {
        print(
            'Message also contained a notification: ${message.notification.toString()}');
      }
    });
  }

  void processMessage(Map<String, dynamic> data) {
    if (!data.containsKey("packetType")) return;
    switch (data["packetType"]) {
      case "MESSAGE_RECEIVED":
        final body = data["payload"];
        final message = ChatResponse.fromJson(
            body is String ? jsonDecode(data["payload"]) : body);
        chatMessageConsumer?.let((e) => e(message));
        break;
      default:
        print('unknown packet type;');
        break;
    }
  }
}
