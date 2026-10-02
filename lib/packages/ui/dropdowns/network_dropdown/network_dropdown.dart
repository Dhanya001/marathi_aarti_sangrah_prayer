import 'package:flutter/material.dart';
import 'package:infocontract/core/constants/assets/fonts.gen.dart';
import 'package:infocontract/packages/theme/app_colors.dart';
import 'package:infocontract/packages/theme/app_text_styles.dart';
import 'package:infocontract/packages/ui/dropdowns/network_dropdown/dropdown_menu_item_model.dart';
import 'package:infocontract/packages/ui/dropdowns/network_dropdown/dropdown_sheet.dart';
import 'package:infocontract/packages/ui/spacers/vertical_spacer.dart';


class SmartDropdownField extends FormField<List<DropdownMenuItemModel>> {
  SmartDropdownField({
    super.key,
    required String label,
    String endpoint = '',
    bool showLabel = false,
    String labelKey = "title",
    String idKey = "id",
    required List<DropdownMenuItemModel> selectedItems,
    required Function(List<DropdownMenuItemModel>) onChanged,
    bool isMultiSelect = false,
    bool showSearch = true,
    Widget? prefixIcon,
    Widget? suffixIcon,
    bool isRequired = false,
    FormFieldValidator<List<DropdownMenuItemModel>>? validator,
    List<DropdownMenuItemModel>? offlineItems,
    Map<String, dynamic>? queryParam,
  }) : super(
         initialValue: List<DropdownMenuItemModel>.from(selectedItems),
         validator:
             validator ??
             (isRequired
                 ? (value) => value == null || value.isEmpty
                       ? 'Please select ${label.toLowerCase()}'
                       : null
                 : null),
         builder: (FormFieldState<List<DropdownMenuItemModel>> field) {
           //  if (!isRequired && selectedItems.isEmpty) {
           //    field.didChange(selectedItems);
           //  }
           final bool isDarkTheme =
               Theme.of(field.context).brightness == Brightness.dark;

           final errorText = field.errorText;

           return Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               if (showLabel)
                 Text(
                   label,
                   style: Theme.of(field.context).textTheme.titleSmall
                       ?.copyWith(fontSize: 17, fontWeight: FontWeight.w600),
                 ),
               if (showLabel) const VSpacer(6),
               GestureDetector(
                 onTap: () {
                   if (offlineItems != null) {
                     // Show sheet with offline data
                     showSmartDropdownSheet(
                       context: field.context,
                       label: label,
                       offlineItems: offlineItems,
                       labelKey: labelKey,
                       idKey: idKey,
                       selectedItems: field.value ?? [],
                       onChanged: (selected) {
                         field.didChange(selected);
                         onChanged(selected);
                         if (isRequired) {
                           field.validate();
                         }
                       },
                       isMultiSelect: isMultiSelect,
                       showSearch: showSearch,
                       title: "Select ${label.toLowerCase()}",
                     );
                   } else {
                     // Network fetch as before
                     showSmartDropdownSheet(
                       context: field.context,
                       label: label,
                       endpoint: endpoint,
                       queryParam: queryParam,
                       labelKey: labelKey,
                       idKey: idKey,
                       selectedItems: field.value ?? [],
                       onChanged: (selected) {
                           field.didChange(selected);     
                         onChanged(selected);
                         if (isRequired) {
                           field.validate();
                         }
                       },
                       isMultiSelect: isMultiSelect,
                       showSearch: showSearch,
                       title: "Select ${label.toLowerCase()}",
                     );
                   }
                 },
                 child: InputDecorator(
                   isEmpty: (field.value ?? []).isEmpty,
                   decoration: InputDecoration(
                     hintText: label,
                     errorText: errorText,
                     filled: true,
                     fillColor: isDarkTheme
                         ? Theme.of(
                             field.context,
                           ).colorScheme.secondaryContainer
                         : AppColors.pinFieldBgColor,
                     prefixIcon: prefixIcon,
                     suffixIcon:
                         suffixIcon ??
                         Transform.rotate(
                           angle: -3.14 / 2,
                           child: const Icon(
                             Icons.arrow_back_ios_outlined,
                             size: 16,
                             color: AppColors.primary,
                           ),
                         ),
                     border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(10),
                       borderSide: BorderSide.none,
                     ),
                     enabledBorder: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(10.0),
                       borderSide: BorderSide.none,
                     ),
                     errorBorder: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(10.0),
                       borderSide: const BorderSide(color: AppColors.error),
                     ),
                     focusedErrorBorder: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(10.0),
                       borderSide: const BorderSide(
                         color: AppColors.error,
                         width: 1.2,
                       ),
                     ),
                     contentPadding: const EdgeInsets.symmetric(
                       horizontal: 16,
                       vertical: 18,
                     ),
                     hintStyle: AppTextStyles.textSm.copyWith(
                       color: Theme.of(field.context).colorScheme.primary,
                       fontFamily: FontFamily.outfit,
                       fontSize: 14.0,
                       fontWeight: FontWeight.w400,
                     ),
                   ),
                   child: Text(
                     (field.value?.isNotEmpty ?? false)
                         ? field.value!.map((e) => e.title).join(', ')
                         : '',
                     maxLines: 1,
                     overflow: TextOverflow.ellipsis,
                     style: AppTextStyles.textSm.copyWith(
                       color: (field.value?.isNotEmpty ?? false)
                           ? Theme.of(field.context).textTheme.bodyLarge?.color
                           : Theme.of(field.context).colorScheme.primary,
                       fontFamily: FontFamily.outfit,
                       fontSize: 14.0,
                       fontWeight: FontWeight.w400,
                     ),
                   ),
                 ),
               ),
             ],
           );
         },
       );
}
