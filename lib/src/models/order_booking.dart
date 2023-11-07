class OrderBookServiceTowing {
  late String paymentMethod;
  late String customerNote;
  late String departure;
  late String destination;
  late String rescueType;
  late String customerId;
  late List<String> url;
  late List<String> service;
  late double distance;
  late int area;

  OrderBookServiceTowing({
    required this.paymentMethod,
    required this.customerNote,
    required this.departure,
    required this.destination,
    required this.rescueType,
    required this.customerId,
    required this.url,
    required this.service,
    required this.distance,
    required this.area,
  });

  factory OrderBookServiceTowing.fromJson(Map<String, dynamic> json) {
    return OrderBookServiceTowing(
      paymentMethod: json['paymentMethod'] ?? "",
      customerNote: json['customerNote'] ?? "",
      departure: json['departure'] ?? "",
      destination: json['destination'] ?? "",
      rescueType: json['rescueType'] ?? "",
      customerId: json['customerId'] ?? "",
      url: (json['url'] as List<dynamic>).cast<String>(),
      service: (json['service'] as List<dynamic>).cast<String>(),
      distance: json['distance'],
      area: json['area'] ?? 0,
    );
  }
  
  Map<String, dynamic> toJson() {
  return {
    'paymentMethod': paymentMethod,
    'customerNote': customerNote,
    'departure': departure,
    'destination': destination,
    'rescueType': rescueType,
    'customerId': customerId,
    'url': url,
    'service': service,
    'distance': distance,
    'area': area,
  };
}
}

class OrderBookServiceFixing {
  late String paymentMethod;
  late String customerNote;
  late String departure;
  late String destination;
  late String rescueType;
  late String customerId;
  late List<String> url;
  late List<String> service;
  late int area;

  OrderBookServiceFixing({
    required this.paymentMethod,
    required this.customerNote,
    required this.departure,
    required this.destination,
    required this.rescueType,
    required this.customerId,
    required this.url,
    required this.service,
    required this.area,
  });

  factory OrderBookServiceFixing.fromJson(Map<String, dynamic> json) {
    return OrderBookServiceFixing(
      paymentMethod: json['paymentMethod'] ?? "",
      customerNote: json['customerNote'] ?? "",
      departure: json['departure'] ?? "",
      destination: json['destination'] ?? "",
      rescueType: json['rescueType'] ?? "",
      customerId: json['customerId'] ?? "",
      url: (json['url'] as List<dynamic>).cast<String>(),
      service: (json['service'] as List<dynamic>).cast<String>(),
      area: json['area'] ?? 0,
    );
  }
  
  Map<String, dynamic> toJson() {
  return {
    'paymentMethod': paymentMethod,
    'customerNote': customerNote,
    'departure': departure,
    'destination': destination,
    'rescueType': rescueType,
    'customerId': customerId,
    'url': url,
    'service': service,
    'area': area,
  };
}
}

