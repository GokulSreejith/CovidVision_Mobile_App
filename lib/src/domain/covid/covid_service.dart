import 'dart:io';

import 'package:covid_detective/src/domain/core/failures/main_failure.dart';
import 'package:covid_detective/src/domain/covid/models/covid_resp.dart';
import 'package:dartz/dartz.dart';

abstract class CovidServices {
  Future<Either<MainFailure, CovidResponse>> checkCovid({
    required File image,
  });
}
