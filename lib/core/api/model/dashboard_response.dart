import 'package:json_annotation/json_annotation.dart';

part 'dashboard_response.g.dart';

@JsonSerializable()
class DashboardResponse {
  @JsonKey(name: 'weeklyPrice')
  final int weeklyPrice;

  @JsonKey(name: 'currentMonth')
  final int currentMonth;

  @JsonKey(name: 'currentWeek')
  final int currentWeek;

  @JsonKey(name: 'weekStartDay')
  final int weekStartDay;

  @JsonKey(name: 'weekEndDay')
  final int weekEndDay;

  DashboardResponse(this.weeklyPrice, this.currentMonth, this.currentWeek,
      this.weekStartDay, this.weekEndDay);

  factory DashboardResponse.fromJson(Map<String, dynamic> json) =>
      _$DashboardResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardResponseToJson(this);
}
