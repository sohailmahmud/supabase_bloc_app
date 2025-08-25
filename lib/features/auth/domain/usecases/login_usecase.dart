import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<String> call({required String email, required String password}) {
    return repository.login(email: email, password: password);
  }
}
