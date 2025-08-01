// To parse this JSON data, do
//
//     final uploadPhotoResponse = uploadPhotoResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'upload_photo_response.g.dart';

UploadPhotoResponse uploadPhotoResponseFromJson(String str) =>
    UploadPhotoResponse.fromJson(json.decode(str));

String uploadPhotoResponseToJson(UploadPhotoResponse data) =>
    json.encode(data.toJson());

@JsonSerializable()
class UploadPhotoResponse {
  @JsonKey(name: "response")
  Response response;
  @JsonKey(name: "data")
  Data data;

  UploadPhotoResponse({required this.response, required this.data});

  UploadPhotoResponse copyWith({Response? response, Data? data}) =>
      UploadPhotoResponse(
        response: response ?? this.response,
        data: data ?? this.data,
      );

  factory UploadPhotoResponse.fromJson(Map<String, dynamic> json) =>
      _$UploadPhotoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UploadPhotoResponseToJson(this);
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

  Data({
    required this.id,
    required this.dataId,
    required this.name,
    required this.email,
    required this.photoUrl,
  });

  Data copyWith({
    String? id,
    String? dataId,
    String? name,
    String? email,
    String? photoUrl,
  }) => Data(
    id: id ?? this.id,
    dataId: dataId ?? this.dataId,
    name: name ?? this.name,
    email: email ?? this.email,
    photoUrl: photoUrl ?? this.photoUrl,
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
