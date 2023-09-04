import 'package:flutter/material.dart';

class DropDownList extends StatelessWidget {
  const DropDownList({
    super.key,
    required this.items,
    required this.onChanged,
  });
  final List<DropdownMenuItem<String>> items;
  final void Function(String?) onChanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButton(
          underline: Container(), items: items, onChanged: onChanged),
    );
  }
}
