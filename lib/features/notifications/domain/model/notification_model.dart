import 'package:equatable/equatable.dart';
import 'package:infocontract/features/notifications/domain/model/notification_icon_type.dart';

class NotificationModel extends Equatable {
  const NotificationModel({
    required this.id,
    required this.titleKey,
    required this.descriptionKey,
    required this.iconType,
    required this.createdAt,
    this.isRead = false,
  });

  final String id;
  final String titleKey;
  final String descriptionKey;
  final NotificationIconType iconType;
  final DateTime createdAt;
  final bool isRead;

  NotificationModel copyWith({bool? isRead}) {
    return NotificationModel(
      id: id,
      titleKey: titleKey,
      descriptionKey: descriptionKey,
      iconType: iconType,
      createdAt: createdAt,
      isRead: isRead ?? this.isRead,
    );
  }

  @override
  List<Object?> get props => [
        id,
        titleKey,
        descriptionKey,
        iconType,
        createdAt,
        isRead,
      ];
}
