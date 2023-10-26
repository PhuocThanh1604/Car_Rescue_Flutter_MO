class LocationInfo {
  final String refId;
  final int distance;
  final String address;
  final String name;
  final String display;
  final double latitude;
  final double longitude;

  LocationInfo({
    required this.refId,
    required this.distance,
    required this.address,
    required this.name,
    required this.display,
    required this.latitude,
    required this.longitude,
  });

  factory LocationInfo.fromJson(Map<String, dynamic> json) {
    return LocationInfo(
      refId: json['ref_id'] ?? "",
      distance: json['distance'] ?? 0,
      address: json['address'] ?? "",
      name: json['name'] ?? "",
      display: json['display'] ?? "",
      latitude: json['latitude'] ?? 0,
      longitude: json['longitude'] ?? 0,
    );
  }
}
