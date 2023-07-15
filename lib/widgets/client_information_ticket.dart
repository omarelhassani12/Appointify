import 'package:flutter/material.dart';
import '../utils/colors.dart';
import 'section_app_title.dart';
import 'package:flutter/services.dart';

class ClientInformationTicket extends StatelessWidget {
  final String title;
  final int ticketCount;

  const ClientInformationTicket({
    Key? key,
    required this.title,
    required this.ticketCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        ticketCount,
        (index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              SectionTitle(
                text: index == 0 ? title : '$title (${index + 1}):',
              ),
              const SizedBox(height: 8),
              TextField(
                style: TextStyle(color: AppColors.whiteClr),
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                autocorrect: true,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]+')),
                ],
                decoration: InputDecoration(
                  labelText: 'Name',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  filled: true,
                  fillColor: AppColors.accentClr,
                  labelStyle: const TextStyle(color: Colors.white),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  hintStyle: TextStyle(color: AppColors.whiteClr),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                style: TextStyle(color: AppColors.whiteClr),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  filled: true,
                  fillColor: AppColors.accentClr,
                  labelStyle: const TextStyle(color: Colors.white),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  hintStyle: TextStyle(color: AppColors.whiteClr),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
