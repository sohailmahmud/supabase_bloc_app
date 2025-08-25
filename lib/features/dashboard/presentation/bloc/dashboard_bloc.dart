import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/usecases/get_profile_usecase.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetProfileUseCase getProfileUseCase;

  DashboardBloc(this.getProfileUseCase) : super(DashboardInitial()) {
    on<DashboardLoad>(_onLoad);
  }

  Future<void> _onLoad(
      DashboardLoad event, Emitter<DashboardState> emit) async {
    emit(DashboardLoading());
    try {
      final profile = await getProfileUseCase(event.userId);
      if (profile != null) {
        emit(DashboardLoaded(profile));
      } else {
        emit(DashboardError("Profile not found"));
      }
    } catch (e) {
      emit(DashboardError(e.toString()));
    }
  }
}
