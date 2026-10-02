import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infocontract/features/notifications/bloc/cubit/notifications_state.dart';
import 'package:infocontract/features/notifications/domain/service/notification_service.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit({NotificationService? notificationService})
      : _notificationService = notificationService ?? NotificationService(),
        super(const NotificationsState(isLoading: true)) {
    loadNotifications();
  }

  final NotificationService _notificationService;

  void loadNotifications() {
    emit(
      state.copyWith(
        isLoading: false,
        notifications: _notificationService.getNotifications(),
      ),
    );
  }

  void markAsRead(String id) {
    _notificationService.markAsRead(id);
    emit(
      state.copyWith(notifications: _notificationService.getNotifications()),
    );
  }
}
