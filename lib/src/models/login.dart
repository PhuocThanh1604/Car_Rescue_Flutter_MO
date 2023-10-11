import 'package:CarRescue/src/models/customer.dart';

class LoginResponse {
  final String role;
  final String accessToken;
  final String refreshToken;
  final String accountId;
  final String email;
  final Customer customer;
  final String message;
  final int status;

  LoginResponse({
    required this.role,
    required this.accessToken,
    required this.refreshToken,
    required this.accountId,
    required this.email,
    required this.customer,
    required this.message,
    required this.status,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      role: json['data']['role'] ?? '',
      accessToken: json['data']['accessToken'] ?? '',
      refreshToken: json['data']['refreshToken'] ?? '',
      accountId: json['data']['accountId'] ?? '',
      email: json['data']['email'] ?? '',
      customer: Customer.fromJson(json['data']['customer']),
      message: json['message'] ?? '',
      status: json['status'] ?? 0,
    );
  }


}

