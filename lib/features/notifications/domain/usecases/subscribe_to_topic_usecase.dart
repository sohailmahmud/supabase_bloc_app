import '../repositories/notification_repository.dart';

class SubscribeToTopicUseCase {
  final NotificationRepository repository;

  SubscribeToTopicUseCase(this.repository);

  Future<void> call(String topic) => repository.subscribeToTopic(topic);
}
