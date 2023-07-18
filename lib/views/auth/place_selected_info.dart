// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/establishment.dart';

class PlaceSelectedInfo extends StatefulWidget {
  const PlaceSelectedInfo({super.key});

  @override
  PlaceSelectedInfoState createState() => PlaceSelectedInfoState();
}

class PlaceSelectedInfoState extends State<PlaceSelectedInfo> {
  final _formKey = GlobalKey<FormState>();
  final _establishment = Establishment(
    id: '', // You can generate a unique ID for the establishment using a package like uuid
    name: '',
    address: '',
    email: '',
    phoneNumber: 0,
    categories: [], // Initialize as an empty list
    workingDays: [], // Initialize as an empty list
    openTime: const TimeOfDay(hour: 9, minute: 0), // Default opening time
    closeTime: const TimeOfDay(hour: 17, minute: 0), // Default closing time
  );

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Create a new instance of Establishment with updated values
      final updatedEstablishment = Establishment(
        id: _establishment.id,
        name: _establishment.name,
        address: _establishment.address,
        email: _establishment.email,
        phoneNumber: _establishment.phoneNumber,
        categories: _establishment.categories,
        workingDays: _establishment.workingDays,
        openTime: _establishment.openTime,
        closeTime: _establishment.closeTime,
      );

      // You can now use the updatedEstablishment object to save the data or perform any other operations.

      // For example, print the data:
      print('Establishment Name: ${updatedEstablishment.name}');
      print('Categories: ${updatedEstablishment.categories}');
      print('Working Days: ${updatedEstablishment.workingDays}');
      print('Opening Time: ${updatedEstablishment.openTime}');
      print('Closing Time: ${updatedEstablishment.closeTime}');
    }
  }

  String _selectedCategory = 'Restaurant';
  final List<String> _categoriesOptions = [
    'Restaurant',
    'Salon',
    'Cabinet',
    'Cafe',
    'Bar',
    'Hotel',
    'Gym',
    'Park',
    'Hospital',
    'Pharmacy',
    'Library',
    'Museum',
    'School',
    'University',
    'Pet Store',
    'Supermarket',
    'Shopping Mall',
    'Movie Theater',
    'Amusement Park',
    'Beach',
    // Add more categories as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Place Information'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Name'),
                  onSaved: (value) => _establishment.name = value!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Address'),
                  onSaved: (value) => _establishment.address = value!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an address';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Email'),
                  onSaved: (value) => _establishment.email = value!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Phone Number'),
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onSaved: (value) =>
                      _establishment.phoneNumber = int.parse(value!),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a phone number';
                    }
                    return null;
                  },
                ),
                // Add input fields for categories, working days, and opening and closing times
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Categories'),
                  value: _selectedCategory,
                  items: _categoriesOptions.map((category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value!;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a category';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Working Days'),
                  onSaved: (value) {
                    _establishment.workingDays = value!.split(',');
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter working days separated by commas';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Opening Time'),
                  keyboardType: TextInputType.datetime,
                  onSaved: (value) {
                    final parts = value!.split(':');
                    final openTime = TimeOfDay(
                      hour: int.parse(parts[0]),
                      minute: int.parse(parts[1]),
                    );
                    _establishment.openTime = openTime;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the opening time in the format HH:mm';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Closing Time'),
                  keyboardType: TextInputType.datetime,
                  onSaved: (value) {
                    final parts = value!.split(':');
                    final closeTime = TimeOfDay(
                      hour: int.parse(parts[0]),
                      minute: int.parse(parts[1]),
                    );
                    _establishment.closeTime = closeTime;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the closing time in the format HH:mm';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: _saveForm,
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
