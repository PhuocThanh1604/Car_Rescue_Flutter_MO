class OrderBookService {
  String paymentMethod;
  String customerNote;
  String departure;
  String destination;
  String rescueType;
  String customerId;
  List<String> url;
  List<String> service;
  int area;

  OrderBookService({
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

  factory OrderBookService.fromJson(Map<String, dynamic> json) {
    return OrderBookService(
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
