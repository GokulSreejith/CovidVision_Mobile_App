// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'covid_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CovidResponse _$CovidResponseFromJson(Map<String, dynamic> json) =>
    CovidResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      result: CovidModel.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CovidResponseToJson(CovidResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'result': instance.result,
    };
