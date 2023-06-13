// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatRequest _$ChatRequestFromJson(Map<String, dynamic> json) => ChatRequest(
      json['violentId'] as String,
      json['spekaerId'] as String,
      json['catcherId'] as String,
      json['content'] as String,
    );

Map<String, dynamic> _$ChatRequestToJson(ChatRequest instance) =>
    <String, dynamic>{
      'violentId': instance.violentId,
      'spekaerId': instance.speakerId,
      'catcherId': instance.catcherId,
      'content': instance.content,
    };
