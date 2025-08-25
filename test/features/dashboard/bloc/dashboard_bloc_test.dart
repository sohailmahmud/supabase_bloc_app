import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_bloc_app/features/dashboard/domain/entities/profile_entity.dart';
import 'package:supabase_bloc_app/features/dashboard/domain/usecases/get_profile_usecase.dart';
import 'package:supabase_bloc_app/features/dashboard/presentation/bloc/dashboard_bloc.dart';

class _MockGetProfileUseCase extends Mock implements GetProfileUseCase {}

void main() {
  late _MockGetProfileUseCase mockGetProfile;
  late DashboardBloc bloc;

  setUp(() {
    mockGetProfile = _MockGetProfileUseCase();
    bloc = DashboardBloc(mockGetProfile);
  });

  test('initial state is DashboardInitial', () {
    expect(bloc.state, isA<DashboardInitial>());
  });

  test('emits Loading then Loaded on success', () async {
    final profile = ProfileEntity(
      id: 'u1',
      username: 'john',
      createdAt: DateTime(2023, 1, 1),
    );

    when(() => mockGetProfile.call('u1')).thenAnswer((_) async => profile);

    expectLater(
      bloc.stream,
      emitsInOrder([
        isA<DashboardLoading>(),
        isA<DashboardLoaded>().having((s) => s.profile, 'profile', profile),
      ]),
    );

    bloc.add(DashboardLoad('u1'));
  });

  test('emits Loading then Error when profile not found', () async {
    when(() => mockGetProfile.call('missing')).thenAnswer((_) async => null);

    expectLater(
      bloc.stream,
      emitsInOrder([
        isA<DashboardLoading>(),
        isA<DashboardError>(),
      ]),
    );

    bloc.add(DashboardLoad('missing'));
  });

  test('emits Loading then Error on exception', () async {
    when(() => mockGetProfile.call('boom')).thenThrow(Exception('boom'));

    expectLater(
      bloc.stream,
      emitsInOrder([
        isA<DashboardLoading>(),
        isA<DashboardError>(),
      ]),
    );

    bloc.add(DashboardLoad('boom'));
  });
}
