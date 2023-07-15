import 'package:flutter/material.dart';

import '../utils/colors.dart';

class DateTimeButton extends StatelessWidget {
  final String selectedDate;
  final VoidCallback onPressed;
  final Widget child;

  const DateTimeButton({
    Key? key,
    required this.selectedDate,
    required this.onPressed,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: AppColors.accentClr,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        child: child,
      ),
    );
  }
}
