import 'package:json_annotation/json_annotation.dart';

part 'break_friend_request.g.dart';

@JsonSerializable()
class BreakFriendRequest {
  @JsonKey(name: 'userId')
  final String userId;

  BreakFriendRequest(this.userId);

  factory BreakFriendRequest.fromJson(Map<String, dynamic> json) =>
      _$BreakFriendRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BreakFriendRequestToJson(this);
}
