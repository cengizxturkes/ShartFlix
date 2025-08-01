// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_photo_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadPhotoResponse _$UploadPhotoResponseFromJson(Map<String, dynamic> json) =>
    UploadPhotoResponse(
      response: Response.fromJson(json['response'] as Map<String, dynamic>),
      data: Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UploadPhotoResponseToJson(
        UploadPhotoResponse instance) =>
    <String, dynamic>{
      'response': instance.response,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      id: json['_id'] as String,
      dataId: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      photoUrl: json['photoUrl'] as String,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      '_id': instance.id,
      'id': instance.dataId,
      'name': instance.name,
      'email': instance.email,
      'photoUrl': instance.photoUrl,
    };

Response _$ResponseFromJson(Map<String, dynamic> json) => Response(
      code: (json['code'] as num).toInt(),
      message: json['message'] as String,
    );

Map<String, dynamic> _$ResponseToJson(Response instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
    };
