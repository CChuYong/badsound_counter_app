// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatResponse _$ChatResponseFromJson(Map<String, dynamic> json) => ChatResponse(
      json['messageId'] as String,
      json['roomId'] as String,
      json['content'] as String,
      json['violentId'] as String,
      json['violentPrice'] as int,
      json['speakerId'] as String,
      json['catcherId'] as String,
      json['createdAtTs'] as int,
    );

Map<String, dynamic> _$ChatResponseToJson(ChatResponse instance) =>
    <String, dynamic>{
      'messageId': instance.messageId,
      'roomId': instance.roomId,
      'content': instance.content,
      'violentId': instance.violentId,
      'violentPrice': instance.violentPrice,
      'speakerId': instance.speakerId,
      'catcherId': instance.catcherId,
      'createdAtTs': instance.createdAtTs,
    };
