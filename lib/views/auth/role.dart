import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import '../../widgets/role_widget.dart';
import '../../widgets/select_card.dart';

class SelectedRoleWidget extends StatelessWidget {
  final String? selectedRole;

  const SelectedRoleWidget({super.key, required this.selectedRole});

  @override
  Widget build(BuildContext context) {
    if (selectedRole == 'Client') {
      return const RoleWidget(
        role: 'Client',
      );
    } else if (selectedRole == 'Admin') {
      return const RoleWidget(
        role: 'Admin',
      );
    } else {
      return const SizedBox(
        child: Text(
          'Please select a role',
          style: TextStyle(
            color: AppColors.accentClr,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
  }
}

class RoleSelection extends StatefulWidget {
  const RoleSelection({Key? key}) : super(key: key);

  @override
  State<RoleSelection> createState() => _RoleSelectionState();
}

class _RoleSelectionState extends State<RoleSelection> {
  String? selectedRole;
  bool isButtonEnabled = false;

  void checkButtonStatus() {
    setState(() {
      isButtonEnabled = selectedRole != null && isFormCompleted();
    });
  }

  bool isFormCompleted() {
    if (selectedRole == null) {
      return false; // Role is not selected, form is incomplete
    }

    // Check if other form fields are completed
    // Add your logic here based on the requirements of your form
    // For example, check if full name, email address, and password are filled

    // Return true if all required fields are filled, otherwise false
    return true;
  }

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
                        label: 'Client',
                        imagePath: 'assets/images/client.png',
                        selectedColor: AppColors.accentClr,
                        unselectedColor: Colors.grey,
                        textColor: AppColors.textSecondaryClr,
                        isSelected: selectedRole == 'Client',
                        onTap: () {
                          setState(() {
                            selectedRole =
                                selectedRole == 'Client' ? null : 'Client';
                            checkButtonStatus();
                          });
                        },
                        imageWidth: 80,
                        imageHeight: 80,
                      ),
                      const SizedBox(width: 16),
                      SelectableCard(
                        label: 'Admin',
                        imagePath: 'assets/images/admin.png',
                        selectedColor: AppColors.accentClr,
                        unselectedColor: Colors.grey,
                        textColor: AppColors.textSecondaryClr,
                        isSelected: selectedRole == 'Admin',
                        onTap: () {
                          setState(() {
                            selectedRole =
                                selectedRole == 'Admin' ? null : 'Admin';
                            checkButtonStatus();
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
