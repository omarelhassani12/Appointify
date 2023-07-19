class LatLngPosition {
  late double latitude;
  late double longitude;

  LatLngPosition({required this.latitude, required this.longitude});

  @override
  String toString() {
    return 'LatLngPosition(latitude: $latitude, longitude: $longitude)';
  }
}
