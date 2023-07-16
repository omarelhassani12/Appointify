import 'package:appointify/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../utils/colors.dart';
import '../../widgets/client_information_ticket.dart';
import '../../widgets/date_time_button.dart';
import '../../widgets/section_app_title.dart';

class PlaceDetailsPage extends StatefulWidget {
  final String name;
  final String logoPath;
  final String workDays;
  final String workTimes;

  const PlaceDetailsPage({
    super.key,
    required this.name,
    required this.logoPath,
    required this.workDays,
    required this.workTimes,
  });

  @override
  PlaceDetailsPageState createState() => PlaceDetailsPageState();
}

class PlaceDetailsPageState extends State<PlaceDetailsPage> {
  String selectedDate = '';
  String selectedTime = '';
  List<String> places = [
    'Dental Clinic',
    'Spa Center',
    'Gym',
    'Hair Salon',
    'Massage Center',
  ];
  List<int> ticketCounts = [1, 2, 3];
  int selectedTicketCount = 1;

  Future<void> _selectDate() async {
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

  Future<void> _selectTime() async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        backgroundColor: AppColors.accentClr,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      widget.logoPath,
                      width: 100,
                      height: 100,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildRow(Icons.calendar_month, widget.workDays),
                        const Spacer(),
                        buildRow(Icons.access_alarm, widget.workTimes),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              const SectionTitle(
                                text: 'Select Ticket Count:',
                              ),
                              Container(
                                height: 40,
                                width: 160,
                                decoration: BoxDecoration(
                                  color: AppColors.accentClr,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20),
                                  child: DropdownButton<int>(
                                    value: selectedTicketCount,
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectedTicketCount = newValue!;
                                      });
                                    },
                                    items: ticketCounts
                                        .map<DropdownMenuItem<int>>(
                                            (int count) {
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
                      if (selectedTicketCount > 0)
                        Row(
                          children: [
                            Column(
                              children: [
                                const SectionTitle(
                                  text: 'Select Date:',
                                ),
                                DateTimeButton(
                                  selectedDate: selectedDate,
                                  onPressed: () => _selectDate(),
                                  child: Text(
                                    selectedDate.isEmpty
                                        ? 'Choose Date'
                                        : DateFormat('dd-MM-yyyy').format(
                                            DateTime.parse(selectedDate)),
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            if (selectedTicketCount > 0 &&
                                selectedDate.isNotEmpty)
                              Column(
                                children: [
                                  const SectionTitle(
                                    text: 'Select Time:',
                                  ),
                                  DateTimeButton(
                                    selectedDate: selectedTime,
                                    onPressed: () => _selectTime(),
                                    child: Text(selectedTime.isEmpty
                                        ? 'Choose Time'
                                        : selectedTime),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      const SizedBox(height: 16),
                      if (selectedTicketCount == 1)
                        const ClientInformationTicket(
                          title: 'Client Information:',
                          ticketCount: 1,
                        ),
                      if (selectedTicketCount == 2)
                        const ClientInformationTicket(
                          title: 'Client Information',
                          ticketCount: 2,
                        ),
                      if (selectedTicketCount == 3)
                        const ClientInformationTicket(
                          title: 'Client Information',
                          ticketCount: 3,
                        ),
                      const SizedBox(height: 16),
                      if (selectedTicketCount > 0 &&
                          selectedDate.isNotEmpty &&
                          selectedTime.isNotEmpty)
                        SecondButton(
                          text: 'Make Appointment',
                          onPressed: () {},
                        ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SecondButton(
                text: "Make an Appointment",
                onPressed: () {
                  _selectDate();
                  _selectTime();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRow(IconData iconData, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(iconData, size: 20, color: AppColors.accentClr),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.accentClr,
          ),
        ),
      ],
    );
  }
}
