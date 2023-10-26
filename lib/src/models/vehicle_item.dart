class Vehicle {
  final String id;
  final String vinNumber;
  final String licensePlate;
  final String type;
  final String color;
  final int manufacturingYear;
  final String manufacturer;
  final String status;
  final String? carRegistrationFont;
  final String? carRegistrationBack;
  // Add the image field

  Vehicle(
      {required this.id,
      required this.vinNumber,
      required this.licensePlate,
      required this.type,
      required this.color,
      required this.manufacturingYear,
      required this.manufacturer,
      required this.status,
      required this.carRegistrationFont,
      required this.carRegistrationBack});

  // Include the image in the constructor

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'],
      vinNumber: json['vinNumber'],
      licensePlate: json['licensePlate'],
      type: json['type'],
      color: json['color'],
      manufacturingYear: json['manufacturingYear'],
      manufacturer: json['manufacturer'],
      status: json['status'],
      carRegistrationFont: json['carRegistrationFont'] as String?,
      carRegistrationBack: json['carRegistrationBack'] as String?,
      // Parse other fields from JSON
    );
  }
}
