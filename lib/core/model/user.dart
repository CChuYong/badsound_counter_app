import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: 'userId')
  final String userId;
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'nickname')
  final String nickname;
  @JsonKey(name: 'createdAtTs')
  final int createdAtTs;
  @JsonKey(name: 'profileImgUrl')
  final String profileImgUrl;

  User(
      {required this.userId,
      required this.email,
      required this.nickname,
      required this.createdAtTs,
      required this.profileImgUrl});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
