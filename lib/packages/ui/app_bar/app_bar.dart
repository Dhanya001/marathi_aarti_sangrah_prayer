import 'package:flutter/material.dart';
import 'package:infocontract/core/constants/assets/assets.gen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool automaticallyImplyLeading;
  final bool centretitlte;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Color? titleColor;
  final double elevation;

  final ValueNotifier<bool>? isSearchEnabled;
  final Widget? searchWidget;

  const CustomAppBar({
    super.key,
    required this.title,
    this.automaticallyImplyLeading = true,
    this.centretitlte = false,
    this.actions,
    this.backgroundColor,
    this.titleColor,
    this.elevation = 0,
    this.isSearchEnabled,
    this.searchWidget
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      centerTitle: centretitlte,
      elevation: elevation,
      title: isSearchEnabled == null
          ? _buildTitle(context)
          : ValueListenableBuilder<bool>(
        valueListenable: isSearchEnabled!,
        builder: (_, isSearching, __) {
          return isSearching
              ? searchWidget ?? Container()
              : _buildTitle(context);
        },
      ),
      actions: actions,
      leading: automaticallyImplyLeading
          ? IconButton(
        onPressed: () => Navigator.of(context).maybePop(),
        icon: Assets.svg.appbar.leftArrow.svg(
            colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.outlineVariant, BlendMode.srcIn)
        ),
      ) : null,

    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 18,
        color: titleColor,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
