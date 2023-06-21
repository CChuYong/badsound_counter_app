import 'package:json_annotation/json_annotation.dart';

part 'violent_response.g.dart';

@JsonSerializable()
class ViolentResponse {
  @JsonKey(name: 'violentId')
  final String violentId;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'description')
  final String description;
  @JsonKey(name: 'violentPrice')
  final int violentPrice;

  ViolentResponse(
      this.violentId, this.name, this.description, this.violentPrice);

  factory ViolentResponse.fromJson(Map<String, dynamic> json) =>
      _$ViolentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ViolentResponseToJson(this);
}
