// To parse this JSON data, do
//
//     final googleSignInBody = googleSignInBodyFromJson(jsonString);

import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'google_sign_in.g.dart';

GoogleSignInBody googleSignInBodyFromJson(String str) =>
    GoogleSignInBody.fromJson(json.decode(str));

String googleSignInBodyToJson(GoogleSignInBody data) => json.encode(data.toJson());

@JsonSerializable()
class GoogleSignInBody {
  @JsonKey(name: "idToken")
  String idToken;

  GoogleSignInBody({required this.idToken});

  GoogleSignInBody copyWith({String? idToken}) => GoogleSignInBody(
    idToken: idToken ?? this.idToken,
  );

  factory GoogleSignInBody.fromJson(Map<String, dynamic> json) =>
      _$GoogleSignInBodyFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleSignInBodyToJson(this);
}