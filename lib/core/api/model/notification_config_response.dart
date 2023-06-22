import 'package:json_annotation/json_annotation.dart';

part 'notification_config_response.g.dart';

@JsonSerializable()
class NotificationConfigResponse {
  @JsonKey(name: 'userId')
  final String userId;
  @JsonKey(name: 'socialAlert')
  final bool socialAlert;
  @JsonKey(name: 'badSoundAlert')
  final bool badSoundAlert;
  @JsonKey(name: 'nonBadSoundAlert')
  final bool nonBadSoundAlert;
  @JsonKey(name: 'noticeAlert')
  final bool noticeAlert;
  NotificationConfigResponse(this.userId, this.socialAlert, this.badSoundAlert, this.nonBadSoundAlert, this.noticeAlert);


  factory NotificationConfigResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationConfigResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationConfigResponseToJson(this);
}
