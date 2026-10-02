import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infocontract/packages/ui/list/models/list_base_model.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/constants/strings/app_string_constants.dart';
import '../noitemfound/no_item_found.dart';
import 'bloc/paginated_list_imp_bloc.dart';

class PaginatedListImpView<T extends ListBaseModel> extends StatefulWidget {
  final Widget Function(T item) itemBuilder;
  final bool useSliver;
  final Widget? silverWidget;
  final PaginatedImpBloc<T> bloc;
  final Widget? shimmerCard;
  final ScrollController? scrollController;
  final Widget? emptyWidget;
  final bool useSliverWidgetWithLoading;
  final bool useSliverWidgetWithEmptyData;
  final Axis scrollDirection;
  final ScrollPhysics physics;


  const PaginatedListImpView({
    super.key,
    required this.itemBuilder,
    required this.bloc,
    this.useSliver = false,
    this.shimmerCard,
    this.silverWidget,
    this.scrollController,
    this.emptyWidget,
    this.useSliverWidgetWithLoading = false,
    this.useSliverWidgetWithEmptyData = false,
    this.scrollDirection = Axis.vertical,
    this.physics = const ClampingScrollPhysics(),
  });

  @override
  State<PaginatedListImpView<T>> createState() => _PaginatedListImpViewState<T>();
}

class _PaginatedListImpViewState<T extends ListBaseModel>
    extends State<PaginatedListImpView<T>> {
  late final ScrollController _scrollController;
  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController ?? ScrollController();
    _scrollController.addListener(_onScroll);

    if (widget.bloc.state is PaginatedInitial<T>) {
      widget.bloc.add(FetchPaginatedData<T>());
    }
  }

  // @override
  // void dispose() {
  //   _scrollController.removeListener(_onScroll);
  //   _scrollController.dispose();
  //   _refreshController.dispose();
  //   super.dispose();
  // }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (widget.bloc.state is! PaginatedLoading &&
          widget.bloc.state is! PaginatedInitial &&
          widget.bloc.state is! RefreshPaginatedData) {
        widget.bloc.add(FetchPaginatedData<T>());
      }
    }
  }

  Future<void> _onRefresh() async {
    widget.bloc.add(RefreshPaginatedData<T>());
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }

  Future<void> _onLoading() async {
    if (widget.bloc.state is! PaginatedLoading &&
        widget.bloc.state is! PaginatedInitial &&
        widget.bloc.state is! RefreshPaginatedData) {
      widget.bloc.add(FetchPaginatedData<T>());
    }
    await Future.delayed(const Duration(milliseconds: 800));
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaginatedImpBloc<T>, PaginatedImpState<T>>(
      bloc: widget.bloc,
      builder: (context, state) {
        if (state is PaginatedLoading<T>) {
          return _buildShimmerList();
        } else if (state is PaginatedLoaded<T>) {
          final childCount = state.items.length + (state.hasMore ? 1 : 0);

          if (childCount == 0) {
            if (widget.emptyWidget != null) {
              return widget.emptyWidget!;
            }

            if (widget.useSliver) {
              return CustomScrollView(
                slivers: [
                  if (widget.useSliverWidgetWithLoading &&
                      widget.silverWidget != null)
                    widget.silverWidget!,
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        NoItemFound(
                          title: AppString.noItemsToSee,
                          subtitle: AppString.noDataFound,
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton.icon(
                          icon: const Icon(Icons.refresh),
                          label: Text(AppString.refresh),
                          onPressed: () {
                            widget.bloc.add(
                              RefreshPaginatedData<T>(showLoading: true),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NoItemFound(
                    title: AppString.noItemsToSee,
                    subtitle: AppString.noDataFound,
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.refresh),
                    label: Text(AppString.refresh),
                    onPressed: () {
                      widget.bloc.add(
                        RefreshPaginatedData<T>(showLoading: true),
                      );
                    },
                  ),
                ],
              );
            }
          }

          if (widget.useSliver) {
            return SmartRefresher(
              controller: _refreshController,
              enablePullDown: true,
              // physics: const AlwaysScrollableScrollPhysics(),
              // enablePullUp: state.hasMore,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              header: WaterDropHeader(
                waterDropColor: Theme.of(context).colorScheme.primary,
                idleIcon: Icon(
                  Icons.autorenew,
                  size: 15,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ), // footer: const ClassicFooter(),
              child: CustomScrollView(
                controller: widget.scrollController == null
                    ? _scrollController
                    : null,
                // primary: false,
                physics: widget.physics,
                slivers: [
                  if (widget.silverWidget != null) widget.silverWidget!,
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      if (index < state.items.length) {
                        return widget.itemBuilder(state.items[index]);
                      }
                      return const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                      );
                    }, childCount: childCount),
                  ),
                ],
              ),
            );
          } else {
            return SmartRefresher(
              controller: _refreshController,
              enablePullDown: true,
              // enablePullUp: state.hasMore,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              header: WaterDropHeader(
                waterDropColor: Theme.of(context).colorScheme.primary,
                idleIcon: Icon(
                  Icons.autorenew,
                  size: 15,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              // footer: const ClassicFooter(),
              child: ListView.builder(
                controller: _scrollController,
                scrollDirection: widget.scrollDirection,
                primary: false,
                physics: widget.physics,
                itemCount: childCount,
                itemBuilder: (_, index) {
                  if (index < state.items.length) {
                    return widget.itemBuilder(state.items[index]);
                  }
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator.adaptive()),
                  );
                },
              ),
            );
          }
        } else if (state is PaginatedError<T>) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 48,
                  color: Colors.redAccent,
                ),
                const SizedBox(height: 12),
                Text(
                  state.message,
                  style: const TextStyle(fontSize: 16, color: Colors.redAccent),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  icon: const Icon(Icons.refresh),
                  label: Text(AppString.retry),
                  onPressed: () {
                    widget.bloc.add(FetchPaginatedData<T>());
                  },
                ),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildShimmerList() {
    if (widget.useSliver) {
      return CustomScrollView(
        slivers: [
          if (widget.useSliverWidgetWithLoading && widget.silverWidget != null)
            Skeletonizer.sliver(child: widget.silverWidget!),
          Skeletonizer.sliver(
            child: SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, __) => widget.shimmerCard ?? _defaultShimmerCard(),
                childCount: 10,
              ),
            ),
          ),
        ],
      );
    } else {
      return Skeletonizer(
        enabled: true,
        child: ListView.builder(
          scrollDirection: widget.scrollDirection,
          itemCount: 10,
          itemBuilder: (_, __) => widget.shimmerCard ?? _defaultShimmerCard(),
        ),
      );
    }
  }

  Widget _defaultShimmerCard() {
    return const ListTile(
      leading: CircleAvatar(backgroundColor: Colors.grey),
      title: SizedBox(height: 10, child: ColoredBox(color: Colors.grey)),
      subtitle: SizedBox(height: 10, child: ColoredBox(color: Colors.grey)),
    );
  }
}
