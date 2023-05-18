import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_api_resp.g.dart';

@JsonSerializable()
class BaseApiResponse {
  @JsonKey(name: 'success')
  bool success;
  @JsonKey(name: 'message')
  String message;

  BaseApiResponse({
    required this.success,
    required this.message,
  });

  factory BaseApiResponse.fromJson(Map<String, dynamic> json) =>
      _$BaseApiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BaseApiResponseToJson(this);
}
