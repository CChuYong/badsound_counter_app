// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_notification_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateNotificationRequest _$UpdateNotificationRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateNotificationRequest(
      json['type'] as String,
      json['value'] as bool,
    );

Map<String, dynamic> _$UpdateNotificationRequestToJson(
        UpdateNotificationRequest instance) =>
    <String, dynamic>{
      'type': instance.type,
      'value': instance.value,
    };
