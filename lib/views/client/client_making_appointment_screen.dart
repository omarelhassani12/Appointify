import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../widgets/section_app_title.dart';
import '../../widgets/date_time_button.dart';
import '../../widgets/client_information_ticket.dart';
import '../../utils/colors.dart';
import '../../widgets/main_button.dart';

class MakingAppointmentScreen extends StatefulWidget {
  const MakingAppointmentScreen({Key? key}) : super(key: key);

  @override
  State<MakingAppointmentScreen> createState() =>
      _MakingAppointmentScreenState();
}

class _MakingAppointmentScreenState extends State<MakingAppointmentScreen> {
  String selectedDate = '';
  String selectedTime = '';
  List<String> places = [
    'Dental Clinic',
    'Hair Salon',
    'Fitness Center',
    'Spa & Wellness',
    'Restaurant',
    'Coffee Shop',
    'Bookstore',
    'Art Gallery',
    'Bakery',
    'Garden Center',
  ];
  List<int> ticketCounts = [1, 2, 3];
  String? selectedPlace;
  int selectedTicketCount = 1;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate.toString();
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime.format(context);
      });
    }
  }

  Future<bool> _confirmExit() async {
    if (selectedPlace != null &&
        selectedPlace!.isNotEmpty &&
        selectedTicketCount > 0 &&
        selectedDate.isNotEmpty &&
        selectedTime.isNotEmpty) {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirmation'),
            content: const Text(
              'Are you sure you want to go back? Your changes will be discarded.',
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Confirm'),
              ),
            ],
          );
        },
      );
      return confirmed ?? false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _confirmExit,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Make an Appointment',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: AppColors.accentClr,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        const SectionTitle(
                          text: 'Select Place:',
                        ),
                        Container(
                          height: 40,
                          width: 160,
                          decoration: BoxDecoration(
                            color: AppColors.accentClr,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 2.0, right: 2),
                            child: DropdownButton<String>(
                              value: selectedPlace,
                              onChanged: (newValue) {
                                setState(() {
                                  selectedPlace = newValue!;
                                });
                              },
                              items: places.map<DropdownMenuItem<String>>(
                                  (String place) {
                                return DropdownMenuItem<String>(
                                  value: place,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.accentClr,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Text(
                                        place,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                              underline: Container(),
                              iconSize: 30,
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: AppColors.whiteClr,
                              ),
                              isExpanded: true,
                              dropdownColor: AppColors.accentClr,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    if (selectedPlace != null && selectedPlace!.isNotEmpty)
                      Column(
                        children: [
                          const SectionTitle(
                            text: 'Select Ticket Count:',
                          ),
                          Container(
                            // height: 40,
                            width: 160,
                            decoration: BoxDecoration(
                              color: AppColors.accentClr,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20.0, right: 20),
                              child: DropdownButton<int>(
                                value: selectedTicketCount,
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedTicketCount = newValue!;
                                  });
                                },
                                items: ticketCounts
                                    .map<DropdownMenuItem<int>>((int count) {
                                  return DropdownMenuItem<int>(
                                    value: count,
                                    child: Text(
                                      count.toString(),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                underline: Container(),
                                iconSize: 30,
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: AppColors.whiteClr,
                                ),
                                isExpanded: true,
                                dropdownColor: AppColors.accentClr,
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                if (selectedPlace != null &&
                    selectedPlace!.isNotEmpty &&
                    selectedTicketCount > 0)
                  Row(
                    children: [
                      Column(
                        children: [
                          const SectionTitle(
                            text: 'Select Date:',
                          ),
                          DateTimeButton(
                            selectedDate: selectedDate,
                            onPressed: () => _selectDate(context),
                            child: Text(
                              selectedDate.isEmpty
                                  ? 'Choose Date'
                                  : DateFormat('dd-MM-yyyy')
                                      .format(DateTime.parse(selectedDate)),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      if (selectedPlace != null &&
                          selectedPlace!.isNotEmpty &&
                          selectedTicketCount > 0 &&
                          selectedDate.isNotEmpty)
                        Column(
                          children: [
                            const SectionTitle(
                              text: 'Select Time:',
                            ),
                            DateTimeButton(
                              selectedDate: selectedTime,
                              onPressed: () => _selectTime(context),
                              child: Text(selectedTime.isEmpty
                                  ? 'Choose Time'
                                  : selectedTime),
                            ),
                          ],
                        ),
                    ],
                  ),
                const SizedBox(height: 16),
                if (selectedPlace != null &&
                    selectedPlace!.isNotEmpty &&
                    selectedTicketCount == 1)
                  const ClientInformationTicket(
                    title: 'Client Information:',
                    ticketCount: 1,
                  ),
                if (selectedPlace != null &&
                    selectedPlace!.isNotEmpty &&
                    selectedTicketCount == 2)
                  const ClientInformationTicket(
                    title: 'Client Information',
                    ticketCount: 2,
                  ),
                if (selectedPlace != null &&
                    selectedPlace!.isNotEmpty &&
                    selectedTicketCount == 3)
                  const ClientInformationTicket(
                    title: 'Client Information',
                    ticketCount: 3,
                  ),
                const SizedBox(height: 16),
                if (selectedPlace != null &&
                    selectedPlace!.isNotEmpty &&
                    selectedTicketCount > 0 &&
                    selectedDate.isNotEmpty &&
                    selectedTime.isNotEmpty)
                  SecondButton(
                    text: 'Make Appointment',
                    onPressed: () {},
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
