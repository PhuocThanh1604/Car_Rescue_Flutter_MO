class Service {
  String id;
  String createdBy;
  String name;
  String description;
  int price;
  String type;
  String createdAt;
  String updatedAt;
  String status;

  Service({
    required this.id,
    required this.createdBy,
    required this.name,
    required this.description,
    required this.price,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'] ?? "",
      createdBy: json['createdBy'] ?? "",
      name: json['name'] ?? "",
      description: json['description'] ?? "",
      price: json['price'] ?? 0,
      type: json['type'] ?? "",
      createdAt: json['createdAt'] ?? "",
      updatedAt: json['updatedAt'] ?? "",
      status: json['status'] ?? "",
    );
  }
}
