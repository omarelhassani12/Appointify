import 'package:appointify/utils/colors.dart';
import 'package:flutter/material.dart';

class SearchAppointmentScreen extends StatefulWidget {
  const SearchAppointmentScreen({Key? key}) : super(key: key);

  @override
  _SearchAppointmentScreenState createState() =>
      _SearchAppointmentScreenState();
}

class _SearchAppointmentScreenState extends State<SearchAppointmentScreen> {
  String searchQuery = '';
  String selectedCountry = '';
  String selectedCity = '';
  String selectedType = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Appointments'),
        backgroundColor: AppColors.accentClr,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedCountry,
                    decoration: const InputDecoration(
                      labelText: 'Country',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        selectedCountry = value!;
                      });
                    },
                    items: [
                      const DropdownMenuItem(
                        value: '',
                        child: Text('All Countries'),
                      ),
                      const DropdownMenuItem(
                        value: 'Country 1',
                        child: Text('Country 1'),
                      ),
                      const DropdownMenuItem(
                        value: 'Country 2',
                        child: Text('Country 2'),
                      ),
                      // Add more countries as needed
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedCity,
                    decoration: const InputDecoration(
                      labelText: 'City',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        selectedCity = value!;
                      });
                    },
                    items: [
                      const DropdownMenuItem(
                        value: '',
                        child: Text('All Cities'),
                      ),
                      const DropdownMenuItem(
                        value: 'City 1',
                        child: Text('City 1'),
                      ),
                      const DropdownMenuItem(
                        value: 'City 2',
                        child: Text('City 2'),
                      ),
                      // Add more cities as needed
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: 10, // Replace with the actual count of search results
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Navigate to appointment details screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AppointmentDetailsScreen(),
                      ),
                    );
                  },
                  child: Card(
                    child: ListTile(
                      title: Text('Appointment Name $index'),
                      subtitle: Text('Appointment Date and Time'),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
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
