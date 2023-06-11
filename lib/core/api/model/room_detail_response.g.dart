// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomDetailResponse _$RoomDetailResponseFromJson(Map<String, dynamic> json) =>
    RoomDetailResponse(
      json['roomId'] as String,
      json['roomName'] as String,
      json['ownerId'] as String,
      json['createdAtTs'] as int,
      json['lastMessageAtTs'] as int,
      json['unreadMessageCount'] as int,
    );

Map<String, dynamic> _$RoomDetailResponseToJson(RoomDetailResponse instance) =>
    <String, dynamic>{
      'roomId': instance.roomId,
      'roomName': instance.roomName,
      'ownerId': instance.ownerId,
      'createdAtTs': instance.createdAtTs,
      'lastMessageAtTs': instance.lastMessageAtTs,
      'unreadMessageCount': instance.unreadMessageCount,
    };
