import 'package:json_annotation/json_annotation.dart';

part 'update_notification_request.g.dart';

@JsonSerializable()
class UpdateNotificationRequest {
  @JsonKey(name: 'type')
  final String type;
  @JsonKey(name: 'value')
  final bool value;

  UpdateNotificationRequest(this.type, this.value);
  factory UpdateNotificationRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateNotificationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateNotificationRequestToJson(this);
}
