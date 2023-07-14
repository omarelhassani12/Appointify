class Establishment {
  final String id;
  final String name;
  final String address;
  final String contactInformation;
  final EstablishmentType type;

  Establishment({
    required this.id,
    required this.name,
    required this.address,
    required this.contactInformation,
    required this.type,
  });
}

enum EstablishmentType {
  salon,
  cabinet,
  restaurant,
}
