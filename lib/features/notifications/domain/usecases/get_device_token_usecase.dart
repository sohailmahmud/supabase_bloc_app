import '../repositories/notification_repository.dart';

class GetDeviceTokenUseCase {
  final NotificationRepository repository;

  GetDeviceTokenUseCase(this.repository);

  Future<String?> call() => repository.getDeviceToken();
}
