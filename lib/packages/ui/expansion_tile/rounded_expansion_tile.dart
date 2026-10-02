import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/assets/assets.gen.dart';
import 'bloc/expansion_tile_cubit.dart';

class RoundedExpansionTile extends StatelessWidget {
  final String title;
  final Widget? leading;
  final List<Widget> children;
  final EdgeInsetsGeometry? margin;

  const RoundedExpansionTile({
    super.key,
    required this.title,
    required this.children,
    this.leading,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ExpansionTileCubit(),
      child: BlocBuilder<ExpansionTileCubit, bool>(
        builder: (context, isExpanded) {
          return Container(
            margin:
                margin ??
                const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Theme.of(context).dividerColor.withValues(alpha: 0.3),
              ),
            ),
            child: Theme(
              data: Theme.of(
                context,
              ).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                tilePadding: const EdgeInsets.symmetric(horizontal: 16),
                childrenPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                leading: leading,
                trailing: AnimatedRotation(
                  turns: isExpanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: Assets.svg.profile.arrorDown
                      .svg(), // your arrow icon
                ),
                title: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
                  ),
                ),
                children: children,
                onExpansionChanged: (expanded) {
                  context.read<ExpansionTileCubit>().setExpanded(expanded);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
