// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterBody _$RegisterBodyFromJson(Map<String, dynamic> json) => RegisterBody(
      email: json['email'] as String,
      name: json['name'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$RegisterBodyToJson(RegisterBody instance) =>
    <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'password': instance.password,
    };
