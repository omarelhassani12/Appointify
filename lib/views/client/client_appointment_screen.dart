
import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import '../../widgets/appointment_card.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              const SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                expandedHeight: 50,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: PreferredSize(
                    preferredSize: Size.fromHeight(50),
                    child: TabBar(
                      tabs: [
                        Tab(text: 'Upcoming Appointments'),
                        Tab(text: 'Past Appointments'),
                      ],
                      labelColor: AppColors.accentClr,
                      indicatorColor: AppColors.accentClr,
                    ),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              _buildUpcomingAppointments(),
              _buildPastAppointments(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUpcomingAppointments() {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            AppointmentCard(
              title: 'Dentist Appointment',
              date: 'July 15, 2023',
              time: '10:00 AM',
              location: 'Dental Clinic',
              type: AppointmentType.dentist,
            ),
            SizedBox(height: 16),
            AppointmentCard(
              title: 'Massage Therapy',
              date: 'July 20, 2023',
              time: '2:30 PM',
              location: 'Spa Center',
              type: AppointmentType.massage,
            ),
            SizedBox(height: 16),
            AppointmentCard(
              title: 'Massage Therapy',
              date: 'July 20, 2023',
              time: '2:30 PM',
              location: 'Spa Center',
              type: AppointmentType.massage,
            ),
            SizedBox(height: 16),
            AppointmentCard(
              title: 'Massage Therapy',
              date: 'July 20, 2023',
              time: '2:30 PM',
              location: 'Spa Center',
              type: AppointmentType.massage,
            ),
            SizedBox(height: 90),
          ],
        ),
      ),
    );
  }

  Widget _buildPastAppointments() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics:
                  const NeverScrollableScrollPhysics(), // Disable scrolling for the ListView
              itemCount: 9,
              itemBuilder: (context, index) {
                return AppointmentCard(
                  title: 'Past Appointment ${index + 1}',
                  date: 'July ${index + 1}, 2023',
                  time: '9:00 AM',
                  location: 'Location ${index + 1}',
                  type: AppointmentType.defaultType,
                );
              },
            ),
            const SizedBox(height: 90),
          ],
        ),
      ),
    );
  }
}
