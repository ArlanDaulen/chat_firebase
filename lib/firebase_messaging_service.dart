import 'package:chat_firebase/local_notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingService {
  final msgService = FirebaseMessaging.instance;

  Future<void> init() async {
    await msgService.requestPermission();

    FirebaseMessaging.onBackgroundMessage(_handleNotification);
    FirebaseMessaging.onMessage.listen(_handleNotification);
  }

  Future<String?> getToken() async => await msgService.getToken();

  Future<void> _handleNotification(RemoteMessage message) async {
    final title = message.notification?.title ?? 'No title';
    final body = message.notification?.body ?? 'No body';
    await LocalNotificationService().showNotification(title: title, body: body);
  }
}
