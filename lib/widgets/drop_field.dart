import 'package:flutter/material.dart';
import 'package:appointify/utils/colors.dart';

class DropdownField extends StatelessWidget {
  final String? value;
  final List<String> items;
  final void Function(String?) onChanged;

  const DropdownField({
    required this.value,
    required this.items,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 140,
      child: DropdownButton<String>(
        value: value ?? '',
        onChanged: onChanged,
        items: items.map<DropdownMenuItem<String>>((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        style: const TextStyle(
          color: AppColors.accentClr,
          fontSize: 16,
        ),
        underline: Container(
          height: 1,
          color: AppColors.accentClr,
        ),
      ),
    );
  }
}
