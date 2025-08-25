import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../datasources/dashboard_remote_datasource.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource remote;

  DashboardRepositoryImpl(this.remote);

  @override
  Future<ProfileEntity?> getProfile(String userId) {
    return remote.getProfile(userId);
  }
}
