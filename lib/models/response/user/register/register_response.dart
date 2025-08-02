// To parse this JSON data, do
//
//     final registerResponse = registerResponseFromJson(jsonString);

// ignore: unused_import
import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'register_response.g.dart';

RegisterResponse registerResponseFromJson(String str) =>
    RegisterResponse.fromJson(json.decode(str));

String registerResponseToJson(RegisterResponse data) =>
    json.encode(data.toJson());

@JsonSerializable()
class RegisterResponse {
  @JsonKey(name: "token")
  String token;
  @JsonKey(name: "user")
  User user;

  RegisterResponse({required this.token, required this.user});

  RegisterResponse copyWith({String? token, User? user}) =>
      RegisterResponse(token: token ?? this.token, user: user ?? this.user);

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);
}

@JsonSerializable()
class User {
  @JsonKey(name: "id")
  String id;
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "email")
  String email;

  User({required this.id, required this.name, required this.email});

  User copyWith({String? id, String? name, String? email}) => User(
    id: id ?? this.id,
    name: name ?? this.name,
    email: email ?? this.email,
  );

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
