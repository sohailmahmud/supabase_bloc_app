import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;

  AuthRepositoryImpl(this.remote);

  @override
  Future<String> login({required String email, required String password}) async {
    final user = await remote.login(email, password);
    return user.id;
  }

  @override
  Future<void> logout() {
    return remote.logout();
  }

  @override
  Future<String?> getCurrentUserId() async {
    final user = await remote.getCurrentUser();
    return user?.id;
  }
}
