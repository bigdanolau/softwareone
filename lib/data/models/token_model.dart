import 'dart:convert';

TokenModel tokenModelFromJson(String str) =>
    TokenModel.fromJson(json.decode(str));

class TokenModel {
  TokenModel({
    required this.authToken,
  });

  String authToken;

  factory TokenModel.fromJson(Map<String, dynamic> json) => TokenModel(
        authToken: json['auth_token'],
      );
}
