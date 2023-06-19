import 'package:json_annotation/json_annotation.dart';

part 'room_detail_response.g.dart';

@JsonSerializable()
class RoomDetailResponse {
  @JsonKey(name: 'roomId')
  final String roomId;
  @JsonKey(name: 'roomName')
  final String roomName;
  @JsonKey(name: 'ownerId')
  final String ownerId;
  @JsonKey(name: 'createdAtTs')
  final int createdAtTs;
  @JsonKey(name: 'lastMessageAtTs')
  final int lastMessageAtTs;
  @JsonKey(name: 'unreadMessageCount')
  final int unreadMessageCount;
  @JsonKey(name: 'roomImageUrl')
  final String roomImageUrl;

  RoomDetailResponse(this.roomId, this.roomName, this.ownerId, this.createdAtTs,
      this.lastMessageAtTs, this.unreadMessageCount, this.roomImageUrl);

  factory RoomDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$RoomDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RoomDetailResponseToJson(this);
}
