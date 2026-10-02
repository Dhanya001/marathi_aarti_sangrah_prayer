import 'package:infocontract/features/notifications/domain/model/notification_icon_type.dart';
import 'package:infocontract/features/notifications/domain/model/notification_model.dart';

class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();

  factory NotificationService() => instance;

  late List<NotificationModel> _notifications = _seed();

  List<NotificationModel> getNotifications() => List.unmodifiable(_notifications);

  bool get hasUnread => _notifications.any((item) => !item.isRead);

  void markAsRead(String id) {
    _notifications = _notifications
        .map((item) => item.id == id ? item.copyWith(isRead: true) : item)
        .toList();
  }

  List<NotificationModel> _seed() {
    final now = DateTime.now();
    return [
      NotificationModel(
        id: '1',
        titleKey: 'notifNewAartiTitle',
        descriptionKey: 'notifNewAartiDesc',
        iconType: NotificationIconType.diya,
        createdAt: now.subtract(const Duration(minutes: 2)),
      ),
      NotificationModel(
        id: '2',
        titleKey: 'notifRamNavamiTitle',
        descriptionKey: 'notifRamNavamiDesc',
        iconType: NotificationIconType.lotus,
        createdAt: now.subtract(const Duration(hours: 1)),
      ),
      NotificationModel(
        id: '3',
        titleKey: 'notifAppUpdateTitle',
        descriptionKey: 'notifAppUpdateDesc',
        iconType: NotificationIconType.megaphone,
        createdAt: now.subtract(const Duration(hours: 5)),
      ),
      NotificationModel(
        id: '4',
        titleKey: 'notifGuruPurnimaTitle',
        descriptionKey: 'notifGuruPurnimaDesc',
        iconType: NotificationIconType.mandala,
        createdAt: now.subtract(const Duration(days: 1)),
        isRead: true,
      ),
      NotificationModel(
        id: '5',
        titleKey: 'notifThanksTitle',
        descriptionKey: 'notifThanksDesc',
        iconType: NotificationIconType.heart,
        createdAt: now.subtract(const Duration(days: 2)),
        isRead: true,
      ),
      NotificationModel(
        id: '6',
        titleKey: 'notifFeatureTitle',
        descriptionKey: 'notifFeatureDesc',
        iconType: NotificationIconType.star,
        createdAt: now.subtract(const Duration(days: 5)),
        isRead: true,
      ),
      NotificationModel(
        id: '7',
        titleKey: 'notifShareTitle',
        descriptionKey: 'notifShareDesc',
        iconType: NotificationIconType.share,
        createdAt: now.subtract(const Duration(days: 7)),
        isRead: true,
      ),
    ];
  }
}
