import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_bloc_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:supabase_bloc_app/features/auth/domain/usecases/login_usecase.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late _MockAuthRepository mockRepo;
  late LoginUseCase usecase;

  setUp(() {
    mockRepo = _MockAuthRepository();
    usecase = LoginUseCase(mockRepo);
  });

  test('returns userId from repository', () async {
    when(() => mockRepo.login(email: 'a@b.c', password: 'pw'))
        .thenAnswer((_) async => 'uid-1');

    final result = await usecase(email: 'a@b.c', password: 'pw');

    expect(result, 'uid-1');
    verify(() => mockRepo.login(email: 'a@b.c', password: 'pw')).called(1);
    verifyNoMoreInteractions(mockRepo);
  });

  test('propagates exceptions from repository', () async {
    when(() => mockRepo.login(email: any(named: 'email'), password: any(named: 'password')))
        .thenThrow(Exception('bad creds'));

    expect(
      () => usecase(email: 'x@y.z', password: 'nope'),
      throwsA(isA<Exception>()),
    );
  });
}


