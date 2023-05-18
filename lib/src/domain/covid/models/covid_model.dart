import 'package:json_annotation/json_annotation.dart';

part 'covid_model.g.dart';

@JsonSerializable()
class CovidModel {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "label")
  String label;

  CovidModel({
    required this.id,
    required this.label,
  });

  factory CovidModel.fromJson(Map<String, dynamic> json) =>
      _$CovidModelFromJson(json);

  Map<String, dynamic> toJson() => _$CovidModelToJson(this);
}
