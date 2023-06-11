import 'package:json_annotation/json_annotation.dart';

part 'auth_token.g.dart';

@JsonSerializable()
class AuthToken {
  @JsonKey(name: 'accessToken')
  final String accessToken;
  @JsonKey(name: 'refreshToken')
  final String refreshToken;

  AuthToken(this.accessToken, this.refreshToken);

  factory AuthToken.fromJson(Map<String, dynamic> json) =>
      _$AuthTokenFromJson(json);

  Map<String, dynamic> toJson() => _$AuthTokenToJson(this);
}
