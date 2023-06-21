// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'violent_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ViolentResponse _$ViolentResponseFromJson(Map<String, dynamic> json) =>
    ViolentResponse(
      json['violentId'] as String,
      json['name'] as String,
      json['description'] as String,
      json['violentPrice'] as int,
    );

Map<String, dynamic> _$ViolentResponseToJson(ViolentResponse instance) =>
    <String, dynamic>{
      'violentId': instance.violentId,
      'name': instance.name,
      'description': instance.description,
      'violentPrice': instance.violentPrice,
    };
