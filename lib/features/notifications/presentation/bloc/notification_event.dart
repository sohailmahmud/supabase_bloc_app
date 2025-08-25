part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class NotificationInit extends NotificationEvent {}
class NotificationSubscribe extends NotificationEvent {
  final String topic;
  NotificationSubscribe(this.topic);
}
