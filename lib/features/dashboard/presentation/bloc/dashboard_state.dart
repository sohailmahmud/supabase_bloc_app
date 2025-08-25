part of 'dashboard_bloc.dart';

abstract class DashboardState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final ProfileEntity profile;
  DashboardLoaded(this.profile);
}

class DashboardError extends DashboardState {
  final String message;
  DashboardError(this.message);
}
