import 'package:appointify/utils/colors.dart';
import 'package:flutter/material.dart';

class SearchAppointmentScreen extends StatefulWidget {
  const SearchAppointmentScreen({Key? key}) : super(key: key);

  @override
  State<SearchAppointmentScreen> createState() =>
      _SearchAppointmentScreenState();
}

class _SearchAppointmentScreenState extends State<SearchAppointmentScreen> {
  String workday = "Monday-Friday";
  String workTime = "08:00-18:00";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Appointments'),
        backgroundColor: AppColors.accentClr,
        centerTitle: true,
        elevation: 0,
      ),
      body: GridView.count(
        crossAxisCount: 2, // Number of columns in the grid
        mainAxisSpacing: 6, // Spacing between rows
        crossAxisSpacing: 6, // Spacing between columns
        padding: const EdgeInsets.all(10), // Padding around the grid
        children: [
          _buildPlaceCard(
            'Clinic Dental',
            'assets/images/dental.png',
          ),
          _buildPlaceCard(
            'Beauty Salon',
            'assets/images/beauty_salon.png',
          ),
          _buildPlaceCard(
            'Fitness Center',
            'assets/images/fitness_center.png',
          ),
          _buildPlaceCard(
            'Spa & Wellness',
            'assets/images/spa.png',
          ),
          // Add more place cards as needed
        ],
      ),
    );
  }

  Widget _buildPlaceCard(String name, String imagePath) {
    return GestureDetector(
      onTap: () {
        // Perform action when a place card is tapped
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 64,
              height: 64,
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class AppointmentDetailsScreen extends StatelessWidget {
  const AppointmentDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment Details'),
      ),
      body: const Center(
        child: Text('Appointment Details'),
      ),
    );
  }
}
