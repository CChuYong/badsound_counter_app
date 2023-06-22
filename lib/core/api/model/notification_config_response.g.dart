// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_config_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationConfigResponse _$NotificationConfigResponseFromJson(
        Map<String, dynamic> json) =>
    NotificationConfigResponse(
      json['userId'] as String,
      json['socialAlert'] as bool,
      json['badSoundAlert'] as bool,
      json['nonBadSoundAlert'] as bool,
      json['noticeAlert'] as bool,
    );

Map<String, dynamic> _$NotificationConfigResponseToJson(
        NotificationConfigResponse instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'socialAlert': instance.socialAlert,
      'badSoundAlert': instance.badSoundAlert,
      'nonBadSoundAlert': instance.nonBadSoundAlert,
      'noticeAlert': instance.noticeAlert,
    };
