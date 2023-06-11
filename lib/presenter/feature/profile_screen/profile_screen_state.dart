import 'package:json_annotation/json_annotation.dart';

part 'profile_screen_state.g.dart';

@JsonSerializable()
class ProfileScreenState {
  @JsonKey(name: 'nickname')
  String nickname;
  @JsonKey(name: 'since')
  String since;

  ProfileScreenState(this.nickname, this.since);

  factory ProfileScreenState.fromJson(Map<String, dynamic> json) =>
      _$ProfileScreenStateFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileScreenStateToJson(this);
}
