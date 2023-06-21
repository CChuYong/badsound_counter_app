import 'package:json_annotation/json_annotation.dart';

part 'upload_request.g.dart';

@JsonSerializable()
class UploadRequest {
  @JsonKey(name: 'imageUrl')
  final String imageUrl;

  UploadRequest(this.imageUrl);

  factory UploadRequest.fromJson(Map<String, dynamic> json) =>
      _$UploadRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UploadRequestToJson(this);
}
