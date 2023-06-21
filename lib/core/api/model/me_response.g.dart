// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'me_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeResponse _$MeResponseFromJson(Map<String, dynamic> json) => MeResponse(
      id: json['id'] as String,
      email: json['email'] as String,
      nickname: json['nickname'] as String,
      taggedNickname: json['taggedNickname'] as String,
      createdAtTs: json['createdAtTs'] as int,
      profileImgUrl: json['profileImgUrl'] as String,
    );

Map<String, dynamic> _$MeResponseToJson(MeResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'nickname': instance.nickname,
      'taggedNickname': instance.taggedNickname,
      'createdAtTs': instance.createdAtTs,
      'profileImgUrl': instance.profileImgUrl,
    };
