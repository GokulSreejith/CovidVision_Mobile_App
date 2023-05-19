import 'package:covid_detective/src/domain/covid/models/covid_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'covid_resp.g.dart';

@JsonSerializable()
class CovidResponse {
  @JsonKey(name: 'success')
  bool success;
  @JsonKey(name: 'message')
  String message;
  @JsonKey(name: 'data')
  CovidModel result;

  CovidResponse({
    required this.success,
    required this.message,
    required this.result,
  });

  factory CovidResponse.fromJson(Map<String, dynamic> json) =>
      _$CovidResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CovidResponseToJson(this);
}
