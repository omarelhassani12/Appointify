import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../views/auth/select_position.dart';
import '../views/client/client_home_screen.dart';
import 'main_button.dart';

class RoleWidget extends StatefulWidget {
  final String role;

  const RoleWidget({
    Key? key,
    required this.role,
  }) : super(key: key);

  @override
  RoleWidgetState createState() => RoleWidgetState();
}

class RoleWidgetState extends State<RoleWidget> {
  String? selectedCountry;
  String? selectedState;
  String? selectedCity;
  String phoneNumber = '';
  final _formKey = GlobalKey<FormState>();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  void resetForm() {
    setState(() {
      selectedCountry = null;
      selectedState = null;
      selectedCity = null;
      phoneNumber = '';
      fullNameController.clear();
      emailAddressController.clear();
      passwordController.clear();
      _formKey.currentState?.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'You are ${widget.role}',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: fullNameController,
                  decoration: const InputDecoration(
                    labelText: 'Full name',
                    labelStyle: TextStyle(
                      color: AppColors.accentClr,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.accentClr,
                      ),
                    ),
                    focusedErrorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.accentClr,
                      ),
                    ),
                    errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red, // Change to desired error color
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: emailAddressController,
                  decoration: const InputDecoration(
                    labelText: 'Email Address',
                    labelStyle: TextStyle(
                      color: AppColors.accentClr,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.accentClr,
                      ),
                    ),
                    focusedErrorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.accentClr,
                      ),
                    ),
                    errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red, // Change to desired error color
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email address';
                    }
                    // Add additional validation logic for email address if needed
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      color: AppColors.accentClr,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.accentClr,
                      ),
                    ),
                    focusedErrorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.accentClr,
                      ),
                    ),
                    errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red, // Change to desired error color
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    // Add additional validation logic for password if needed
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                CSCPicker(
                  onCountryChanged: (value) {
                    setState(() {
                      selectedCountry = value;
                      selectedState = null;
                      selectedCity = null;
                    });
                  },
                  onStateChanged: (value) {
                    setState(() {
                      selectedState = value;
                      selectedCity = null;
                    });
                  },
                  onCityChanged: (value) {
                    setState(() {
                      selectedCity = value;
                    });
                  },
                ),
                const SizedBox(height: 8),
                if (selectedCountry != null)
                  TextFormField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Phone number',
                      labelStyle: TextStyle(
                        color: AppColors.accentClr,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.accentClr,
                        ),
                      ),
                      focusedErrorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.accentClr,
                        ),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.phone,
                    onChanged: (value) {
                      setState(() {
                        phoneNumber = value;
                      });
                    },
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        // if (fullNameController.text.isNotEmpty &&
        //     emailAddressController.text.isNotEmpty &&
        //     passwordController.text.isNotEmpty &&
        //     phoneController.text.isNotEmpty)
        SizedBox(
          width: 250,
          child: SecondButton(
            text: 'Sign up as ${widget.role}',
            onPressed: () {
              // if (_formKey.currentState?.validate() ?? false) {
              if (widget.role == "Admin") {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PositionSelectMap()),
                );
              } else if (widget.role == "Client") {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ClientHomeScreen()),
                );
              }
              // }
            },
          ),
        ),
      ],
    );
  }
}
