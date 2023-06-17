import 'package:json_annotation/json_annotation.dart';

part 'device_request.g.dart';

@JsonSerializable()
class DeviceRequest {
  @JsonKey(name: 'fcmToken')
  final String fcmToken;
  @JsonKey(name: 'deviceInfo')
  final String deviceInfo;
  DeviceRequest(this.fcmToken, this.deviceInfo);

  factory DeviceRequest.fromJson(Map<String, dynamic> json) =>
      _$DeviceRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceRequestToJson(this);
}
