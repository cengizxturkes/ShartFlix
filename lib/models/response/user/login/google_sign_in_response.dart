// To parse this JSON data, do
//
//     final googleSignInResponse = googleSignInResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'google_sign_in_response.g.dart';

GoogleSignInResponse googleSignInResponseFromJson(String str) =>
    GoogleSignInResponse.fromJson(json.decode(str));

String googleSignInResponseToJson(GoogleSignInResponse data) => json.encode(data.toJson());

@JsonSerializable()
class GoogleSignInResponse {
  @JsonKey(name: "response")
  GoogleResponse response;
  @JsonKey(name: "data")
  GoogleData data;

  GoogleSignInResponse({required this.response, required this.data});

  GoogleSignInResponse copyWith({GoogleResponse? response, GoogleData? data}) => GoogleSignInResponse(
    response: response ?? this.response,
    data: data ?? this.data,
  );

  factory GoogleSignInResponse.fromJson(Map<String, dynamic> json) =>
      _$GoogleSignInResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleSignInResponseToJson(this);
}

@JsonSerializable()
class GoogleData {
  @JsonKey(name: "_id")
  String id;
  @JsonKey(name: "id")
  String dataId;
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "email")
  String email;
  @JsonKey(name: "photoUrl")
  String photoUrl;
  @JsonKey(name: "accessToken")
  String accessToken;
  @JsonKey(name: "refreshToken")
  String refreshToken;

  GoogleData({
    required this.id,
    required this.dataId,
    required this.name,
    required this.email,
    required this.photoUrl,
    required this.accessToken,
    required this.refreshToken,
  });

  GoogleData copyWith({
    String? id,
    String? dataId,
    String? name,
    String? email,
    String? photoUrl,
    String? accessToken,
    String? refreshToken,
  }) => GoogleData(
    id: id ?? this.id,
    dataId: dataId ?? this.dataId,
    name: name ?? this.name,
    email: email ?? this.email,
    photoUrl: photoUrl ?? this.photoUrl,
    accessToken: accessToken ?? this.accessToken,
    refreshToken: refreshToken ?? this.refreshToken,
  );

  factory GoogleData.fromJson(Map<String, dynamic> json) => _$GoogleDataFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleDataToJson(this);
}

@JsonSerializable()
class GoogleResponse {
  @JsonKey(name: "code")
  int code;
  @JsonKey(name: "message")
  String message;

  GoogleResponse({required this.code, required this.message});

  GoogleResponse copyWith({int? code, String? message}) =>
      GoogleResponse(code: code ?? this.code, message: message ?? this.message);

  factory GoogleResponse.fromJson(Map<String, dynamic> json) =>
      _$GoogleResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleResponseToJson(this);
}