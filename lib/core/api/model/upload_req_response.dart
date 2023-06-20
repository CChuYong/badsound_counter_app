import 'package:json_annotation/json_annotation.dart';

part 'upload_req_response.g.dart';

@JsonSerializable()
class UploadRequestResponse {
  @JsonKey(name: 'uploadUrl')
  final String uploadUrl;

  @JsonKey(name: 'downloadUrl')
  final String downloadUrl;
  UploadRequestResponse(this.uploadUrl, this.downloadUrl);

  factory UploadRequestResponse.fromJson(Map<String, dynamic> json) =>
      _$UploadRequestResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UploadRequestResponseToJson(this);
}