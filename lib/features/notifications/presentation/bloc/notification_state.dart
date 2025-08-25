part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationReady extends NotificationState {
  final String? token;
  NotificationReady(this.token);
}

class NotificationError extends NotificationState {
  final String message;
  NotificationError(this.message);
}
