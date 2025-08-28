import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_bloc_app/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:supabase_bloc_app/features/dashboard/data/models/profile_model.dart';
import 'package:supabase_bloc_app/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:supabase_bloc_app/features/dashboard/domain/entities/profile_entity.dart';

class _MockDashboardRemoteDataSource extends Mock
    implements DashboardRemoteDataSource {}

void main() {
  late _MockDashboardRemoteDataSource mockRemote;
  late DashboardRepositoryImpl repository;

  setUp(() {
    mockRemote = _MockDashboardRemoteDataSource();
    repository = DashboardRepositoryImpl(mockRemote);
  });

  group('DashboardRepositoryImpl', () {
    test('getProfile returns ProfileEntity when found', () async {
      final model = ProfileModel(
        id: 'u1',
        username: 'john',
        createdAt: DateTime(2023, 1, 1),
      );
      when(() => mockRemote.getProfile('u1')).thenAnswer((_) async => model);

      final ProfileEntity? result = await repository.getProfile('u1');

      expect(result, isA<ProfileEntity>());
      expect(result?.id, 'u1');
      expect(result?.username, 'john');
      verify(() => mockRemote.getProfile('u1')).called(1);
      verifyNoMoreInteractions(mockRemote);
    });

    test('getProfile returns null when not found', () async {
      when(() => mockRemote.getProfile('missing')).thenAnswer((_) async => null);

      final result = await repository.getProfile('missing');

      expect(result, isNull);
      verify(() => mockRemote.getProfile('missing')).called(1);
      verifyNoMoreInteractions(mockRemote);
    });
  });
}


