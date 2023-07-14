import 'package:flutter/material.dart';

import '../utils/colors.dart';

class RememberMeCheckbox extends StatefulWidget {
  final bool value;
  final void Function(bool) onChanged;

  const RememberMeCheckbox({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  RememberMeCheckboxState createState() => RememberMeCheckboxState();
}

class RememberMeCheckboxState extends State<RememberMeCheckbox> {
  late bool _rememberMe;

  @override
  void initState() {
    super.initState();
    _rememberMe = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: _rememberMe,
      onChanged: (value) {
        if (value == null) return;
        setState(() {
          _rememberMe = value;
        });
        widget.onChanged(value);
      },
      title: const Text(
        'Remember me',
        style: TextStyle(
          color: AppColors.textPrimaryClr,
        ),
      ),
      controlAffinity: ListTileControlAffinity.leading,
      dense: true,
      contentPadding: const EdgeInsets.all(0),
      activeColor: AppColors.accentClr,
      checkColor: AppColors.whiteClr,
    );
  }
}
