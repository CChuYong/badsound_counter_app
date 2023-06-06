import 'package:json_annotation/json_annotation.dart';

part 'me_response.g.dart';

@JsonSerializable()
class MeResponse {
  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'email')
  String email;

  MeResponse({
    required this.id,
    required this.email,
  });

  factory MeResponse.fromJson(Map<String, dynamic> json) => _$MeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MeResponseToJson(this);
}
