import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_device_token_usecase.dart';
import '../../domain/usecases/subscribe_to_topic_usecase.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final GetDeviceTokenUseCase getDeviceTokenUseCase;
  final SubscribeToTopicUseCase subscribeToTopicUseCase;

  NotificationBloc(this.getDeviceTokenUseCase, this.subscribeToTopicUseCase)
      : super(NotificationInitial()) {
    on<NotificationInit>(_onInit);
    on<NotificationSubscribe>(_onSubscribe);
  }

  Future<void> _onInit(
      NotificationInit event, Emitter<NotificationState> emit) async {
    emit(NotificationLoading());
    try {
      final token = await getDeviceTokenUseCase();
      emit(NotificationReady(token));
    } catch (e) {
      emit(NotificationError(e.toString()));
    }
  }

  Future<void> _onSubscribe(
      NotificationSubscribe event, Emitter<NotificationState> emit) async {
    try {
      await subscribeToTopicUseCase(event.topic);
    } catch (e) {
      emit(NotificationError(e.toString()));
    }
  }
}
