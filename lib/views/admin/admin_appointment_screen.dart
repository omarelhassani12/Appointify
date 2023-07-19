import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/appointment.dart'; // For date formatting

class AdminAppointmentsScreen extends StatelessWidget {
  const AdminAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<Appointment>>(
          future:
              _fetchAppointmentsForToday(), // Replace with your method to fetch appointments
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No appointments for today.'));
            } else {
              return ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final appointment = snapshot.data![index];
                  return ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                    title: Text('Name: ${appointment.name}'),
                    subtitle: Text('Time: ${appointment.time}'),
                    // Add more appointment details as needed
                    onTap: () {
                      // Add onTap functionality for each appointment if needed
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Future<List<Appointment>> _fetchAppointmentsForToday() async {
    final now = DateTime.now();
    final formatter = DateFormat('HH:mm');
    return List.generate(
      5,
      (index) => Appointment(
        name: 'Client $index',
        time:
            formatter.format(DateTime(now.year, now.month, now.day, 9 + index)),
        day: 'Monday', // Replace with the actual day of the appointment
        phone: '123-456-7890', // Replace with the actual phone number
      ),
    );
  }
}
