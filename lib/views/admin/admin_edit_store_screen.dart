// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

import '../../models/establishment.dart';
import '../../utils/colors.dart';

class AdminEditStoreScreen extends StatefulWidget {
  const AdminEditStoreScreen({super.key});

  @override
  State<AdminEditStoreScreen> createState() => AdminEditStoreScreenState();
}

class AdminEditStoreScreenState extends State<AdminEditStoreScreen> {
  final _formKey = GlobalKey<FormState>();
  late Establishment _establishment;
  File? _imageFile;

  void _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
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

  @override
  void initState() {
    super.initState();
    _establishment = Establishment(
      id: '',
      name: '',
      address: '',
      email: '',
      phoneNumber: 0,
      categories: [],
      workingDays: [],
      openningTimeAm: DateTime(0, 1, 1, 9, 0), // Set AM time to 9:00 AM
      openningTimePm: DateTime(0, 1, 1, 17, 0), // Set PM time to 5:00 PM
      closingTimeAm:
          DateTime(0, 1, 1, 12, 0), // Set AM closing time to 12:00 PM
      closingTimePm:
          DateTime(0, 1, 1, 22, 0), // Set PM closing time to 10:00 PM
      country: "",
      position: null,
    );
  }

  void _saveForm() {
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
        title: const Text('Change Place Information'),
        centerTitle: true,
        backgroundColor: AppColors.accentClr,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: _imageFile != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.file(_imageFile!,
                                      fit: BoxFit.cover),
                                )
                              : Icon(Icons.camera_alt,
                                  size: 40, color: Colors.grey[600]),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        // Replace this with InfoTextFormField or a regular TextFormField
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Name',
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.accentClr),
                          ),
                          labelStyle: TextStyle(
                            color: AppColors.accentClr,
                          ),
                          focusColor: AppColors.accentClr,
                        ),
                        cursorColor: AppColors.accentClr,
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
                        decoration: const InputDecoration(
                          labelText: 'Country',
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.accentClr),
                          ),
                          labelStyle: TextStyle(
                            color: AppColors.accentClr,
                          ),
                          focusColor: AppColors.accentClr,
                        ),
                        onSaved: (value) => _establishment.country = value!,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a country';
                          }
                          return null;
                        },
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
                              onTap: () => _showTimePicker(false, true),
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
                          width: 200,
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
    DateTime? initialTime;

    if (isAM) {
      initialTime = isClosingTime
          ? _establishment.closingTimeAm
          : _establishment.openningTimeAm;
    } else {
      initialTime = isClosingTime
          ? _establishment.closingTimePm
          : _establishment.openningTimePm;
    }

    String timeType;
    if (isAM) {
      timeType = 'AM';
    } else {
      timeType = 'PM';
    }
    String positionType;
    if (!isClosingTime) {
      positionType = 'opening';
    } else {
      positionType = 'closing';
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select $positionType Time ($timeType)'),
          content: TimePickerSpinner(
            time: initialTime ?? now,
            is24HourMode: true,
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









// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
// import 'package:intl/intl.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// import 'package:appointify/utils/colors.dart';
// import 'package:appointify/models/establishment.dart';

// import '../../widgets/text_form_field.dart';

// class AdminEditStoreScreen extends StatefulWidget {
//   const AdminEditStoreScreen({Key? key}) : super(key: key);

//   @override
//   State<AdminEditStoreScreen> createState() => AdminEditStoreScreenState();
// }

// class AdminEditStoreScreenState extends State<AdminEditStoreScreen> {
//   final _formKey = GlobalKey<FormState>();
//   late Establishment _establishment;
//   File? _imageFile;

//   void _pickImage() async {
//   final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

//   if (pickedFile != null) {
//     setState(() {
//       _imageFile = File(pickedFile.path);
//     });
//   }
// }



//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _workingDaysController = TextEditingController();
//   final TextEditingController _openingTimeAMController =
//       TextEditingController();
//   final TextEditingController _openingTimePMController =
//       TextEditingController();
//   final TextEditingController _closingTimeAMController =
//       TextEditingController();
//   final TextEditingController _closingTimePMController =
//       TextEditingController();

//   @override
//   void dispose() {
//     _workingDaysController.dispose();
//     _openingTimeAMController.dispose();
//     _openingTimePMController.dispose();
//     super.dispose();
//   }

//   @override
//   void initState() {
//     super.initState();
//     _establishment = Establishment(
//       id: '', // You can generate a unique ID for the establishment using a package like uuid
//       name: '',
//       address: '',
//       email: '',
//       phoneNumber: 0,
//       categories: [],
//       workingDays: [],
//       openningTimeAm: DateTime(0, 1, 1, 9, 0), // Set AM time to 9:00 AM
//       openningTimePm: DateTime(0, 1, 1, 17, 0), // Set PM time to 5:00 PM
//       closingTimeAm:
//           DateTime(0, 1, 1, 12, 0), // Set AM closing time to 12:00 PM
//       closingTimePm:
//           DateTime(0, 1, 1, 22, 0), // Set PM closing time to 10:00 PM
//       country: "",
//       position: null,
//     );
//   }

//   void _saveForm() {
//     _establishment.workingDays =
//         selectedWeekdays.map(_getAbbreviatedWeekday).toList();

//     // Create a new instance of Establishment with updated values
//     final updatedEstablishment = Establishment(
//       id: _establishment.id,
//       name: _establishment.name,
//       address: _establishment.address,
//       email: _establishment.email,
//       phoneNumber: _establishment.phoneNumber,
//       country: _establishment.country, // Include country
//       position: _establishment.position, // Include position
//       categories: [_selectedCategory], // Update selected category
//       workingDays: selectedWeekdays
//           .map(_getAbbreviatedWeekday)
//           .toList(), // Update working days
//       openningTimeAm: _establishment.openningTimeAm, // Store the AM time
//       openningTimePm: _establishment.openningTimePm, // Store the PM time
//       closingTimeAm: _establishment.closingTimeAm, // Store the AM time
//       closingTimePm: _establishment.closingTimePm, // Store the PM time
//     );

//     // You can now use the updatedEstablishment object to save the data or perform any other operations.

//     // For example, print the data:
//     print('Establishment Name: ${updatedEstablishment.name}');
//     print('Establishment Address: ${updatedEstablishment.address}');
//     print('Country: ${updatedEstablishment.country}');
//     print('Position: ${updatedEstablishment.position}');
//     print('Categories: ${updatedEstablishment.categories}');
//     print('Working Days: ${updatedEstablishment.workingDays}');
//     print('Opening Time AM: ${updatedEstablishment.openningTimeAm}');
//     print('Closing Time AM: ${updatedEstablishment.closingTimeAm}');
//     print('Opening Time PM: ${updatedEstablishment.openningTimePm}');
//     print('Closing Time PM: ${updatedEstablishment.closingTimePm}');

//     // }
//   }

//   String _selectedCategory = 'Restaurant';
//   final List<String> _categoriesOptions = [
//     'Restaurant',
//     'Salon',
//     'Cabinet',
//     'Cafe',
//     'Bar',
//     'Hotel',
//     'Gym',
//     'Park',
//     'Hospital',
//     'Pharmacy',
//     'Library',
//     'Museum',
//     'School',
//     'University',
//     'Pet Store',
//     'Supermarket',
//     'Shopping Mall',
//     'Movie Theater',
//     'Amusement Park',
//     'Beach',
//     // Add more categories as needed
//   ];

//   final List<String> weekdays = [
//     'Monday',
//     'Tuesday',
//     'Wednesday',
//     'Thursday',
//     'Friday',
//     'Saturday',
//     'Sunday'
//   ];

//   List<String> selectedWeekdays = [];

//   void _showWeekdaysDialog() async {
//     final List<String> tempSelectedWeekdays = List.from(selectedWeekdays);

//     await showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Select Working Days'),
//           content: StatefulBuilder(
//             builder: (BuildContext context, StateSetter setState) {
//               return SingleChildScrollView(
//                 child: Column(
//                   children: weekdays.map((day) {
//                     return CheckboxListTile(
//                       title: Text(day),
//                       value: tempSelectedWeekdays.contains(day),
//                       onChanged: (bool? value) {
//                         setState(() {
//                           if (value != null && value) {
//                             tempSelectedWeekdays.add(day);
//                           } else {
//                             tempSelectedWeekdays.remove(day);
//                           }
//                         });
//                       },
//                     );
//                   }).toList(),
//                 ),
//               );
//             },
//           ),
//           actions: [
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text('Cancel'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   selectedWeekdays = tempSelectedWeekdays;
//                   _workingDaysController.text = selectedWeekdays
//                       .map((day) => _getAbbreviatedWeekday(day))
//                       .join(', ');
//                 });

//                 Navigator.pop(context);
//               },
//               style: ElevatedButton.styleFrom(
//                 foregroundColor: AppColors.whiteClr,
//                 backgroundColor: AppColors.accentClr,
//               ),
//               child: const Text('Save'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Place Information'),
//         centerTitle: true,
//         backgroundColor: AppColors.accentClr,
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       InfoTextFormField(
//                         controller: _nameController,
//                         onSaved: (value) => _establishment.name = value!,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter a name';
//                           }
//                           return null;
//                         },
//                       ),
//                       TextFormField(
//                         decoration: const InputDecoration(
//                           labelText: 'Address',
//                           focusedBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(color: AppColors.accentClr),
//                           ),
//                           labelStyle: TextStyle(
//                             color: AppColors.accentClr,
//                           ),
//                           focusColor: AppColors.accentClr,
//                         ),
//                         cursorColor: AppColors.accentClr,
//                         onSaved: (value) => _establishment.address = value!,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter an address';
//                           }
//                           return null;
//                         },
//                       ),
//                       TextFormField(
//                         decoration: const InputDecoration(labelText: 'Country'),
//                         onSaved: (value) => _establishment.country = value!,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter a country';
//                           }
//                           return null;
//                         },
//                       ),
//                       TextFormField(
//                         decoration: const InputDecoration(
//                           labelText: 'Email',
//                           focusedBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(color: AppColors.accentClr),
//                           ),
//                           labelStyle: TextStyle(
//                             color: AppColors.accentClr,
//                           ),
//                           focusColor: AppColors.accentClr,
//                         ),
//                         cursorColor: AppColors.accentClr,
//                         onSaved: (value) => _establishment.email = value!,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter an email';
//                           }
//                           return null;
//                         },
//                       ),
//                       TextFormField(
//                         decoration: const InputDecoration(
//                           labelText: 'Phone Number',
//                           focusedBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(color: AppColors.accentClr),
//                           ),
//                           labelStyle: TextStyle(
//                             color: AppColors.accentClr,
//                           ),
//                           focusColor: AppColors.accentClr,
//                         ),
//                         cursorColor: AppColors.accentClr,
//                         keyboardType: TextInputType.phone,
//                         inputFormatters: [
//                           FilteringTextInputFormatter.digitsOnly,
//                         ],
//                         onSaved: (value) =>
//                             _establishment.phoneNumber = int.parse(value!),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter a phone number';
//                           }
//                           return null;
//                         },
//                       ),
//                       DropdownButtonFormField<String>(
//                         decoration: const InputDecoration(
//                           labelText: 'Categories',
//                           focusedBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(color: AppColors.accentClr),
//                           ),
//                           labelStyle: TextStyle(
//                             color: AppColors.accentClr,
//                           ),
//                           focusColor: AppColors.accentClr,
//                         ),
//                         value: _selectedCategory,
//                         items: _categoriesOptions.map((category) {
//                           return DropdownMenuItem<String>(
//                             value: category,
//                             child: Text(category),
//                           );
//                         }).toList(),
//                         onChanged: (value) {
//                           setState(() {
//                             _selectedCategory = value!;
//                             _establishment.categories = [
//                               value
//                             ]; // Update the selected category
//                           });
//                         },
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please select a category';
//                           }
//                           return null;
//                         },
//                       ),
//                       GestureDetector(
//                         onTap: _showWeekdaysDialog,
//                         child: TextFormField(
//                           controller: _workingDaysController,
//                           decoration: const InputDecoration(
//                             labelText: 'Working Days',
//                             focusedBorder: UnderlineInputBorder(
//                               borderSide:
//                                   BorderSide(color: AppColors.accentClr),
//                             ),
//                             focusColor: AppColors.accentClr,
//                           ),
//                           cursorColor: AppColors.accentClr,
//                           enabled: false,
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: TextFormField(
//                               readOnly: true,
//                               controller: _openingTimeAMController,
//                               onTap: () {
//                                 _showTimePicker(true, false);
//                               },
//                               decoration: InputDecoration(
//                                 labelText: 'Opening Time (AM)',
//                                 labelStyle: TextStyle(
//                                   color:
//                                       _openingTimeAMController.text.isNotEmpty
//                                           ? AppColors.accentClr
//                                           : null,
//                                 ),
//                                 focusedBorder: const UnderlineInputBorder(
//                                   borderSide: BorderSide(
//                                     color: AppColors.accentClr,
//                                   ),
//                                 ),
//                                 suffixIcon: Icon(
//                                   Icons.access_time,
//                                   color:
//                                       _openingTimeAMController.text.isNotEmpty
//                                           ? AppColors.accentClr
//                                           : null,
//                                 ),
//                               ),
//                               cursorColor: AppColors.accentClr,
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Please select the opening time (AM)';
//                                 }
//                                 return null;
//                               },
//                             ),
//                           ),
//                           const SizedBox(width: 16),
//                           Expanded(
//                             child: TextFormField(
//                               readOnly: true,
//                               controller: _closingTimeAMController,
//                               decoration: InputDecoration(
//                                 labelText: 'Closing Time (AM)',
//                                 labelStyle: TextStyle(
//                                   color:
//                                       _closingTimeAMController.text.isNotEmpty
//                                           ? AppColors.accentClr
//                                           : null,
//                                 ),
//                                 suffixIcon: Icon(
//                                   Icons.access_time,
//                                   color:
//                                       _closingTimeAMController.text.isNotEmpty
//                                           ? AppColors.accentClr
//                                           : null,
//                                 ),
//                                 focusedBorder: const UnderlineInputBorder(
//                                   borderSide:
//                                       BorderSide(color: AppColors.accentClr),
//                                 ),
//                                 focusColor: AppColors.accentClr,
//                               ),
//                               onTap: () => _showTimePicker(true, true),
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Please select the closing time (AM)';
//                                 }
//                                 return null;
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: TextFormField(
//                               readOnly: true,
//                               controller: _openingTimePMController,
//                               decoration: InputDecoration(
//                                 labelText: 'Opening Time (PM)',
//                                 labelStyle: TextStyle(
//                                   color:
//                                       _openingTimePMController.text.isNotEmpty
//                                           ? AppColors.accentClr
//                                           : null,
//                                 ),
//                                 suffixIcon: Icon(
//                                   Icons.access_time,
//                                   color:
//                                       _openingTimePMController.text.isNotEmpty
//                                           ? AppColors.accentClr
//                                           : null,
//                                 ),
//                                 focusedBorder: const UnderlineInputBorder(
//                                   borderSide:
//                                       BorderSide(color: AppColors.accentClr),
//                                 ),
//                                 focusColor: AppColors.accentClr,
//                               ),
//                               onTap: () => _showTimePicker(false, false),
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Please select the opening time (PM)';
//                                 }
//                                 return null;
//                               },
//                             ),
//                           ),
//                           const SizedBox(width: 16),
//                           Expanded(
//                             child: TextFormField(
//                               readOnly: true,
//                               controller: _closingTimePMController,
//                               decoration: InputDecoration(
//                                 labelText: 'Closing Time (PM)',
//                                 labelStyle: TextStyle(
//                                   color:
//                                       _closingTimePMController.text.isNotEmpty
//                                           ? AppColors.accentClr
//                                           : null,
//                                 ),
//                                 suffixIcon: Icon(
//                                   Icons.access_time,
//                                   color:
//                                       _closingTimePMController.text.isNotEmpty
//                                           ? AppColors.accentClr
//                                           : null,
//                                 ),
//                                 focusedBorder: const UnderlineInputBorder(
//                                   borderSide:
//                                       BorderSide(color: AppColors.accentClr),
//                                 ),
//                                 focusColor: AppColors.accentClr,
//                               ),
//                               onTap: () => _showTimePicker(false,
//                                   true), // Updated to use the correct time picker for PM
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Please select the closing time (PM)';
//                                 }
//                                 return null;
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 10),
//                       Center(
//                         child: SizedBox(
//                           width: 100,
//                           child: ElevatedButton(
//                             onPressed: _saveForm,
//                             style: ElevatedButton.styleFrom(
//                               foregroundColor: AppColors.whiteClr,
//                               backgroundColor: AppColors.accentClr,
//                             ),
//                             child: const Text('Save'),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   String _getAbbreviatedWeekday(String weekday) {
//     return weekday.substring(0, 3);
//   }

//   void _showTimePicker(bool isAM, bool isClosingTime) {
//     final now = DateTime.now();
//     DateTime? initialTime;

//     if (isAM) {
//       initialTime = isClosingTime
//           ? _establishment.closingTimeAm
//           : _establishment.openningTimeAm;
//     } else {
//       initialTime = isClosingTime
//           ? _establishment.closingTimePm
//           : _establishment.openningTimePm;
//     }

//     String timeType;
//     if (isAM) {
//       timeType = 'AM';
//     } else {
//       timeType = 'PM';
//     }
//     String positionType;
//     if (!isClosingTime) {
//       positionType = 'opening';
//     } else {
//       positionType = 'closing';
//     }

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Select $positionType Time ($timeType)'),
//           content: TimePickerSpinner(
//             time: initialTime ?? now,
//             is24HourMode: true,
//             normalTextStyle: const TextStyle(fontSize: 24, color: Colors.black),
//             highlightedTextStyle:
//                 const TextStyle(fontSize: 24, color: AppColors.accentClr),
//             spacing: 40,
//             itemHeight: 80,
//             isForce2Digits: true,
//             minutesInterval: 15,
//             onTimeChange: (time) {
//               final pickedTime = DateTime(
//                 now.year,
//                 now.month,
//                 now.day,
//                 time.hour,
//                 time.minute,
//               );
//               final formattedTime = DateFormat.jm().format(pickedTime);
//               setState(() {
//                 if (isAM) {
//                   if (isClosingTime) {
//                     _establishment.closingTimeAm = pickedTime;
//                     _closingTimeAMController.text = formattedTime;
//                   } else {
//                     _establishment.openningTimeAm = pickedTime;
//                     _openingTimeAMController.text = formattedTime;
//                   }
//                 } else {
//                   if (isClosingTime) {
//                     _establishment.closingTimePm = pickedTime;
//                     _closingTimePMController.text = formattedTime;
//                   } else {
//                     _establishment.openningTimePm = pickedTime;
//                     _openingTimePMController.text = formattedTime;
//                   }
//                 }
//               });
//             },
//           ),
//           actions: [
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               style: ElevatedButton.styleFrom(
//                 foregroundColor: AppColors.whiteClr,
//                 backgroundColor: AppColors.accentClr,
//               ),
//               child: const Text('Save'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

