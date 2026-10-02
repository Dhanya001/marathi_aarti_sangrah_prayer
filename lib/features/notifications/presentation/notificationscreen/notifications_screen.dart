import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infocontract/features/home/presentation/widgets/component/aarti_colors.dart';
import 'package:infocontract/features/notifications/bloc/cubit/notifications_cubit.dart';
import 'package:infocontract/features/notifications/bloc/cubit/notifications_state.dart';
import 'package:infocontract/features/notifications/presentation/widgets/component/notification_section_header.dart';
import 'package:infocontract/features/notifications/presentation/widgets/component/notification_tile.dart';

@RoutePage()
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NotificationsCubit(),
      child: const _NotificationsView(),
    );
  }
}

class _NotificationsView extends StatelessWidget {
  const _NotificationsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AartiColors.background,
      appBar: AppBar(
        backgroundColor: AartiColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () => context.router.maybePop(),
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: AartiColors.textPrimary,
          ),
        ),
        centerTitle: true,
        title: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const _Flourish(),
                const SizedBox(width: 8),
                Text(
                  'notificationsTitle'.tr(),
                  style: const TextStyle(
                    color: AartiColors.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(width: 8),
                const _Flourish(),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'notificationsSubtitle'.tr(),
              style: const TextStyle(
                color: AartiColors.textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        toolbarHeight: 72,
      ),
      body: BlocBuilder<NotificationsCubit, NotificationsState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AartiColors.primary),
            );
          }

          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
            children: [
              if (state.newNotifications.isNotEmpty) ...[
                const NotificationSectionHeader(titleKey: 'notificationsNew'),
                ...state.newNotifications.map(
                  (item) => NotificationTile(
                    notification: item,
                    onTap: () =>
                        context.read<NotificationsCubit>().markAsRead(item.id),
                  ),
                ),
                const SizedBox(height: 8),
              ],
              if (state.previousNotifications.isNotEmpty) ...[
                const NotificationSectionHeader(
                  titleKey: 'notificationsPrevious',
                ),
                ...state.previousNotifications.map(
                  (item) => NotificationTile(
                    notification: item,
                    onTap: () =>
                        context.read<NotificationsCubit>().markAsRead(item.id),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _Flourish extends StatelessWidget {
  const _Flourish();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 28,
      height: 10,
      child: CustomPaint(painter: _FlourishPainter()),
    );
  }
}

class _FlourishPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFD4A017)
      ..strokeWidth = 1.4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path()
      ..moveTo(0, size.height / 2)
      ..quadraticBezierTo(size.width / 2, 0, size.width, size.height / 2);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
