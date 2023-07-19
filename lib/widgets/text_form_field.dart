import 'package:flutter/material.dart';

import '../utils/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String? Function(String?)? validator;
  final String labelText;
  final String hintText;
  final IconData prefixIcon;
  final Color prefixIconColor;
  final Color borderColor;
  final Color focusedBorderColor;
  final Color errorBorderColor;
  final Color errorTextColor;
  final Color labelTextColor;
  final Color hintTextColor;

  const CustomTextFormField({
    Key? key,
    this.validator,
    required this.labelText,
    required this.hintText,
    required this.prefixIcon,
    this.prefixIconColor = Colors.grey,
    this.borderColor = Colors.grey,
    this.focusedBorderColor = Colors.blue,
    this.errorBorderColor = Colors.red,
    this.errorTextColor = Colors.red,
    this.labelTextColor = Colors.black,
    this.hintTextColor = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: Icon(
          prefixIcon,
          color: prefixIconColor,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: focusedBorderColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: errorBorderColor,
          ),
        ),
        errorStyle: TextStyle(
          color: errorTextColor,
        ),
        labelStyle: TextStyle(
          color: labelTextColor,
        ),
        hintStyle: TextStyle(
          color: hintTextColor,
        ),
      ),
    );
  }
}

class CustomPasswordField extends StatefulWidget {
  final String? Function(String?)? validator;
  final String labelText;
  final String hintText;
  final IconData prefixIcon;
  final Color prefixIconColor;
  final Color borderColor;
  final Color focusedBorderColor;
  final Color errorBorderColor;
  final Color errorTextColor;
  final Color labelTextColor;
  final Color hintTextColor;

  const CustomPasswordField({
    Key? key,
    this.validator,
    required this.labelText,
    required this.hintText,
    required this.prefixIcon,
    this.prefixIconColor = Colors.grey,
    this.borderColor = Colors.grey,
    this.focusedBorderColor = Colors.blue,
    this.errorBorderColor = Colors.red,
    this.errorTextColor = Colors.red,
    this.labelTextColor = Colors.black,
    this.hintTextColor = Colors.grey,
  }) : super(key: key);

  @override
  CustomPasswordFieldState createState() => CustomPasswordFieldState();
}

class CustomPasswordFieldState extends State<CustomPasswordField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      obscureText: !_isPasswordVisible,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        prefixIcon: Icon(
          widget.prefixIcon,
          color: widget.prefixIconColor,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.borderColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.borderColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.focusedBorderColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.errorBorderColor,
          ),
        ),
        errorStyle: TextStyle(
          color: widget.errorTextColor,
        ),
        labelStyle: TextStyle(
          color: widget.labelTextColor,
        ),
        hintStyle: TextStyle(
          color: widget.hintTextColor,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
            color: widget.prefixIconColor,
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
      ),
    );
  }
}

class InfoTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String?)? onSaved;
  final String? initialValue;
  final String? Function(String?) validator;

  const InfoTextFormField({
    super.key,
    required this.controller,
    this.onSaved,
    this.initialValue,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      decoration: const InputDecoration(
        labelText: 'Name',
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.accentClr),
        ),
        labelStyle: TextStyle(
          color: AppColors.accentClr,
        ),
        focusColor: AppColors.accentClr,
      ),
      cursorColor: AppColors.accentClr,
      onSaved: onSaved,
      validator: validator,
    );
  }
}
