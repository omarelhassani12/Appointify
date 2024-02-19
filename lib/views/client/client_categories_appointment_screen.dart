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
          padding: const EdgeInsets.all(10),
          children: [
            _buildCategoryCard(
              'Clinic Dental',
              'assets/categories/dental-clinic.png',
              'Find dental services near you.',
              [
                [
                  'Dental Clinic 1',
                  'assets/categories/dental-clinic.png',
                  'Mon - Fri',
                  '08:00 - 12:00'
                ],
                [
                  'Dental Clinic 2',
                  'assets/categories/dental-clinic.png',
                  'Mon - Fri',
                  '08:00 - 12:00'
                ],
                [
                  'Dental Clinic 3',
                  'assets/categories/dental-clinic.png',
                  'Mon - Fri',
                  '08:00 - 12:00'
                ],
              ],
            ),
            _buildCategoryCard(
              'Hair Salon',
              'assets/categories/hair-salon.png',
              'Get a new hairstyle at local hair salons.',
              [
                [
                  'Hair Salon 1',
                  'assets/categories/hair-salon.png',
                  'Mon - Fri',
                  '08:00 - 12:00'
                ],
                [
                  'Hair Salon 2',
                  'assets/categories/hair-salon.png',
                  'Mon - Fri',
                  '08:00 - 12:00'
                ],
                [
                  'Hair Salon 3',
                  'assets/categories/hair-salon.png',
                  'Mon - Fri',
                  '08:00 - 12:00'
                ],
              ],
            ),
            _buildCategoryCard(
              'Fitness Center',
              'assets/categories/fitness-center.png',
              'Stay fit and healthy at nearby fitness centers.',
              [
                [
                  'Fitness 1',
                  'assets/categories/fitness-center.png',
                  'Mon - Fri',
                  '08:00 - 12:00'
                ],
                [
                  'Fitness 2',
                  'assets/categories/fitness-center.png',
                  'Mon - Fri',
                  '08:00 - 12:00'
                ],
                [
                  'Fitness 3',
                  'assets/categories/fitness-center.png',
                  'Mon - Fri',
                  '08:00 - 12:00'
                ],
              ],
            ),
            _buildCategoryCard(
              'Spa & Wellness',
              'assets/categories/spa-&-wellness.png',
              'Relax and rejuvenate at local spas and wellness centers.',
              [
                [
                  'Spa 1',
                  'assets/categories/spa-&-wellness.png',
                  'Mon - Fri',
                  '08:00 - 12:00'
                ],
                [
                  'Spa 2',
                  'assets/categories/spa-&-wellness.png',
                  'Mon - Fri',
                  '08:00 - 12:00'
                ],
                [
                  'Wellness',
                  'assets/categories/spa-&-wellness.png',
                  'Mon - Fri',
                  '08:00 - 12:00'
                ],
              ],
            ),
            _buildCategoryCard(
              'Restaurant',
              'assets/categories/restaurant.png',
              'Enjoy delicious meals at various restaurants in your area.',
              [
                [
                  'Restaurant 1',
                  'assets/categories/restaurant.png',
                  'Mon - Fri',
                  '08:00 - 12:00'
                ],
                [
                  'Restaurant 2',
                  'assets/categories/restaurant.png',
                  'Mon - Fri',
                  '08:00 - 12:00'
                ],
                [
                  'Restaurant 3',
                  'assets/categories/restaurant.png',
                  'Mon - Fri',
                  '08:00 - 12:00'
                ],
              ],
            ),
            _buildCategoryCard(
              'Coffee Shop',
              'assets/categories/coffee-shop.png',
              'Find cozy coffee shops for your caffeine fix.',
              [
                [
                  'Coffee Shop 1',
                  'assets/categories/coffee-shop.png',
                  'Mon - Fri',
                  '08:00 - 12:00'
                ],
                [
                  'Coffee Shop 2',
                  'assets/categories/coffee-shop.png',
                  'Mon - Fri',
                  '08:00 - 12:00'
                ],
                [
                  'Coffee Shop 3',
                  'assets/categories/coffee-shop.png',
                  'Mon - Fri',
                  '08:00 - 12:00'
                ],
              ],
            ),
            _buildCategoryCard(
              'Bookstore',
              'assets/categories/book-store.png',
              'Discover your next favorite book at local bookstores.',
              [
                [
                  'Bookstore 1',
                  'assets/categories/book-store.png',
                  'Mon - Fri',
                  '08:00 - 12:00'
                ],
                [
                  'Bookstore 2',
                  'assets/categories/book-store.png',
                  'Mon - Fri',
                  '08:00 - 12:00'
                ],
                [
                  'Bookstore 3',
                  'assets/categories/book-store.png',
                  'Mon - Fri',
                  '08:00 - 12:00'
                ],
                [
                  'Bookstore 2',
                  'assets/categories/book-store.png',
                  'Mon - Fri',
                  '08:00 - 12:00'
                ],
                [
                  'Bookstore 3',
                  'assets/categories/book-store.png',
                  'Mon - Fri',
                  '08:00 - 12:00'
                ],
                [
                  'Bookstore 2',
                  'assets/categories/book-store.png',
                  'Mon - Fri',
                  '08:00 - 12:00'
                ],
                [
                  'Bookstore 2',
                  'assets/categories/book-store.png',
                  'Mon - Fri',
                  '08:00 - 12:00'
                ],
                [
                  'Bookstore 2',
                  'assets/categories/book-store.png',
                  'Mon - Fri',
                  '08:00 - 12:00'
                ],
                [
                  'Bookstore 2',
                  'assets/categories/book-store.png',
                  'Mon - Fri',
                  '08:00 - 12:00'
                ],
                [
                  'Bookstore 3',
                  'assets/categories/book-store.png',
                  'Mon - Fri',
                  '08:00 - 12:00'
                ],
                [
                  'Bookstore 2',
                  'assets/categories/book-store.png',
                  'Mon - Fri',
                  '08:00 - 12:00'
                ],
                [
                  'Bookstore 3',
                  'assets/categories/book-store.png',
                  'Mon - Fri',
                  '08:00 - 12:00'
                ],
                [
                  'Bookstore 2',
                  'assets/categories/book-store.png',
                  'Mon - Fri',
                  '08:00 - 12:00'
                ],
                [
                  'Bookstore 2',
                  'assets/categories/book-store.png',
                  'Mon - Fri',
                  '08:00 - 12:00'
                ],
                [
                  'Bookstore 2',
                  'assets/categories/book-store.png',
                  'Mon - Fri',
                  '08:00 - 12:00'
                ],
                [
                  'Bookstore 3',
                  'assets/categories/book-store.png',
                  'Mon - Fri',
                  '08:00 - 12:00'
                ],
              ],
            ),
            _buildCategoryCard(
              'Art Gallery',
              'assets/categories/art-gallery.png',
              'Explore art and culture at nearby art galleries.',
              [
                [
                  'Art Gallery 1',
                  'assets/categories/art-gallery.png',
                  'Mon - Fri',
                  '08:00 - 12:00'
                ],
                [
                  'Art Gallery 2',
                  'assets/categories/art-gallery.png',
                  'Mon - Fri',
                  '08:00 - 12:00'
                ],
                [
                  'Art Gallery 3',
                  'assets/categories/art-gallery.png',
                  'Mon - Fri',
                  '08:00 - 12:00'
                ],
              ],
            ),
            _buildCategoryCard(
              'Bakery',
              'assets/categories/bakery.png',
              'Indulge in freshly baked goods at local bakeries.',
              [
                [
                  'Bakery 1',
                  'assets/categories/bakery.png',
                  'Mon - Fri',
                  '08:00 - 12:00'
                ],
                [
                  'Bakery 2',
                  'assets/categories/bakery.png',
                  'Mon - Fri',
                  '08:00 - 12:00'
                ],
                [
                  'Bakery 3',
                  'assets/categories/bakery.png',
                  'Mon - Fri',
                  '08:00 - 12:00'
                ],
              ],
            ),
            _buildCategoryCard(
              'Garden Center',
              'assets/categories/garden-center.png',
              'Find gardening supplies and plants at garden centers.',
              [
                [
                  'Garden 1',
                  'assets/categories/garden-center.png',
                  'Mon - Fri',
                  '08:00 - 12:00'
                ],
                [
                  'Garden 2',
                  'assets/categories/garden-center.png',
                  'Mon - Fri',
                  '08:00 - 12:00'
                ],
                [
                  'Garden 3',
                  'assets/categories/garden-center.png',
                  'Mon - Fri',
                  '08:00 - 12:00'
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(String name, String imagePath, String description,
      List<List<String>> places) {
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
