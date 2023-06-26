import 'package:json_annotation/json_annotation.dart';

part 'last_message_id_request.g.dart';

@JsonSerializable()
class UpdateLastMessageIdRequest {
  @JsonKey(name: 'messageId')
  final String messageId;

  UpdateLastMessageIdRequest(this.messageId);
  factory UpdateLastMessageIdRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateLastMessageIdRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateLastMessageIdRequestToJson(this);
}
