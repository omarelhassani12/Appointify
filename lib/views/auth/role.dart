import 'package:flutter/material.dart';
import 'package:csc_picker/csc_picker.dart';

import '../../utils/colors.dart';
import '../../widgets/select_card.dart';

class SelectedRoleWidget extends StatelessWidget {
  final String? selectedRole;

  const SelectedRoleWidget({super.key, required this.selectedRole});

  @override
  Widget build(BuildContext context) {
    if (selectedRole == 'User') {
      return UserWidget();
    } else if (selectedRole == 'Admin') {
      return const AdminWidget();
    } else {
      return const SizedBox(); // Empty widget if no role is selected
    }
  }
}

class UserWidget extends StatefulWidget {
  @override
  _UserWidgetState createState() => _UserWidgetState();
}

class _UserWidgetState extends State<UserWidget> {
  String? selectedCountry;
  String? selectedState;
  String? selectedCity;
  String phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'You are User',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Full name',
                ),
                // Handle the user's name input
              ),
              SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email Address',
                ),
                // Handle the user's email input
              ),
              SizedBox(height: 8),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                // Handle the user's password input
              ),
              SizedBox(height: 8),
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
              SizedBox(height: 8),
              if (selectedCountry != null)
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Phone number',
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
      ],
    );
  }
}

// class UserWidget extends StatefulWidget {
//   @override
//   _UserWidgetState createState() => _UserWidgetState();
// }

// class _UserWidgetState extends State<UserWidget> {
//   String? selectedCountry;
//   String? selectedState;
//   String? selectedCity;
//   String phoneNumber = '';

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text(
//           'You are User',
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         SizedBox(height: 16),
//         Container(
//           padding: EdgeInsets.symmetric(horizontal: 16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               TextFormField(
//                 decoration: InputDecoration(
//                   labelText: 'Full name',
//                 ),
//                 // Handle the user's name input
//               ),
//               SizedBox(height: 8),
//               TextFormField(
//                 decoration: InputDecoration(
//                   labelText: 'Email Address',
//                 ),
//                 // Handle the user's email input
//               ),
//               SizedBox(height: 8),
//               TextFormField(
//                 obscureText: true,
//                 decoration: InputDecoration(
//                   labelText: 'Password',
//                 ),
//                 // Handle the user's password input
//               ),
//               SizedBox(height: 8),
//               CSCPicker(
//                 onCountryChanged: (value) {
//                   setState(() {
//                     selectedCountry = value;
//                     selectedState = null;
//                     selectedCity = null;
//                   });
//                 },
//                 onStateChanged: (value) {
//                   setState(() {
//                     selectedState = value;
//                     selectedCity = null;
//                   });
//                 },
//                 onCityChanged: (value) {
//                   setState(() {
//                     selectedCity = value;
//                   });
//                 },
//               ),
//               SizedBox(height: 8),
//               InternationalPhoneNumberInput(
//                 onInputChanged: (PhoneNumber number) {
//                   setState(() {
//                     phoneNumber = number.phoneNumber!;
//                   });
//                 },
//                 selectorConfig: SelectorConfig(
//                   selectorType: PhoneInputSelectorType.DIALOG,
//                 ),
//                 ignoreBlank: true,
//                 autoValidateMode: AutovalidateMode.onUserInteraction,
//                 selectorTextStyle: TextStyle(color: Colors.black),
//                 initialValue: selectedCountry != null
//                     ? PhoneNumber(isoCode: selectedCountry!)
//                     : null,
//                 formatInput: true,
//                 keyboardType: TextInputType.numberWithOptions(
//                     signed: true, decimal: true),
//                 inputBorder: OutlineInputBorder(),
//                 onSaved: (PhoneNumber number) {
//                   // Handle saving the phone number
//                 },
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// class UserWidget extends StatefulWidget {
//   const UserWidget({super.key});

//   @override
//   UserWidgetState createState() => UserWidgetState();
// }

// class UserWidgetState extends State<UserWidget> {
//   String? selectedCountry;
//   String? selectedState;
//   String? selectedCity;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const Text(
//           'You are User',
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 16),
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               TextFormField(
//                 decoration: const InputDecoration(
//                   labelText: 'Full name',
//                 ),
//                 // Handle the user's name input
//               ),
//               const SizedBox(height: 8),
//               TextFormField(
//                 decoration: const InputDecoration(
//                   labelText: 'Email Address',
//                 ),
//                 // Handle the user's email input
//               ),
//               const SizedBox(height: 8),
//               TextFormField(
//                 obscureText: true,
//                 decoration: const InputDecoration(
//                   labelText: 'Password',
//                 ),
//                 // Handle the user's password input
//               ),
//               const SizedBox(height: 8),
//               CSCPicker(
//                 onCountryChanged: (value) {
//                   setState(() {
//                     selectedCountry = value;
//                     selectedState = null;
//                     selectedCity = null;
//                   });
//                 },
//                 onStateChanged: (value) {
//                   setState(() {
//                     selectedState = value;
//                     selectedCity = null;
//                   });
//                 },
//                 onCityChanged: (value) {
//                   setState(() {
//                     selectedCity = value;
//                   });
//                 },
//               ),
//               const SizedBox(height: 8),
//               TextFormField(
//                 decoration: const InputDecoration(
//                   labelText: 'Phone number',
//                 ),
//                 // Handle the user's phone input
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

class AdminWidget extends StatelessWidget {
  const AdminWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'You are Admin',
          style: TextStyle(
            color: AppColors.textSecondaryClr,
          ),
        ),
        const SizedBox(height: 16),
        Image.asset(
          'assets/images/admin.png',
          width: 100,
          height: 100,
        ),
      ],
    );
  }
}

class RoleSelection extends StatefulWidget {
  const RoleSelection({Key? key}) : super(key: key);

  @override
  State<RoleSelection> createState() => _RoleSelectionState();
}

class _RoleSelectionState extends State<RoleSelection> {
  String? selectedRole;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SelectableCard(
                        label: 'User',
                        imagePath: 'assets/images/client.png',
                        selectedColor: AppColors.buttonClr,
                        unselectedColor: Colors.grey,
                        textColor: AppColors.textSecondaryClr,
                        isSelected: selectedRole == 'User',
                        onTap: () {
                          setState(() {
                            selectedRole =
                                selectedRole == 'User' ? null : 'User';
                          });
                        },
                        imageWidth: 80,
                        imageHeight: 80,
                      ),
                      const SizedBox(width: 16),
                      SelectableCard(
                        label: 'Admin',
                        imagePath: 'assets/images/admin.png',
                        selectedColor: AppColors.buttonClr,
                        unselectedColor: Colors.grey,
                        textColor: AppColors.textSecondaryClr,
                        isSelected: selectedRole == 'Admin',
                        onTap: () {
                          setState(() {
                            selectedRole =
                                selectedRole == 'Admin' ? null : 'Admin';
                          });
                        },
                        imageWidth: 80,
                        imageHeight: 80,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SelectedRoleWidget(selectedRole: selectedRole),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}















// class RoleSelection extends StatefulWidget {
//   const RoleSelection({Key? key}) : super(key: key);

//   @override
//   State<RoleSelection> createState() => _RoleSelectionState();
// }

// class _RoleSelectionState extends State<RoleSelection> {
//   String? selectedRole;

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SelectableCard(
//                       label: 'User',
//                       imagePath: 'assets/images/client.png',
//                       selectedColor: AppColors.buttonClr,
//                       unselectedColor: Colors.grey,
//                       textColor: AppColors.textSecondaryClr,
//                       isSelected: selectedRole == 'User',
//                       onTap: () {
//                         setState(() {
//                           selectedRole = selectedRole == 'User' ? null : 'User';
//                         });
//                       },
//                       imageWidth: 80,
//                       imageHeight: 80,
//                     ),
//                     SizedBox(width: 16),
//                     SelectableCard(
//                       label: 'Admin',
//                       imagePath: 'assets/images/admin.png',
//                       selectedColor: AppColors.buttonClr,
//                       unselectedColor: Colors.grey,
//                       textColor: AppColors.textSecondaryClr,
//                       isSelected: selectedRole == 'Admin',
//                       onTap: () {
//                         setState(() {
//                           selectedRole =
//                               selectedRole == 'Admin' ? null : 'Admin';
//                         });
//                       },
//                       imageWidth: 80,
//                       imageHeight: 80,
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 16),
//                 if (selectedRole != null)
//                   Column(
//                     children: [
//                       Text(
//                         'As a ${selectedRole!}',
//                         style: TextStyle(
//                           color: AppColors.textSecondaryClr,
//                         ),
//                       ),
//                       SizedBox(height: 16),
//                       Image.asset(
//                         selectedRole == 'User'
//                             ? 'assets/images/client.png'
//                             : 'assets/images/admin.png',
//                       ),
//                       // Image.asset(
//                       //   selectedRole == 'User'
//                       //       ? 'assets/images/client.png'
//                       //       : 'assets/images/admin.png',
//                       // ),
//                     ],
//                   ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }










// import 'package:flutter/material.dart';
// import '../../utils/colors.dart';

// class SelectableCard extends StatefulWidget {
//   final String label;
//   final String imagePath;
//   final Color selectedColor;
//   final Color unselectedColor;
//   final Color textColor;
//   final bool isSelected;
//   final VoidCallback onTap;

//   const SelectableCard({
//     required this.label,
//     required this.imagePath,
//     required this.selectedColor,
//     required this.unselectedColor,
//     required this.textColor,
//     required this.isSelected,
//     required this.onTap,
//     Key? key,
//   }) : super(key: key);

//   @override
//   _SelectableCardState createState() => _SelectableCardState();
// }

// class _SelectableCardState extends State<SelectableCard> {
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: widget.onTap,
//       child: Card(
//         color:
//             widget.isSelected ? widget.selectedColor : widget.unselectedColor,
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset(
//                 widget.imagePath,
//                 width: 40,
//                 height: 24,
//                 color: widget.isSelected ? null : widget.textColor,
//               ),
//               SizedBox(height: 8),
//               Text(
//                 widget.label,
//                 style: TextStyle(
//                   color: widget.textColor,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class RoleSelection extends StatefulWidget {
//   const RoleSelection({Key? key}) : super(key: key);

//   @override
//   State<RoleSelection> createState() => _RoleSelectionState();
// }

// class _RoleSelectionState extends State<RoleSelection> {
//   String? selectedRole;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 SelectableCard(
//                   label: 'User',
//                   imagePath: 'assets/images/client.png',
//                   selectedColor: AppColors.buttonClr,
//                   unselectedColor: Colors.grey,
//                   textColor: AppColors.textSecondaryClr,
//                   isSelected: selectedRole == 'User',
//                   onTap: () {
//                     setState(() {
//                       selectedRole = selectedRole == 'User' ? null : 'User';
//                     });
//                   },
//                 ),
//                 SizedBox(height: 8),
//                 SelectableCard(
//                   label: 'Admin',
//                   imagePath: 'assets/images/admin.png',
//                   selectedColor: AppColors.buttonClr,
//                   unselectedColor: Colors.grey,
//                   textColor: AppColors.textSecondaryClr,
//                   isSelected: selectedRole == 'Admin',
//                   onTap: () {
//                     setState(() {
//                       selectedRole = selectedRole == 'Admin' ? null : 'Admin';
//                     });
//                   },
//                 ),
//               ],
//             ),
//             SizedBox(height: 16),
//             if (selectedRole != null)
//               Column(
//                 children: [
//                   Text(
//                     selectedRole!,
//                     style: TextStyle(
//                       color: AppColors.textSecondaryClr,
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   Image.asset(
//                     selectedRole == 'User'
//                         ? 'assets/images/client.png'
//                         : 'assets/images/admin.png',
//                     width: 100,
//                     height: 100,
//                   ),
//                 ],
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }







