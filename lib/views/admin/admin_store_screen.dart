import 'package:appointify/utils/colors.dart';
import 'package:flutter/material.dart';

class AdminStoreScreen extends StatelessWidget {
  const AdminStoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 200,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/appointify.png'), // Replace with your store image path
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Icon(Icons.location_on, color: AppColors.accentClr),
                  SizedBox(width: 8),
                  Text(
                    'Store Address, City, Country', // Replace with your actual store address
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Icon(Icons.phone, color: AppColors.accentClr),
                  SizedBox(width: 8),
                  Text(
                    '+123-456-7890', // Replace with your actual store phone number
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Icon(Icons.email, color: AppColors.accentClr),
                  SizedBox(width: 8),
                  Text(
                    'exemple@appointify.com', // Replace with your actual store phone number
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Store Hours', // Add the heading for store hours
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: _buildDaysOfWork(),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildWorkTimes(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildDaysOfWork() {
    return Wrap(
      spacing: 8,
      children: [
        _buildDayOfWork('Monday'),
        _buildDayOfWork('Tuesday'),
        _buildDayOfWork('Wednesday'),
        _buildDayOfWork('Thursday'),
        _buildDayOfWork('Friday'),
        _buildDayOfWork('Saturday'),
        _buildDayOfWork('Sunday'),
      ],
    );
  }

  Widget _buildDayOfWork(String day) {
    return Chip(
      label: Text(day),
      backgroundColor: AppColors.accentClr,
      labelStyle: const TextStyle(color: Colors.white),
    );
  }

  Widget _buildWorkTimes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildWorkTime('AM', '08:00', '12:00'),
        _buildWorkTime('PM', '14:00', '18:00'),
      ],
    );
  }

  Widget _buildWorkTime(String period, String startTime, String endTime) {
    return Chip(
      label: Text(
        '$period: $startTime - $endTime',
        style: const TextStyle(fontSize: 16),
      ),
      backgroundColor: AppColors.accentClr,
      labelStyle: const TextStyle(color: Colors.white),
    );
  }
}
