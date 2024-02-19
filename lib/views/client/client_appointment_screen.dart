// import 'package:flutter/material.dart';
// import '../../widgets/appointment_card.dart';

// class AppointmentsScreen extends StatelessWidget {
//   const AppointmentsScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Upcoming Appointments',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 16),
//           const AppointmentCard(
//             title: 'Dentist Appointment',
//             date: 'July 15, 2023',
//             time: '10:00 AM',
//             location: 'Dental Clinic',
//             type: AppointmentType.dentist, // Specify the appointment type
//           ),
//           const SizedBox(height: 16),
//           const AppointmentCard(
//             title: 'Massage Therapy',
//             date: 'July 20, 2023',
//             time: '2:30 PM',
//             location: 'Spa Center',
//             type: AppointmentType.massage, // Specify the appointment type
//           ),
//           const SizedBox(height: 16),
//           const Text(
//             'Past Appointments',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 16),
//           Expanded(
//             child: ListView.builder(
//               itemCount: 10,
//               itemBuilder: (context, index) {
//                 return AppointmentCard(
//                   title: 'Appointment ${index + 1}',
//                   date: 'July ${index + 1}, 2023',
//                   time: '9:00 AM',
//                   location: 'Location ${index + 1}',
//                   type: AppointmentType
//                       .defaultType, 
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../../widgets/appointment_card.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Upcoming Appointments',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const AppointmentCard(
            title: 'Dentist Appointment',
            date: 'July 15, 2023',
            time: '10:00 AM',
            location: 'Dental Clinic',
            type: AppointmentType.dentist, // Specify the appointment type
          ),
          const SizedBox(height: 16),
          const AppointmentCard(
            title: 'Massage Therapy',
            date: 'July 20, 2023',
            time: '2:30 PM',
            location: 'Spa Center',
            type: AppointmentType.massage, // Specify the appointment type
          ),
          const SizedBox(height: 16),
          const Text(
            'Past Appointments',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                final isPastAppointment = index < 5; // Assuming the first 5 appointments are past appointments
                if (isPastAppointment) {
                  return AppointmentCard(
                    title: 'Appointment ${index + 1}',
                    date: 'July ${index + 1}, 2023',
                    time: '9:00 AM',
                    location: 'Location ${index + 1}',
                    type: AppointmentType.defaultType, 
                  );
                } else {
                  return SizedBox(); // Return an empty SizedBox for future appointments
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
