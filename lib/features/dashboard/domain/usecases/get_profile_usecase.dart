import '../entities/profile_entity.dart';
import '../repositories/dashboard_repository.dart';

class GetProfileUseCase {
  final DashboardRepository repository;

  GetProfileUseCase(this.repository);

  Future<ProfileEntity?> call(String userId) {
    return repository.getProfile(userId);
  }
}
