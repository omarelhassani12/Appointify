import 'package:flutter/material.dart';
import 'package:appointify/utils/colors.dart';

class SectionTitle extends StatelessWidget {
  final String text;

  const SectionTitle({
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: AppColors.primaryClr,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
