import 'package:badsound_counter_app/core/model/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'me_response.g.dart';

@JsonSerializable()
class MeResponse {
  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'email')
  String email;

  @JsonKey(name: 'nickname')
  String nickname;

  @JsonKey(name: 'taggedNickname')
  String taggedNickname;

  @JsonKey(name: 'createdAtTs')
  int createdAtTs;

  @JsonKey(name: 'profileImgUrl')
  String profileImgUrl;

  MeResponse({
    required this.id,
    required this.email,
    required this.nickname,
    required this.taggedNickname,
    required this.createdAtTs,
    required this.profileImgUrl,
  });

  factory MeResponse.fromJson(Map<String, dynamic> json) =>
      _$MeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MeResponseToJson(this);

  User toModel() => User(
    userId: id,
    email: email,
    nickname: nickname,
    createdAtTs: createdAtTs,
    profileImgUrl: profileImgUrl,
    taggedNickname: taggedNickname,
  );
}
