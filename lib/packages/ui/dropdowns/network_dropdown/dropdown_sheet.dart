import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infocontract/packages/theme/app_colors.dart';
import 'package:infocontract/packages/ui/dropdowns/network_dropdown/bloc/network_dropdown_bloc.dart';
import 'package:infocontract/packages/ui/dropdowns/network_dropdown/dropdown_menu_item_model.dart';
import 'package:infocontract/packages/ui/spacers/vertical_spacer.dart';


void showSmartDropdownSheet({
  required BuildContext context,
  required String label,
  String? endpoint,
  required String labelKey,
  required String idKey,
  required List<DropdownMenuItemModel> selectedItems,
  required Function(List<DropdownMenuItemModel>) onChanged,
  required String title,
  bool isMultiSelect = false,
  bool showSearch = false,
  List<DropdownMenuItemModel>? offlineItems,
  Map<String, dynamic>? queryParam,
}) {
  List<DropdownMenuItemModel> currentSelectedItems = selectedItems;
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    isDismissible: true,
    builder: (_) {
      if (offlineItems != null) {
        // Offline data, no Bloc needed
        return _SmartDropdownSheetWrapper(
          label: label,
          selectedItems: selectedItems,
          onChanged: (selected) {
            currentSelectedItems = selected;
          },
          isMultiSelect: isMultiSelect,
          showSearch: showSearch,
          title: title,
          labelKey: labelKey,
          offlineItems: offlineItems,
        );
      } else {
        // Network data, use Bloc
        return BlocProvider(
          create: (_) => SmartDropdownCubit(
            endpoint: endpoint ?? '',
            labelKey: labelKey,
            idKey: idKey,
            queryParam: queryParam,
          )..loadItems(),
          child: _SmartDropdownSheetWrapper(
            label: label,
            selectedItems: selectedItems,
            onChanged: (selected) {
              currentSelectedItems = selected;
            },
            isMultiSelect: isMultiSelect,
            showSearch: showSearch,
            title: title,
            labelKey: labelKey,
            offlineItems: null,
          ),
        );
      }
    },
  ).then((value) {
    onChanged(currentSelectedItems);
  });
}

class _SmartDropdownSheetWrapper extends StatelessWidget {
  final String label;
  final List<DropdownMenuItemModel> selectedItems;
  final Function(List<DropdownMenuItemModel>) onChanged;
  final bool isMultiSelect;
  final bool showSearch;
  final String title;
  final String labelKey;
  final List<DropdownMenuItemModel>? offlineItems;

  const _SmartDropdownSheetWrapper({
    required this.label,
    required this.selectedItems,
    required this.onChanged,
    required this.isMultiSelect,
    required this.showSearch,
    required this.title,
    required this.labelKey,
    this.offlineItems,
  });

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets;

    return AnimatedPadding(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      padding: EdgeInsets.only(bottom: viewInsets.bottom),
      child: DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: _SmartDropdownSheetContent(
              label: label,
              selectedItems: selectedItems,
              onChanged: onChanged,
              isMultiSelect: isMultiSelect,
              showSearch: showSearch,
              scrollController: scrollController,
              title: title,
              labelKey: labelKey,
              offlineItems: offlineItems,
            ),
          );
        },
      ),
    );
  }
}

class _SmartDropdownSheetContent extends StatefulWidget {
  final String label;
  final List<DropdownMenuItemModel> selectedItems;
  final Function(List<DropdownMenuItemModel>) onChanged;
  final bool isMultiSelect;
  final bool showSearch;
  final ScrollController scrollController;
  final String title;
  final String labelKey;
  final List<DropdownMenuItemModel>? offlineItems;

  const _SmartDropdownSheetContent({
    required this.label,
    required this.selectedItems,
    required this.onChanged,
    required this.isMultiSelect,
    required this.showSearch,
    required this.scrollController,
    required this.title,
    required this.labelKey,
    this.offlineItems,
  });

  @override
  State<_SmartDropdownSheetContent> createState() =>
      _SmartDropdownSheetContentState();
}

class _SmartDropdownSheetContentState
    extends State<_SmartDropdownSheetContent> {
  late List<DropdownMenuItemModel> _tempSelected;
  String _search = '';

  @override
  void initState() {
    _tempSelected = [...widget.selectedItems];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.offlineItems;
    return Column(
      children: [
        const SizedBox(height: 12),
        Container(
          width: 70,
          height: 5,
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.light
                ? AppColors.gray
                : AppColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const VSpacer(12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                widget.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Done",
                style: TextStyle(
                  color: AppColors.darkBlue,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const VSpacer(8),
        // Optional Search
        if (widget.showSearch)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search ",
                hintStyle: const TextStyle(
                  color: AppColors.gray,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.gray,
                  size: 28,
                ),
                filled: true,
                fillColor: const Color(0xFFF5F5F5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (val) => setState(() => _search = val),
            ),
          ),

        const SizedBox(height: 8),

        // List
        Expanded(
          child: items != null
              ? _buildOfflineList(items)
              : BlocBuilder<SmartDropdownCubit, NetworkDropdownState>(
                  builder: (context, state) {
                    if (state is DropdownLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is DropdownError) {
                      return Center(child: Text(state.message));
                    } else if (state is DropdownLoaded) {
                      final filtered = state.items
                          .where(
                            (e) => e.title.toLowerCase().contains(
                              _search.toLowerCase(),
                            ),
                          )
                          .toList();

                      if (filtered.isEmpty) {
                        return const Center(child: Text("No matching results"));
                      }

                      return CupertinoScrollbar(
                        controller: widget.scrollController,
                        thumbVisibility: true,
                        radius: const Radius.circular(10),
                        thickness: 6,
                        child: ListView.builder(
                          controller: widget.scrollController,
                          itemCount: filtered.length,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          itemBuilder: (_, index) {
                            final item = filtered[index];
                            final isSelected = _tempSelected.any(
                              (e) => e.id == item.id,
                            );

                            return _buildListTile(item, isSelected);
                          },
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildOfflineList(List<DropdownMenuItemModel> items) {
    final filtered = items
        .where((e) => e.title.toLowerCase().contains(_search.toLowerCase()))
        .toList();

    if (filtered.isEmpty) {
      return const Center(child: Text("No matching results"));
    }

    return CupertinoScrollbar(
      controller: widget.scrollController,
      thumbVisibility: true,
      radius: const Radius.circular(10),
      thickness: 6,
      child: ListView.builder(
        controller: widget.scrollController,
        itemCount: filtered.length,
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemBuilder: (_, index) {
          final item = filtered[index];
          final isSelected = _tempSelected.any((e) => e.id == item.id);
          return _buildListTile(item, isSelected);
        },
      ),
    );
  }

  Widget _buildListTile(DropdownMenuItemModel item, bool isSelected) {
    return ListTile(
      title: Text(item.title, style: Theme.of(context).textTheme.bodyLarge),
      trailing: Checkbox(
        value: isSelected,
        checkColor: Colors.white,
        activeColor: Colors.green,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        side: BorderSide(
          color: isSelected
              ? Colors.green
              : Theme.of(context).colorScheme.primary,
          width: 2,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        onChanged: (_) {
          if (widget.isMultiSelect) {
            setState(() {
              isSelected
                  ? _tempSelected.removeWhere((e) => e.id == item.id)
                  : _tempSelected.add(item);
            });
          } else {
            setState(() {
              _tempSelected.clear();
              _tempSelected.add(item);
            });
          }
          widget.onChanged(_tempSelected);
        },
      ),
      onTap: () {
        if (widget.isMultiSelect) {
          setState(() {
            isSelected
                ? _tempSelected.removeWhere((e) => e.id == item.id)
                : _tempSelected.add(item);
          });
        } else {
          setState(() {
            _tempSelected.clear();
            _tempSelected.add(item);
          });
        }
        widget.onChanged(_tempSelected);
      },
    );
  }
}
