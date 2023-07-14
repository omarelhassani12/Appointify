import 'package:appointify/utils/validator.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../widgets/app_logo.dart';
import '../../widgets/main_button.dart';
import '../../widgets/text_form_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      body: Center(
        child: isSmallScreen
            ? Padding(
                padding: const EdgeInsets.all(32.0),
                child: ListView(
                  shrinkWrap: true,
                  children: const [
                    Logo(),
                    SizedBox(height: 40),
                    _FormContent(),
                  ],
                ),
              )
            : Container(
                padding: const EdgeInsets.all(32.0),
                constraints: const BoxConstraints(maxWidth: 800),
                child: const Row(
                  children: [
                    Expanded(child: Logo()),
                    SizedBox(height: 40),
                    Expanded(
                      child: Center(child: _FormContent()),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class _FormContent extends StatefulWidget {
  const _FormContent({Key? key}) : super(key: key);

  @override
  State<_FormContent> createState() => __FormContentState();
}

class __FormContentState extends State<_FormContent> {
  bool isPasswordVisible = false;
  bool _rememberMe = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomTextFormField(
              validator: validateEmail,
              labelText: 'Email',
              hintText: 'Enter your email',
              prefixIcon: Icons.email_outlined,
              prefixIconColor: AppColors.accentClr,
              borderColor: AppColors.borderClr,
              focusedBorderColor: AppColors.accentClr,
              errorBorderColor: AppColors.errorClr,
              errorTextColor: AppColors.errorClr,
              labelTextColor: AppColors.textSecondaryClr,
              hintTextColor: AppColors.textSecondaryClr,
            ),
            _gap(),
            const CustomPasswordField(
              validator: validatePassword,
              labelText: 'Password',
              hintText: 'Enter your password',
              prefixIcon: Icons.lock_outline_rounded,
              prefixIconColor: AppColors.accentClr,
              borderColor: AppColors.borderClr,
              focusedBorderColor: AppColors.accentClr,
              errorBorderColor: AppColors.errorClr,
              errorTextColor: AppColors.errorClr,
              labelTextColor: AppColors.textSecondaryClr,
              hintTextColor: AppColors.textSecondaryClr,
            ),
            _gap(),
            CheckboxListTile(
              value: _rememberMe,
              onChanged: (value) {
                if (value == null) return;
                setState(() {
                  _rememberMe = value;
                });
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
            ),
            _gap(),
            SizedBox(
              width: double.infinity,
              child: SecondButton(
                text: 'Sign in',
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    /// do something
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _gap() => const SizedBox(height: 16);
}













// class LoginScreen extends StatelessWidget {
//   const LoginScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

//     return Scaffold(
//         body: Center(
//             child: isSmallScreen
//                 ? const Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Logo(),
//                       SizedBox(height: 40),
//                       _FormContent(),
//                     ],
//                   )
//                 : Container(
//                     padding: const EdgeInsets.all(32.0),
//                     constraints: const BoxConstraints(maxWidth: 800),
//                     child: const Row(
//                       children: [
//                         Expanded(child: Logo()),
//                         SizedBox(height: 40),
//                         Expanded(
//                           child: Center(child: _FormContent()),
//                         ),
//                       ],
//                     ),
//                   )));
//   }
// }

// class _FormContent extends StatefulWidget {
//   const _FormContent({Key? key}) : super(key: key);

//   @override
//   State<_FormContent> createState() => __FormContentState();
// }

// class __FormContentState extends State<_FormContent> {
//   bool _isPasswordVisible = false;
//   bool _rememberMe = false;

//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       constraints: const BoxConstraints(maxWidth: 300),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const CustomTextFormField(
//               validator: validateEmail,
//               labelText: 'Email',
//               hintText: 'Enter your email',
//               prefixIcon: Icons.email_outlined,
//               prefixIconColor: AppColors.accentClr,
//               borderColor: AppColors.borderClr,
//               focusedBorderColor: AppColors.accentClr,
//               errorBorderColor: AppColors.errorClr,
//               errorTextColor: AppColors.errorClr,
//               labelTextColor: AppColors.textSecondaryClr,
//               hintTextColor: AppColors.textSecondaryClr,
//             ),
//             _gap(),
//             const CustomPasswordField(
//               validator: validatePassword,
//               labelText: 'Password',
//               hintText: 'Enter your password',
//               prefixIcon: Icons.lock_outline_rounded,
//               prefixIconColor: AppColors.accentClr,
//               borderColor: AppColors.borderClr,
//               focusedBorderColor: AppColors.accentClr,
//               errorBorderColor: AppColors.errorClr,
//               errorTextColor: AppColors.errorClr,
//               labelTextColor: AppColors.textSecondaryClr,
//               hintTextColor: AppColors.textSecondaryClr,
//             ),
//             _gap(),
//             CheckboxListTile(
//               value: _rememberMe,
//               onChanged: (value) {
//                 if (value == null) return;
//                 setState(() {
//                   _rememberMe = value;
//                 });
//               },
//               title: const Text(
//                 'Remember me',
//                 style: TextStyle(
//                   color: AppColors.textPrimaryClr,
//                 ),
//               ),
//               controlAffinity: ListTileControlAffinity.leading,
//               dense: true,
//               contentPadding: const EdgeInsets.all(0),
//               activeColor: AppColors.accentClr,
//               checkColor: AppColors.whiteClr,
//             ),
//             _gap(),
//             SizedBox(
//               width: double.infinity,
//               child: SecondButton(
//                 text: 'Sign in',
//                 onPressed: () {
//                   if (_formKey.currentState?.validate() ?? false) {
//                     /// do something
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _gap() => const SizedBox(height: 16);
// }
