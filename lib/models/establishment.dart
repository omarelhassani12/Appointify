import 'package:flutter/material.dart';

class Establishment {
  String id;
  String name;
  String address;
  String email;
  int phoneNumber;
  List<String> categories;
  List<String> workingDays;
  TimeOfDay openTime;
  TimeOfDay closeTime;

  Establishment({
    required this.id,
    required this.name,
    required this.address,
    required this.email,
    required this.phoneNumber,
    required this.categories,
    required this.workingDays,
    required this.openTime,
    required this.closeTime,
  });
}
