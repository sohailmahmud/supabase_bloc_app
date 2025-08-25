import '../../domain/repositories/notification_repository.dart';
import '../datasources/notification_remote_datasource.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource remote;

  NotificationRepositoryImpl(this.remote);

  @override
  Future<String?> getDeviceToken() => remote.getToken();

  @override
  Future<void> subscribeToTopic(String topic) => remote.subscribeToTopic(topic);
}
