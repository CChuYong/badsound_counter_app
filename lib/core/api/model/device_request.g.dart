// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceRequest _$DeviceRequestFromJson(Map<String, dynamic> json) =>
    DeviceRequest(
      json['fcmToken'] as String,
      json['deviceInfo'] as String,
    );

Map<String, dynamic> _$DeviceRequestToJson(DeviceRequest instance) =>
    <String, dynamic>{
      'fcmToken': instance.fcmToken,
      'deviceInfo': instance.deviceInfo,
    };
