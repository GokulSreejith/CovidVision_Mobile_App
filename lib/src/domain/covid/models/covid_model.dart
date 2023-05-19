import 'package:json_annotation/json_annotation.dart';

part 'covid_model.g.dart';

@JsonSerializable()
class CovidModel {
  @JsonKey(name: "index")
  int index;
  @JsonKey(name: "label")
  String label;

  CovidModel({
    required this.index,
    required this.label,
  });

  factory CovidModel.fromJson(Map<String, dynamic> json) =>
      _$CovidModelFromJson(json);

  Map<String, dynamic> toJson() => _$CovidModelToJson(this);
}
