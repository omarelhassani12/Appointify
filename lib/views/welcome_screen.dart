import 'package:appointify/widgets/main_button.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../widgets/click_able_text.dart';
import 'auth/login_screen.dart';
import 'auth/role.dart';

class SemiCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height);
    path.quadraticBezierTo(
        size.width * 0.5, size.height * 0.5, size.width, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(SemiCircleClipper oldClipper) => false;
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.accentClr,
      body: Column(
        children: [
          ClipPath(
            clipper: SemiCircleClipper(),
            child: Container(
              height: 400,
              color: AppColors.backgroundClr,
              child: Image.asset(
                'assets/images/appointify.png',
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Welcome to Us',
                    style: TextStyle(
                      color: AppColors.whiteClr,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  MainButton(
                    text: 'Login to your account',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  ClickableTextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RoleSelection()),
                      );
                    },
                    nonClickableText: 'Don\'t have an account ',
                    clickableText: 'Sign Up',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
