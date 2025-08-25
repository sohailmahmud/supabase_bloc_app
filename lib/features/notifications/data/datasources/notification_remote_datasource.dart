import 'package:firebase_messaging/firebase_messaging.dart';

abstract class NotificationRemoteDataSource {
  Future<String?> getToken();
  Future<void> subscribeToTopic(String topic);
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final FirebaseMessaging messaging;

  NotificationRemoteDataSourceImpl(this.messaging);

  @override
  Future<String?> getToken() => messaging.getToken();

  @override
  Future<void> subscribeToTopic(String topic) => messaging.subscribeToTopic(topic);
}
