import 'package:json_annotation/json_annotation.dart';

part 'main_screen_stat_box_state.g.dart';

@JsonSerializable()
class MainPageStatBoxState {
  @JsonKey(name: 'money')
  int money;

  @JsonKey(name: 'since')
  String title;

  @JsonKey(name: 'subTitle')
  String subTitle;

  MainPageStatBoxState(this.money, this.title, this.subTitle);

  factory MainPageStatBoxState.fromJson(Map<String, dynamic> json) =>
      _$MainPageStatBoxStateFromJson(json);

  Map<String, dynamic> toJson() => _$MainPageStatBoxStateToJson(this);
}
