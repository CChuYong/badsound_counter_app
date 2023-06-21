// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_create_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomCreateRequest _$RoomCreateRequestFromJson(Map<String, dynamic> json) =>
    RoomCreateRequest(
      json['roomName'] as String,
      json['roomImageUrl'] as String,
      (json['initialUserIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$RoomCreateRequestToJson(RoomCreateRequest instance) =>
    <String, dynamic>{
      'roomName': instance.roomName,
      'roomImageUrl': instance.roomImageUrl,
      'initialUserIds': instance.initialUserIds,
    };
