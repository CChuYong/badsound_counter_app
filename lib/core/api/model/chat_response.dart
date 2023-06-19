import 'package:json_annotation/json_annotation.dart';

part 'chat_response.g.dart';

@JsonSerializable()
class ChatResponse {
  @JsonKey(name: 'messageId')
  final String messageId;
  @JsonKey(name: 'roomId')
  final String roomId;

  @JsonKey(name: 'content')
  final String content;
  @JsonKey(name: 'violentId')
  final String violentId;
  @JsonKey(name: 'violentPrice')
  final int violentPrice;

  @JsonKey(name: 'speakerId')
  final String speakerId;
  @JsonKey(name: 'catcherId')
  final String catcherId;
  @JsonKey(name: 'createdAtTs')
  final int createdAtTs;

  ChatResponse(this.messageId, this.roomId, this.content, this.violentId,
      this.violentPrice, this.speakerId, this.catcherId, this.createdAtTs);

  factory ChatResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChatResponseToJson(this);
}
