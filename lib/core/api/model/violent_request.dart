import 'package:json_annotation/json_annotation.dart';

part 'violent_request.g.dart';

@JsonSerializable()
class ViolentRequest {
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'description')
  final String description;
  @JsonKey(name: 'price')
  final int violentPrice;

  ViolentRequest({required this.name, required this.description, required this.violentPrice});


  factory ViolentRequest.fromJson(Map<String, dynamic> json) =>
      _$ViolentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ViolentRequestToJson(this);
}