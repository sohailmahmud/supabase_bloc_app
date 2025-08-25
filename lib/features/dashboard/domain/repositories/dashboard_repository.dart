import '../entities/profile_entity.dart';

abstract class DashboardRepository {
  Future<ProfileEntity?> getProfile(String userId);
}
