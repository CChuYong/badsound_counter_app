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

  @JsonKey(name: 'createdAtTs')
  int createdAtTs;

  MeResponse({
    required this.id,
    required this.email,
    required this.nickname,
    required this.createdAtTs,
  });

  factory MeResponse.fromJson(Map<String, dynamic> json) =>
      _$MeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MeResponseToJson(this);
}
