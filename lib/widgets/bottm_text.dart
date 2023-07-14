import 'package:flutter/material.dart';

import '../utils/colors.dart';

class BottomText extends StatelessWidget {
  final String text;
  final String actionText;
  final VoidCallback onActionPressed;

  const BottomText({
    Key? key,
    required this.text,
    required this.actionText,
    required this.onActionPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onActionPressed,
        child: RichText(
          text: TextSpan(
            text: text,
            style: const TextStyle(
              color: AppColors.textPrimaryClr,
            ),
            children: [
              TextSpan(
                text: actionText,
                style: const TextStyle(
                  color: AppColors.accentClr,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
