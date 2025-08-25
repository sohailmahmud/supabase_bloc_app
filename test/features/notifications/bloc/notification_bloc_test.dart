import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_bloc_app/features/notifications/domain/usecases/get_device_token_usecase.dart';
import 'package:supabase_bloc_app/features/notifications/domain/usecases/subscribe_to_topic_usecase.dart';
import 'package:supabase_bloc_app/features/notifications/presentation/bloc/notification_bloc.dart';

class _MockGetDeviceTokenUseCase extends Mock implements GetDeviceTokenUseCase {}
class _MockSubscribeToTopicUseCase extends Mock implements SubscribeToTopicUseCase {}

void main() {
  late _MockGetDeviceTokenUseCase mockGetToken;
  late _MockSubscribeToTopicUseCase mockSubscribe;
  late NotificationBloc bloc;

  setUp(() {
    mockGetToken = _MockGetDeviceTokenUseCase();
    mockSubscribe = _MockSubscribeToTopicUseCase();
    bloc = NotificationBloc(mockGetToken, mockSubscribe);
  });

  test('initial state is NotificationInitial', () {
    expect(bloc.state, isA<NotificationInitial>());
  });

  test('emits Loading then Ready on init success', () async {
    when(() => mockGetToken.call()).thenAnswer((_) async => 'token-123');

    expectLater(
      bloc.stream,
      emitsInOrder([
        isA<NotificationLoading>(),
        isA<NotificationReady>().having((s) => s.token, 'token', 'token-123'),
      ]),
    );

    bloc.add(NotificationInit());
  });

  test('emits Loading then Error on init failure', () async {
    when(() => mockGetToken.call()).thenThrow(Exception('no perm'));

    expectLater(
      bloc.stream,
      emitsInOrder([
        isA<NotificationLoading>(),
        isA<NotificationError>(),
      ]),
    );

    bloc.add(NotificationInit());
  });

  test('subscribe handles success (no state change except errors)', () async {
    when(() => mockSubscribe.call('all')).thenAnswer((_) async {});

    expectLater(
      bloc.stream,
      emitsDone,
    );

    // Trigger and then close to end the stream for this test
    bloc.add(NotificationSubscribe('all'));
    await Future<void>.delayed(const Duration(milliseconds: 10));
    await bloc.close();
  });

  test('subscribe emits Error on failure', () async {
    bloc = NotificationBloc(mockGetToken, mockSubscribe);
    when(() => mockSubscribe.call('all')).thenThrow(Exception('sub fail'));

    expectLater(
      bloc.stream,
      emitsInOrder([
        isA<NotificationError>(),
      ]),
    );

    bloc.add(NotificationSubscribe('all'));
  });
}


