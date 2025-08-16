// To parse this JSON data, do
//
//     final googleSignIn = googleSignInFromJson(jsonString);

// ignore: unused_import
import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'google_sign_in.g.dart';

GoogleSignIn googleSignInFromJson(String str) =>
    GoogleSignIn.fromJson(json.decode(str));

String googleSignInToJson(GoogleSignIn data) => json.encode(data.toJson());

@JsonSerializable()
class GoogleSignIn {
  @JsonKey(name: "idToken")
  String idToken;

  GoogleSignIn({
    required this.idToken,
  });

  GoogleSignIn copyWith({String? idToken}) => GoogleSignIn(
        idToken: idToken ?? this.idToken,
      );

  factory GoogleSignIn.fromJson(Map<String, dynamic> json) =>
      _$GoogleSignInFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleSignInToJson(this);
}