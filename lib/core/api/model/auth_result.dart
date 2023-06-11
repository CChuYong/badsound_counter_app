import 'package:json_annotation/json_annotation.dart';

part 'auth_result.g.dart';

@JsonSerializable()
class AuthResult {
  @JsonKey(name: 'accessToken')
  String accessToken;

  @JsonKey(name: 'refreshToken')
  String refreshToken;

  AuthResult({
    required this.accessToken,
    required this.refreshToken,
  });

  factory AuthResult.fromJson(Map<String, dynamic> json) =>
      _$AuthResultFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResultToJson(this);
}
