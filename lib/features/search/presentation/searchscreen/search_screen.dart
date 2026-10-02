import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infocontract/features/aarti/presentation/aarti_navigation.dart';
import 'package:infocontract/features/home/presentation/widgets/component/aarti_colors.dart';
import 'package:infocontract/features/search/bloc/cubit/search_cubit.dart';
import 'package:infocontract/features/search/bloc/cubit/search_state.dart';
import 'package:infocontract/features/search/presentation/widgets/component/quick_search_section.dart';
import 'package:infocontract/features/search/presentation/widgets/component/search_aarti_tile.dart';
import 'package:infocontract/features/search/presentation/widgets/component/search_bar_field.dart';
import 'package:infocontract/features/search/presentation/widgets/component/search_chip_row.dart';

@RoutePage()
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchCubit(),
      child: const _SearchView(),
    );
  }
}

class _SearchView extends StatefulWidget {
  const _SearchView();

  @override
  State<_SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<_SearchView> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _setQuery(String query) {
    _controller.text = query;
    _controller.selection = TextSelection.collapsed(offset: query.length);
  }

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
        toolbarHeight: 72,
        title: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const _Flourish(),
                const SizedBox(width: 8),
                Text(
                  'searchTitle'.tr(),
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
              'searchSubtitle'.tr(),
              style: const TextStyle(
                color: AartiColors.textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
      body: BlocConsumer<SearchCubit, SearchState>(
        listenWhen: (previous, current) => previous.query != current.query,
        listener: (context, state) {
          if (_controller.text != state.query) {
            _setQuery(state.query);
          }
        },
        builder: (context, state) {
          final cubit = context.read<SearchCubit>();

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                child: SearchBarField(
                  controller: _controller,
                  onChanged: cubit.onQueryChanged,
                  onSubmitted: cubit.submitQuery,
                  onClear: () {
                    _controller.clear();
                    cubit.clearQuery();
                  },
                ),
              ),
              Expanded(
                child: state.isSearching
                    ? _ResultsBody(state: state)
                    : _DefaultBody(state: state),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _DefaultBody extends StatelessWidget {
  const _DefaultBody({required this.state});

  final SearchState state;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SearchCubit>();

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      children: [
        QuickSearchSection(
          items: state.quickSearchItems,
          onTap: (item) => cubit.applyQuickSearch(item.id, item.labelKey.tr()),
        ),
        const SizedBox(height: 20),
        SearchChipRow(
          titleKey: 'searchRecent',
          labels: state.recentSearches,
          leadingIcon: Icons.history_rounded,
          trailingIcon: Icons.close_rounded,
          onTap: cubit.applySuggestion,
          onTrailingTap: cubit.removeRecent,
          actionLabelKey: 'searchClearAll',
          onActionTap: cubit.clearRecent,
        ),
        if (state.recentSearches.isNotEmpty) const SizedBox(height: 20),
        SearchChipRow(
          titleKey: 'searchPopular',
          labels: state.popularQueryKeys.map((key) => key.tr()).toList(),
          leadingIcon: Icons.local_fire_department_rounded,
          onTap: cubit.applySuggestion,
        ),
        const SizedBox(height: 24),
        Text(
          'popularAartis'.tr(),
          style: const TextStyle(
            color: AartiColors.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        ...state.popularAartis.map(
          (item) => SearchAartiTile(
            item: item,
            onTap: () => openAartiDetail(context, item.aarti.id),
          ),
        ),
      ],
    );
  }
}

class _ResultsBody extends StatelessWidget {
  const _ResultsBody({required this.state});

  final SearchState state;

  @override
  Widget build(BuildContext context) {
    if (state.results.isEmpty) {
      return Center(
        child: Text(
          'searchNoResults'.tr(),
          style: const TextStyle(
            color: AartiColors.textSecondary,
            fontSize: 15,
          ),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      children: [
        Text(
          'searchResults'.tr(),
          style: const TextStyle(
            color: AartiColors.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        ...state.results.map(
          (item) => SearchAartiTile(
            item: item,
            onTap: () => openAartiDetail(context, item.aarti.id),
          ),
        ),
      ],
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
