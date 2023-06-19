import 'package:json_annotation/json_annotation.dart';

part 'chat_request.g.dart';

@JsonSerializable()
class ChatRequest {
  @JsonKey(name: 'violentId')
  final String violentId;

  @JsonKey(name: 'speakerId')
  final String speakerId;

  @JsonKey(name: 'catcherId')
  final String catcherId;

  @JsonKey(name: 'content')
  final String content;

  ChatRequest(this.violentId, this.speakerId, this.catcherId, this.content);

  factory ChatRequest.fromJson(Map<String, dynamic> json) =>
      _$ChatRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ChatRequestToJson(this);
}
