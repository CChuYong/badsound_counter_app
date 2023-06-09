// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardResponse _$DashboardResponseFromJson(Map<String, dynamic> json) =>
    DashboardResponse(
      json['weeklyPrice'] as int,
      json['currentMonth'] as int,
      json['currentWeek'] as int,
      json['weekStartDay'] as int,
      json['weekEndDay'] as int,
    );

Map<String, dynamic> _$DashboardResponseToJson(DashboardResponse instance) =>
    <String, dynamic>{
      'weeklyPrice': instance.weeklyPrice,
      'currentMonth': instance.currentMonth,
      'currentWeek': instance.currentWeek,
      'weekStartDay': instance.weekStartDay,
      'weekEndDay': instance.weekEndDay,
    };
