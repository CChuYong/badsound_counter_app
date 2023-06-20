import 'package:json_annotation/json_annotation.dart';

part 'room_create_request.g.dart';

@JsonSerializable()
class RoomCreateRequest {
  @JsonKey(name: 'roomName')
  final String roomName;
  @JsonKey(name: 'roomImageUrl')
  final String roomImageUrl;

  RoomCreateRequest(this.roomName, this.roomImageUrl);

  factory RoomCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$RoomCreateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RoomCreateRequestToJson(this);
}
