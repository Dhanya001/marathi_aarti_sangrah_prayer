import 'package:equatable/equatable.dart';
import 'package:infocontract/features/notifications/domain/model/notification_model.dart';

class NotificationsState extends Equatable {
  const NotificationsState({
    this.notifications = const [],
    this.isLoading = false,
  });

  final List<NotificationModel> notifications;
  final bool isLoading;

  List<NotificationModel> get newNotifications =>
      notifications.where((item) => !item.isRead).toList();

  List<NotificationModel> get previousNotifications =>
      notifications.where((item) => item.isRead).toList();

  NotificationsState copyWith({
    List<NotificationModel>? notifications,
    bool? isLoading,
  }) {
    return NotificationsState(
      notifications: notifications ?? this.notifications,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [notifications, isLoading];
}
