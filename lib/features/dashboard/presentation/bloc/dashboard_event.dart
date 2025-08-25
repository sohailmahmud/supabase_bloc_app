part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class DashboardLoad extends DashboardEvent {
  final String userId;
  DashboardLoad(this.userId);
}
