// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_req_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadRequestResponse _$UploadRequestResponseFromJson(
        Map<String, dynamic> json) =>
    UploadRequestResponse(
      json['uploadUrl'] as String,
      json['downloadUrl'] as String,
    );

Map<String, dynamic> _$UploadRequestResponseToJson(
        UploadRequestResponse instance) =>
    <String, dynamic>{
      'uploadUrl': instance.uploadUrl,
      'downloadUrl': instance.downloadUrl,
    };
