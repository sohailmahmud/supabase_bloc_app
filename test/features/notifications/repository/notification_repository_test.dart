import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_bloc_app/features/notifications/data/datasources/notification_remote_datasource.dart';
import 'package:supabase_bloc_app/features/notifications/data/repositories/notification_repository_impl.dart';

class _MockNotificationRemoteDataSource extends Mock
    implements NotificationRemoteDataSource {}

void main() {
  late _MockNotificationRemoteDataSource mockRemote;
  late NotificationRepositoryImpl repository;

  setUp(() {
    mockRemote = _MockNotificationRemoteDataSource();
    repository = NotificationRepositoryImpl(mockRemote);
  });

  group('NotificationRepositoryImpl', () {
    test('getDeviceToken returns token from remote', () async {
      when(() => mockRemote.getToken()).thenAnswer((_) async => 'abc123');

      final token = await repository.getDeviceToken();

      expect(token, 'abc123');
      verify(() => mockRemote.getToken()).called(1);
      verifyNoMoreInteractions(mockRemote);
    });

    test('subscribeToTopic delegates to remote', () async {
      when(() => mockRemote.subscribeToTopic('all')).thenAnswer((_) async {});

      await repository.subscribeToTopic('all');

      verify(() => mockRemote.subscribeToTopic('all')).called(1);
      verifyNoMoreInteractions(mockRemote);
    });
  });
}


