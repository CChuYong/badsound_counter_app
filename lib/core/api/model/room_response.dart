import 'package:json_annotation/json_annotation.dart';

part 'room_response.g.dart';

@JsonSerializable()
class RoomResponse {
  @JsonKey(name: 'roomId')
  final String roomId;
  @JsonKey(name: 'roomName')
  final String roomName;
  @JsonKey(name: 'ownerId')
  final String ownerId;
  @JsonKey(name: 'createdAtTs')
  final int createdAtTs;

  RoomResponse(this.roomId, this.roomName, this.ownerId, this.createdAtTs);

  factory RoomResponse.fromJson(Map<String, dynamic> json) =>
      _$RoomResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RoomResponseToJson(this);
}
