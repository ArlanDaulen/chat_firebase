import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingService {
  final msgService = FirebaseMessaging.instance;

  Future<void> init() async {
    await msgService.requestPermission();

    final token = await msgService.getToken();
    print('Firebase Messaging Token: $token');

    FirebaseMessaging.onBackgroundMessage(_handleNotification);
    FirebaseMessaging.onMessage.listen(_handleNotification);
  }

  Future<void> _handleNotification(RemoteMessage message) async {
    print('Handling notification: ${message.notification?.title}');
  }
}
