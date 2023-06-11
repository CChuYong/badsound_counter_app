import 'package:json_annotation/json_annotation.dart';

part 'user_nickname_request.g.dart';

@JsonSerializable()
class UserNicknameRequest {
  @JsonKey(name: 'newNickname')
  final String newNickname;

  UserNicknameRequest(this.newNickname);

  factory UserNicknameRequest.fromJson(Map<String, dynamic> json) =>
      _$UserNicknameRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UserNicknameRequestToJson(this);
}
