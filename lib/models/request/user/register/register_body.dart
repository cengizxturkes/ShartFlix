// To parse this JSON data, do
//
//     final registerBody = registerBodyFromJson(jsonString);

// ignore: unused_import
import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'register_body.g.dart';

RegisterBody registerBodyFromJson(String str) =>
    RegisterBody.fromJson(json.decode(str));

String registerBodyToJson(RegisterBody data) => json.encode(data.toJson());

@JsonSerializable()
class RegisterBody {
  @JsonKey(name: "email")
  String email;
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "password")
  String password;

  RegisterBody({
    required this.email,
    required this.name,
    required this.password,
  });

  RegisterBody copyWith({String? email, String? name, String? password}) =>
      RegisterBody(
        email: email ?? this.email,
        name: name ?? this.name,
        password: password ?? this.password,
      );

  factory RegisterBody.fromJson(Map<String, dynamic> json) =>
      _$RegisterBodyFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterBodyToJson(this);
}
