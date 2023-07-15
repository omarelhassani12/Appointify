import 'package:appointify/utils/colors.dart';
import 'package:flutter/material.dart';

class ClientCategoriesAppointmentDetails extends StatelessWidget {
  final String categoryName;
  final String categoryDescription;
  final String imagePath;
  final List<String> places;

  const ClientCategoriesAppointmentDetails({
    super.key,
    required this.categoryName,
    required this.categoryDescription,
    required this.imagePath,
    required this.places,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$categoryName\'s Details'),
        centerTitle: true,
        backgroundColor: AppColors.accentClr,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            imagePath,
            fit: BoxFit.cover,
            height: 200,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              categoryDescription,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
                childAspectRatio: 0.8,
              ),
              itemCount: places.length,
              itemBuilder: (context, index) {
                final placeName = places[index];
                return ItemsCard(
                  name: placeName,
                  logoPath: "assets/images/appointify.png",
                  workDays: 'Mon - fri',
                  workTimes: '08:00 - 12:00',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ItemsCard extends StatelessWidget {
  final String name;
  final String logoPath;
  final String workDays;
  final String workTimes;

  const ItemsCard({
    super.key,
    required this.name,
    required this.logoPath,
    required this.workDays,
    required this.workTimes,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                logoPath,
                width: 64,
                height: 64,
              ),
              const SizedBox(height: 8),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildRow(Icons.calendar_month, workDays, context),
                    const SizedBox(height: 2),
                    buildRow(Icons.access_alarm, workTimes, context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRow(IconData iconData, String text, BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth <= 360;

    return Row(
      children: [
        Icon(iconData, size: isSmallScreen ? 12 : 16),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: isSmallScreen ? 12 : 14,
            fontWeight: FontWeight.bold,
            color: AppColors.accentClr,
          ),
        ),
      ],
    );
  }
}

