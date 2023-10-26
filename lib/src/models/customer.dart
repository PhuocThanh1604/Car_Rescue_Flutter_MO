
class Customer {

  final String id;
  final String accountId;
  final String fullname;
  final String sex;
  final String phone;
  final String avatar;
  final String address;
  final String status;
  final String createAt;
  final String updateAt;
  final String birthdate;


  Customer({

    required this.id,
    required this.accountId,
    required this.fullname,
    required this.sex,
    required this.phone,
    required this.avatar,
    required this.address,
    required this.status,
    required this.createAt,
    required this.updateAt,
    required this.birthdate,
  });


  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'] ?? "",
      accountId: json['accountId'] ?? "",
      fullname: json['fullname'] ?? "",
      sex: json['sex']?? "",
      phone: json['phone']?? "",
      avatar: json['avatar'] ?? "",
      address: json['address']?? "",
      status: json['status'] ?? "",
      createAt: json['createAt'] ?? "",
      updateAt: json['updateAt']?? "",
      birthdate: json['birthdate']?? "",
    );
  }

  Map<String, dynamic> toJson() => {
  'id': id,
  'accountId': accountId,
  'fullname': fullname,
  'sex': sex,
  'phone': phone,
  'avatar': avatar,
  'address': address,
  'status': status,
  'createAt': createAt,
  'updateAt': updateAt,
  'birthdate': birthdate,
};
}
