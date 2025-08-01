// To parse this JSON data, do
//
//     final profileResponse = profileResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'profile_response.g.dart';

ProfileResponse profileResponseFromJson(String str) =>
    ProfileResponse.fromJson(json.decode(str));

String profileResponseToJson(ProfileResponse data) =>
    json.encode(data.toJson());

@JsonSerializable()
class ProfileResponse {
  @JsonKey(name: "response")
  Response response;
  @JsonKey(name: "data")
  Data data;

  ProfileResponse({required this.response, required this.data});

  ProfileResponse copyWith({Response? response, Data? data}) => ProfileResponse(
    response: response ?? this.response,
    data: data ?? this.data,
  );

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileResponseToJson(this);
}

@JsonSerializable()
class Data {
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
  @JsonKey(name: "token")
  String token;

  Data({
    required this.id,
    required this.dataId,
    required this.name,
    required this.email,
    required this.photoUrl,
    required this.token,
  });

  Data copyWith({
    String? id,
    String? dataId,
    String? name,
    String? email,
    String? photoUrl,
    String? token,
  }) => Data(
    id: id ?? this.id,
    dataId: dataId ?? this.dataId,
    name: name ?? this.name,
    email: email ?? this.email,
    photoUrl: photoUrl ?? this.photoUrl,
    token: token ?? this.token,
  );

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Response {
  @JsonKey(name: "code")
  int code;
  @JsonKey(name: "message")
  String message;

  Response({required this.code, required this.message});

  Response copyWith({int? code, String? message}) =>
      Response(code: code ?? this.code, message: message ?? this.message);

  factory Response.fromJson(Map<String, dynamic> json) =>
      _$ResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseToJson(this);
}
