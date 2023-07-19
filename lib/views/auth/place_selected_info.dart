// ignore_for_file: avoid_print

import 'package:appointify/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:intl/intl.dart';

import '../../models/establishment.dart';
import '../../models/latlangposition.dart';
import '../../widgets/text_form_field.dart';
import '../admin/admin_home_screen.dart';

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
      categories: [],
      workingDays: [],
      openningTimeAm: DateTime(0, 1, 1, 17, 0),
      openningTimePm: DateTime(0, 1, 1, 17, 0),
      closingTimeAm: DateTime(0, 1, 1, 17, 0),
      closingTimePm: DateTime(0, 1, 1, 17, 0),
      country: widget.country,

      position: widget.position,
    );
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _workingDaysController = TextEditingController();
  final TextEditingController _openingTimeAMController =
      TextEditingController();
  final TextEditingController _openingTimePMController =
      TextEditingController();
  final TextEditingController _closingTimeAMController =
      TextEditingController();
  final TextEditingController _closingTimePMController =
      TextEditingController();

  @override
  void dispose() {
    _workingDaysController.dispose();
    _openingTimeAMController.dispose();
    _openingTimePMController.dispose();
    super.dispose();
  }

  void _saveForm() {
    // if (_formKey.currentState!.validate()) {
    //   _formKey.currentState!.save();

    _establishment.workingDays =
        selectedWeekdays.map(_getAbbreviatedWeekday).toList();

    // Create a new instance of Establishment with updated values
    final updatedEstablishment = Establishment(
      id: _establishment.id,
      name: _establishment.name,
      address: _establishment.address,
      email: _establishment.email,
      phoneNumber: _establishment.phoneNumber,
      country: _establishment.country, // Include country
      position: _establishment.position, // Include position
      categories: [_selectedCategory], // Update selected category
      workingDays: selectedWeekdays
          .map(_getAbbreviatedWeekday)
          .toList(), // Update working days
      openningTimeAm: _establishment.openningTimeAm, // Store the AM time
      openningTimePm: _establishment.openningTimePm, // Store the PM time
      closingTimeAm: _establishment.closingTimeAm, // Store the AM time
      closingTimePm: _establishment.closingTimePm, // Store the PM time
    );

    // You can now use the updatedEstablishment object to save the data or perform any other operations.

    // For example, print the data:
    print('Establishment Name: ${updatedEstablishment.name}');
    print('Establishment Address: ${updatedEstablishment.address}');
    print('Country: ${updatedEstablishment.country}');
    print('Position: ${updatedEstablishment.position}');
    print('Categories: ${updatedEstablishment.categories}');
    print('Working Days: ${updatedEstablishment.workingDays}');
    print('Opening Time AM: ${updatedEstablishment.openningTimeAm}');
    print('Closing Time AM: ${updatedEstablishment.closingTimeAm}');
    print('Opening Time PM: ${updatedEstablishment.openningTimePm}');
    print('Closing Time PM: ${updatedEstablishment.closingTimePm}');

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const AdminHomeScreen()),
    );
    // }
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
              style: ElevatedButton.styleFrom(
                foregroundColor: AppColors.whiteClr,
                backgroundColor: AppColors.accentClr,
              ),
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
        centerTitle: true,
        backgroundColor: AppColors.accentClr,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InfoTextFormField(
                        controller: _nameController,
                        onSaved: (value) => _establishment.name = value!,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Address',
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.accentClr),
                          ),
                          labelStyle: TextStyle(
                            color: AppColors.accentClr,
                          ),
                          focusColor: AppColors.accentClr,
                        ),
                        cursorColor: AppColors.accentClr,
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
                            return 'Please enter a country';
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
                              onSaved: (value) => _establishment
                                  .position.latitude = double.parse(value!),
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
                              onSaved: (value) => _establishment
                                  .position.longitude = double.parse(value!),
                              initialValue:
                                  widget.position.longitude.toString(),
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
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.accentClr),
                          ),
                          labelStyle: TextStyle(
                            color: AppColors.accentClr,
                          ),
                          focusColor: AppColors.accentClr,
                        ),
                        cursorColor: AppColors.accentClr,
                        onSaved: (value) => _establishment.email = value!,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an email';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Phone Number',
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.accentClr),
                          ),
                          labelStyle: TextStyle(
                            color: AppColors.accentClr,
                          ),
                          focusColor: AppColors.accentClr,
                        ),
                        cursorColor: AppColors.accentClr,
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
                        decoration: const InputDecoration(
                          labelText: 'Categories',
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.accentClr),
                          ),
                          labelStyle: TextStyle(
                            color: AppColors.accentClr,
                          ),
                          focusColor: AppColors.accentClr,
                        ),
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
                            _establishment.categories = [
                              value
                            ]; // Update the selected category
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
                          decoration: const InputDecoration(
                            labelText: 'Working Days',
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.accentClr),
                            ),
                            focusColor: AppColors.accentClr,
                          ),
                          cursorColor: AppColors.accentClr,
                          enabled: false,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              readOnly: true,
                              controller: _openingTimeAMController,
                              onTap: () {
                                _showTimePicker(true, false);
                              },
                              decoration: InputDecoration(
                                labelText: 'Opening Time (AM)',
                                labelStyle: TextStyle(
                                  color:
                                      _openingTimeAMController.text.isNotEmpty
                                          ? AppColors.accentClr
                                          : null,
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.accentClr,
                                  ),
                                ),
                                suffixIcon: Icon(
                                  Icons.access_time,
                                  color:
                                      _openingTimeAMController.text.isNotEmpty
                                          ? AppColors.accentClr
                                          : null,
                                ),
                              ),
                              cursorColor: AppColors.accentClr,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select the opening time (AM)';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              readOnly: true,
                              controller: _closingTimeAMController,
                              decoration: InputDecoration(
                                labelText: 'Closing Time (AM)',
                                labelStyle: TextStyle(
                                  color:
                                      _closingTimeAMController.text.isNotEmpty
                                          ? AppColors.accentClr
                                          : null,
                                ),
                                suffixIcon: Icon(
                                  Icons.access_time,
                                  color:
                                      _closingTimeAMController.text.isNotEmpty
                                          ? AppColors.accentClr
                                          : null,
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.accentClr),
                                ),
                                focusColor: AppColors.accentClr,
                              ),
                              onTap: () => _showTimePicker(true, true),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select the closing time (AM)';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              readOnly: true,
                              controller: _openingTimePMController,
                              decoration: InputDecoration(
                                labelText: 'Opening Time (PM)',
                                labelStyle: TextStyle(
                                  color:
                                      _openingTimePMController.text.isNotEmpty
                                          ? AppColors.accentClr
                                          : null,
                                ),
                                suffixIcon: Icon(
                                  Icons.access_time,
                                  color:
                                      _openingTimePMController.text.isNotEmpty
                                          ? AppColors.accentClr
                                          : null,
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.accentClr),
                                ),
                                focusColor: AppColors.accentClr,
                              ),
                              onTap: () => _showTimePicker(false, false),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select the opening time (PM)';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              readOnly: true,
                              controller: _closingTimePMController,
                              decoration: InputDecoration(
                                labelText: 'Closing Time (PM)',
                                labelStyle: TextStyle(
                                  color:
                                      _closingTimePMController.text.isNotEmpty
                                          ? AppColors.accentClr
                                          : null,
                                ),
                                suffixIcon: Icon(
                                  Icons.access_time,
                                  color:
                                      _closingTimePMController.text.isNotEmpty
                                          ? AppColors.accentClr
                                          : null,
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.accentClr),
                                ),
                                focusColor: AppColors.accentClr,
                              ),
                              onTap: () => _showTimePicker(false,
                                  true), // Updated to use the correct time picker for PM
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select the closing time (PM)';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: SizedBox(
                          width: 100,
                          child: ElevatedButton(
                            onPressed: _saveForm,
                            style: ElevatedButton.styleFrom(
                              foregroundColor: AppColors.whiteClr,
                              backgroundColor: AppColors.accentClr,
                            ),
                            child: const Text('Save'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getAbbreviatedWeekday(String weekday) {
    return weekday.substring(0, 3);
  }

  void _showTimePicker(bool isAM, bool isClosingTime) {
    final now = DateTime.now();
    final currentTime =
        isAM ? _establishment.openningTimeAm : _establishment.openningTimePm;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: isAM
              ? const Text('Select Opening Time (AM)')
              : const Text('Select Opening Time (PM)'),
          content: TimePickerSpinner(
            time: currentTime,
            is24HourMode: false,
            normalTextStyle: const TextStyle(fontSize: 24, color: Colors.black),
            highlightedTextStyle:
                const TextStyle(fontSize: 24, color: AppColors.accentClr),
            spacing: 40,
            itemHeight: 80,
            isForce2Digits: true,
            minutesInterval: 15,
            onTimeChange: (time) {
              final pickedTime = DateTime(
                now.year,
                now.month,
                now.day,
                time.hour,
                time.minute,
              );
              final formattedTime = DateFormat.jm().format(pickedTime);
              setState(() {
                if (isAM) {
                  if (isClosingTime) {
                    _establishment.closingTimeAm = pickedTime;
                    _closingTimeAMController.text = formattedTime;
                  } else {
                    _establishment.openningTimeAm = pickedTime;
                    _openingTimeAMController.text = formattedTime;
                  }
                } else {
                  if (isClosingTime) {
                    _establishment.closingTimePm = pickedTime;
                    _closingTimePMController.text = formattedTime;
                  } else {
                    _establishment.openningTimePm = pickedTime;
                    _openingTimePMController.text = formattedTime;
                  }
                }
              });
            },
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: AppColors.whiteClr,
                backgroundColor: AppColors.accentClr,
              ),
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
