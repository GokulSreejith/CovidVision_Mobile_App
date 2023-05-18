import 'package:freezed_annotation/freezed_annotation.dart';
part 'main_failure.freezed.dart';

@freezed
class MainFailure with _$MainFailure {
  const factory MainFailure.clientFailure({
    required String message,
  }) = _ClientFailure;
  const factory MainFailure.serverFailure({
    required String message,
  }) = _ServerFailure;
}
