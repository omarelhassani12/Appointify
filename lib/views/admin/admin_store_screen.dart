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
              child: Text(
                'Store Description', // Replace with your actual store description
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.', // Replace with your actual store description
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Icon(Icons.location_on),
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
                  Icon(Icons.phone),
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
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Days of Work', // Add the heading for days of work
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                spacing: 8,
                children: [
                  _buildDayOfWork('Monday', '10:00 AM - 6:00 PM'),
                  _buildDayOfWork('Tuesday', '10:00 AM - 6:00 PM'),
                  _buildDayOfWork('Wednesday', '10:00 AM - 6:00 PM'),
                  _buildDayOfWork('Thursday', '10:00 AM - 6:00 PM'),
                  _buildDayOfWork('Friday', '10:00 AM - 6:00 PM'),
                  _buildDayOfWork('Saturday', '10:00 AM - 4:00 PM'),
                  // Add more days of work as needed
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors
                    .accentClr, 
              ),
              child: const Text(
                'Edit Store Info', 
                style: TextStyle(
                  color: Colors.white, 
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDayOfWork(String day, String time) {
    return Chip(
      label: Text('$day: $time'),
      backgroundColor: AppColors.accentClr,
      labelStyle: const TextStyle(color: Colors.white),
    );
  }
}
