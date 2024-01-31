import 'package:dropdown_search/dropdown_search.dart';
import 'package:fl_pbi/library/library_file.dart';
import 'package:flutter/material.dart';

class DropdownWidget<T> extends StatelessWidget {
  final T? selectedItem;
  final List<T> items;
  final bool isVisible;
  final bool? enable;
  final Widget Function(T)? child;
  final Function(T?)? onChanged;
  final String Function(T)? itemAsString;
  final String? Function(T?)? validator;

  const DropdownWidget({
    super.key,
    required this.isVisible,
    this.enable,
    this.selectedItem,
    required this.items,
    this.child,
    this.onChanged,
    this.itemAsString,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<T>(
      enabled: enable ?? true,
      selectedItem: selectedItem,
      popupProps: PopupProps.modalBottomSheet(
        showSearchBox: true,
        searchDelay: const Duration(milliseconds: 500),
        itemBuilder: (context, item, isSelected) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 4.0,
              horizontal: 10,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 252, 253, 253),
                borderRadius: BorderRadius.circular(6),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 114, 100, 240),
                    spreadRadius: 0.2,
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  )
                ],
              ),
              child: child!(item),
            ),
          );
        },
        searchFieldProps: const TextFieldProps(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ),
      validator: validator,
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: TextFormDecoration.box(),
      ),
      onChanged: onChanged,
      items: items,
      itemAsString: itemAsString,
    );
  }
}
