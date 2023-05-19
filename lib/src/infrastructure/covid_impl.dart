import 'dart:io';
import 'dart:math';

import 'package:covid_detective/src/domain/core/api_endpoints.dart';
import 'package:covid_detective/src/domain/core/dio_helper.dart';
import 'package:covid_detective/src/domain/core/failures/main_failure.dart';
import 'package:covid_detective/src/domain/covid/covid_service.dart';
import 'package:covid_detective/src/domain/covid/models/covid_resp.dart';
import 'package:covid_detective/src/domain/models/base_api_resp.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CovidServices)
class CovidImpl implements CovidServices {
  @override
  Future<Either<MainFailure, CovidResponse>> checkCovid({
    required File image,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          image.path,
        ),
      });

      //  Fetch Data from the server
      final Response response =
          await dioClient.post(ApiEndpoints.covid, data: formData);

      // If Response is success
      if (response.statusCode == 200) {
        // Covert json to dart
        final result = CovidResponse.fromJson(response.data);
        return Right(result);
      } else {
        final error = BaseApiResponse.fromJson(response.data);
        return Left(
          MainFailure.serverFailure(message: error.message),
        );
      }
    } on DioError catch (e) {
      return Left(
        MainFailure.clientFailure(message: e.error.toString()),
      );
    } catch (e) {
      return const Left(
        MainFailure.clientFailure(message: 'Client Error occur'),
      );
    }
  }
}
