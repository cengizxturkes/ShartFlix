// To parse this JSON data, do
//
//     final loginBody = loginBodyFromJson(jsonString);

// ignore: unused_import
import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'login_body.g.dart';

LoginBody loginBodyFromJson(String str) => LoginBody.fromJson(json.decode(str));

String loginBodyToJson(LoginBody data) => json.encode(data.toJson());

@JsonSerializable()
class LoginBody {
  @JsonKey(name: "email")
  String email;
  @JsonKey(name: "password")
  String password;

  LoginBody({required this.email, required this.password});

  LoginBody copyWith({String? email, String? password}) => LoginBody(
    email: email ?? this.email,
    password: password ?? this.password,
  );

  factory LoginBody.fromJson(Map<String, dynamic> json) =>
      _$LoginBodyFromJson(json);

  Map<String, dynamic> toJson() => _$LoginBodyToJson(this);
}
