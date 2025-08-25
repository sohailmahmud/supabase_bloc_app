abstract class NotificationRepository {
  Future<String?> getDeviceToken();
  Future<void> subscribeToTopic(String topic);
}
