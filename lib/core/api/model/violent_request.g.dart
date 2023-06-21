// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'violent_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ViolentRequest _$ViolentRequestFromJson(Map<String, dynamic> json) =>
    ViolentRequest(
      name: json['name'] as String,
      description: json['description'] as String,
      violentPrice: json['price'] as int,
    );

Map<String, dynamic> _$ViolentRequestToJson(ViolentRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'price': instance.violentPrice,
    };
