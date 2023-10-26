class Order {
  String id;
  String customerId;
  String technicianId;
  String managerId;
  String vehicleId;
  String paymentId;
  String customerNote;
  String departure;
  String destination;
  String rescueType;
  String staffNote;
  String cancellationReason;
  String startTime;
  String endTime;
  String createdAt;
  String status;
  int area;

  Order({
    required this.id,
    required this.customerId,
    required this.technicianId,
    required this.managerId,
    required this.vehicleId,
    required this.paymentId,
    required this.customerNote,
    required this.departure,
    required this.destination,
    required this.rescueType,
    required this.staffNote,
    required this.cancellationReason,
    required this.startTime,
    required this.endTime,
    required this.createdAt,
    required this.status,
    required this.area,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      customerId: json['customerId'],
      technicianId: json['technicianId'],
      managerId: json['managerId'],
      vehicleId: json['vehicleId'],
      paymentId: json['paymentId'],
      customerNote: json['customerNote'],
      departure: json['departure'],
      destination: json['destination'],
      rescueType: json['rescueType'],
      staffNote: json['staffNote'],
      cancellationReason: json['cancellationReason'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      createdAt: json['createdAt'],
      status: json['status'],
      area: json['area'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customerId': customerId,
      'technicianId': technicianId,
      'managerId': managerId,
      'vehicleId': vehicleId,
      'paymentId': paymentId,
      'customerNote': customerNote,
      'departure': departure,
      'destination': destination,
      'rescueType': rescueType,
      'staffNote': staffNote,
      'cancellationReason': cancellationReason,
      'startTime': startTime,
      'endTime': endTime,
      'createdAt': createdAt,
      'status': status,
      'area': area,
    };
  }
}
