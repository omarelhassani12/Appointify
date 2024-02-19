// import 'package:flutter/material.dart';

// import '../utils/colors.dart';

// class AppointmentCard extends StatelessWidget {
//   final String title;
//   final String date;
//   final String time;
//   final String location;

//   const AppointmentCard({super.key,
//     required this.title,
//     required this.date,
//     required this.time,
//     required this.location,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               title,
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Row(
//               children: [
//                 const Icon(
//                   Icons.calendar_today,
//                   color: AppColors.accentClr,
//                   size: 16,
//                 ),
//                 const SizedBox(width: 4),
//                 Text(
//                   date,
//                   style: const TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 4),
//             Row(
//               children: [
//                 const Icon(
//                   Icons.access_time,
//                   color: AppColors.accentClr,
//                   size: 16,
//                 ),
//                 const SizedBox(width: 4),
//                 Text(
//                   time,
//                   style: const TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 4),
//             Row(
//               children: [
//                 const Icon(
//                   Icons.location_on,
//                   color: AppColors.accentClr,
//                   size: 16,
//                 ),
//                 const SizedBox(width: 4),
//                 Text(
//                   location,
//                   style: const TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import '../utils/colors.dart';

// enum AppointmentType { dentist, massage, defaultType }

// class AppointmentCard extends StatelessWidget {
//   final String title;
//   final String date;
//   final String time;
//   final String location;
//   final AppointmentType type;

//   const AppointmentCard({
//     Key? key,
//     required this.title,
//     required this.date,
//     required this.time,
//     required this.location,
//     required this.type,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Icon(
//                   _getIconForType(type),
//                   color: AppColors.accentClr,
//                   size: 16,
//                 ),
//                 const SizedBox(width: 4),
//                 Text(
//                   title,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: AppColors.accentClr,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),
//             Row(
//               children: [
//                 const Icon(
//                   Icons.calendar_today,
//                   color: AppColors.accentClr,
//                   size: 16,
//                 ),
//                 const SizedBox(width: 4),
//                 Text(
//                   date,
//                   style: const TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 4),
//             Row(
//               children: [
//                 const Icon(
//                   Icons.access_time,
//                   color: AppColors.accentClr,
//                   size: 16,
//                 ),
//                 const SizedBox(width: 4),
//                 Text(
//                   time,
//                   style: const TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 4),
//             Row(
//               children: [
//                 const Icon(
//                   Icons.location_on,
//                   color: AppColors.accentClr,
//                   size: 16,
//                 ),
//                 const SizedBox(width: 4),
//                 Text(
//                   location,
//                   style: const TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   IconData _getIconForType(AppointmentType type) {
//     switch (type) {
//       case AppointmentType.dentist:
//         return Icons.local_hospital;
//       case AppointmentType.massage:
//         return Icons.spa;
//       default:
//         return Icons.calendar_today;
//     }
//   }
// }

import 'package:flutter/material.dart';
import '../utils/colors.dart';

enum AppointmentType { dentist, massage, defaultType }

class AppointmentCard extends StatelessWidget {
  final String title;
  final String date;
  final String time;
  final String location;
  final AppointmentType type;

  const AppointmentCard({
    Key? key,
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(title), // Use a unique key for each appointment
      onDismissed: (direction) {
        // Handle dismissal here
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$title dismissed'),
          ),
        );
      },
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20.0),
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    _getIconForType(type),
                    color: AppColors.accentClr,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today,
                    color: AppColors.accentClr,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    date,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(
                    Icons.access_time,
                    color: AppColors.accentClr,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    time,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: AppColors.accentClr,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    location,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIconForType(AppointmentType type) {
    switch (type) {
      case AppointmentType.dentist:
        return Icons.local_hospital;
      case AppointmentType.massage:
        return Icons.spa;
      default:
        return Icons.calendar_today;
    }
  }
}
