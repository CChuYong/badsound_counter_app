import 'package:json_annotation/json_annotation.dart';

part 'room_create_request.g.dart';

@JsonSerializable()
class RoomCreateRequest {
  @JsonKey(name: 'roomName')
  final String roomName;

  RoomCreateRequest(this.roomName);

  factory RoomCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$RoomCreateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RoomCreateRequestToJson(this);
}
