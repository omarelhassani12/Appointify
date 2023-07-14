import 'package:flutter/material.dart';

import '../utils/colors.dart';

class ClickableTextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String clickableText;
  final String nonClickableText;

  const ClickableTextButton({
    super.key,
    required this.onPressed,
    required this.clickableText,
    required this.nonClickableText,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            nonClickableText,
            style: TextStyle(
              color: AppColors.whiteClr,
            ),
          ),
          Text(
            clickableText,
            style: TextStyle(
              color: onPressed != null ? Colors.blue : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
