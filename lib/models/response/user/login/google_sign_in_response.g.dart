// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_sign_in_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoogleSignInResponse _$GoogleSignInResponseFromJson(Map<String, dynamic> json) =>
    GoogleSignInResponse(
      response: GoogleResponse.fromJson(json['response'] as Map<String, dynamic>),
      data: GoogleData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GoogleSignInResponseToJson(GoogleSignInResponse instance) =>
    <String, dynamic>{
      'response': instance.response,
      'data': instance.data,
    };

GoogleData _$GoogleDataFromJson(Map<String, dynamic> json) => GoogleData(
      id: json['_id'] as String,
      dataId: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      photoUrl: json['photoUrl'] as String,
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
    );

Map<String, dynamic> _$GoogleDataToJson(GoogleData instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'id': instance.dataId,
      'name': instance.name,
      'email': instance.email,
      'photoUrl': instance.photoUrl,
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
    };

GoogleResponse _$GoogleResponseFromJson(Map<String, dynamic> json) =>
    GoogleResponse(
      code: (json['code'] as num).toInt(),
      message: json['message'] as String,
    );

Map<String, dynamic> _$GoogleResponseToJson(GoogleResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
    };