import 'package:appointify/models/latlangposition.dart';

class Establishment {
  String id;
  String name;
  String address;
  String country;
  LatLngPosition? position;
  String email;
  int phoneNumber;
  List<String> categories;
  List<String> workingDays;
  DateTime? openningTimeAm;
  DateTime? openningTimePm;
  DateTime? closingTimeAm;
  DateTime? closingTimePm;

  Establishment({
    required this.id,
    required this.name,
    required this.address,
    required this.country,
    required this.position,
    required this.email,
    required this.phoneNumber,
    required this.categories,
    required this.workingDays,
    this.openningTimeAm,
    this.openningTimePm,
    this.closingTimeAm,
    this.closingTimePm,
  });
  @override
  String toString() {
    return 'Establishment('
        'name: $name, '
        'country: $country, '
        'position: $position, '
        'categories: $categories, '
        'workingDays: $workingDays, '
        'openningTimeAm: $openningTimeAm, '
        'closingTimeAm: $closingTimeAm, '
        'openningTimePm: $openningTimePm, '
        'closingTimePm: $closingTimePm'
        ')';
  }
}