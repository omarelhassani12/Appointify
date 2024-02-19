import 'package:flutter/material.dart';

import 'client_categories_appointment_details.dart';

class CategoriesAppointmentScreen extends StatefulWidget {
  const CategoriesAppointmentScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesAppointmentScreen> createState() =>
      _CategoriesAppointmentScreenState();
}

class _CategoriesAppointmentScreenState
    extends State<CategoriesAppointmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: GridView.count(
          crossAxisCount: 2, // Number of columns in the grid
          mainAxisSpacing: 6, // Spacing between rows
          crossAxisSpacing: 6, // Spacing between columns
          padding: const EdgeInsets.all(10), // Padding around the grid
          children: [
            _buildCategoryCard(
              'Clinic Dental',
              'assets/categories/dental-clinic.png',
              'Find dental services near you.',
              ['Dental Clinic 1', 'Dental Clinic 2', 'Dental Clinic 3'],
            ),
            _buildCategoryCard(
              'Hair Salon',
              'assets/categories/hair-salon.png',
              'Get a new hairstyle at local hair salons.',
              ['Hair Salon 1', 'Hair Salon 2', 'Hair Salon 3'],
            ),
            _buildCategoryCard(
              'Fitness Center',
              'assets/categories/fitness-center.png',
              'Stay fit and healthy at nearby fitness centers.',
              ['Fitness 1', 'Fitness 2', 'Fitness 3'],
            ),
            _buildCategoryCard(
              'Spa & Wellness',
              'assets/categories/spa-&-wellness.png',
              'Relax and rejuvenate at local spas and wellness centers.',
              ['Spa 1', 'Spa 2', 'Wellness'],
            ),
            _buildCategoryCard(
              'Restaurant',
              'assets/categories/restaurant.png',
              'Enjoy delicious meals at various restaurants in your area.',
              ['Restaurant 1', 'Restaurant 2', 'Restaurant 3'],
            ),
            _buildCategoryCard(
              'Coffee Shop',
              'assets/categories/coffee-shop.png',
              'Find cozy coffee shops for your caffeine fix.',
              ['Coffee Shop 1', 'Coffee Shop 2', 'Coffee Shop 3'],
            ),
            _buildCategoryCard(
              'Bookstore',
              'assets/categories/book-store.png',
              'Discover your next favorite book at local bookstores.',
              [
                'Bookstore 1',
                'Bookstore 2',
                'Bookstore 3',
                'Bookstore 2',
                'Bookstore 3',
                'Bookstore 2',
                'Bookstore 2',
                'Bookstore 2',
                'Bookstore 2',
                'Bookstore 3',
                'Bookstore 2',
                'Bookstore 3',
                'Bookstore 2',
                'Bookstore 2',
                'Bookstore 2',
                'Bookstore 3'
              ],
            ),
            _buildCategoryCard(
              'Art Gallery',
              'assets/categories/art-gallery.png',
              'Explore art and culture at nearby art galleries.',
              ['Art Gallery 1', 'Art Gallery 2', 'Art Gallery 3'],
            ),
            _buildCategoryCard(
              'Bakery',
              'assets/categories/bakery.png',
              'Indulge in freshly baked goods at local bakeries.',
              ['Bakery 1', 'Bakery 2', 'Bakery 3'],
            ),
            _buildCategoryCard(
              'Garden Center',
              'assets/categories/garden-center.png',
              'Find gardening supplies and plants at garden centers.',
              ['Garden 1', 'Garden 2', 'Garden 3'],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(
      String name, String imagePath, String description, List<String> places) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ClientCategoriesAppointmentDetails(
              categoryName: name,
              categoryDescription: description,
              imagePath: imagePath,
              places: places,
            ),
          ),
        );
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
              width: 100,
              height: 100,
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
