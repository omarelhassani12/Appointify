// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/establishment.dart';
import '../../models/latlangPosition.dart';

class PlaceSelectedInfo extends StatefulWidget {
  final String country;
  final LatLngPosition position;

  const PlaceSelectedInfo({
    Key? key,
    required this.country,
    required this.position,
  }) : super(key: key);

  @override
  PlaceSelectedInfoState createState() => PlaceSelectedInfoState();
}

class PlaceSelectedInfoState extends State<PlaceSelectedInfo> {
  final _formKey = GlobalKey<FormState>();
  late Establishment _establishment;

  @override
  void initState() {
    super.initState();
    _establishment = Establishment(
      id: '', // You can generate a unique ID for the establishment using a package like uuid
      name: '',
      address: '',
      email: '',
      phoneNumber: 0,
      categories: [], // Initialize as an empty list
      workingDays: [], // Initialize as an empty list
      openTime: const TimeOfDay(hour: 9, minute: 0), // Default opening time
      closeTime: const TimeOfDay(hour: 17, minute: 0), // Default closing time
      country: widget.country,

      position: widget.position,
    );
  }

  final TextEditingController _workingDaysController = TextEditingController();

  @override
  void dispose() {
    _workingDaysController.dispose();
    super.dispose();
  }

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
        country: _establishment.country, // Include country
        position: _establishment.position, // Include position
        categories: _establishment.categories,
        workingDays: _establishment.workingDays,
        openTime: _establishment.openTime,
        closeTime: _establishment.closeTime,
      );

      // You can now use the updatedEstablishment object to save the data or perform any other operations.

      // For example, print the data:
      print('Establishment Name: ${updatedEstablishment.name}');
      print('Country: ${updatedEstablishment.country}');
      print('Position: ${updatedEstablishment.position}');
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

  final List<String> weekdays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  List<String> selectedWeekdays = [];

  void _showWeekdaysDialog() async {
    final List<String> tempSelectedWeekdays = List.from(selectedWeekdays);

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Working Days'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                child: Column(
                  children: weekdays.map((day) {
                    return CheckboxListTile(
                      title: Text(day),
                      value: tempSelectedWeekdays.contains(day),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value != null && value) {
                            tempSelectedWeekdays.add(day);
                          } else {
                            tempSelectedWeekdays.remove(day);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              );
            },
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedWeekdays = tempSelectedWeekdays;
                  _workingDaysController.text = selectedWeekdays
                      .map((day) => _getAbbreviatedWeekday(day))
                      .join(', ');
                });

                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

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
                  decoration: const InputDecoration(labelText: 'Country'),
                  initialValue: widget.country,
                  enabled: false,
                  onSaved: (value) => _establishment.country = value!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an address';
                    }
                    return null;
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Latitude'),
                        enabled: false,
                        onSaved: (value) => _establishment.position.latitude =
                            double.parse(value!),
                        initialValue: widget.position.latitude.toString(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the latitude';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Longitude'),
                        enabled: false,
                        onSaved: (value) => _establishment.position.longitude =
                            double.parse(value!),
                        initialValue: widget.position.longitude.toString(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the longitude';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
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
                GestureDetector(
                  onTap: _showWeekdaysDialog,
                  child: TextFormField(
                    controller: _workingDaysController,
                    decoration:
                        const InputDecoration(labelText: 'Working Days'),
                    enabled: false,
                  ),
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

  String _getAbbreviatedWeekday(String weekday) {
    return weekday.substring(0, 3);
  }
}
