// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomResponse _$RoomResponseFromJson(Map<String, dynamic> json) => RoomResponse(
      json['roomId'] as String,
      json['roomName'] as String,
      json['ownerId'] as String,
      json['createdAtTs'] as int,
      json['roomImageUrl'] as String,
    );

Map<String, dynamic> _$RoomResponseToJson(RoomResponse instance) =>
    <String, dynamic>{
      'roomId': instance.roomId,
      'roomName': instance.roomName,
      'ownerId': instance.ownerId,
      'createdAtTs': instance.createdAtTs,
      'roomImageUrl': instance.roomImageUrl,
    };
