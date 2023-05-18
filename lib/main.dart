import 'package:covid_detective/src/covid_detective_app.dart';
import 'package:covid_detective/src/domain/core/di/injectable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setPreferredOrientations();
  await configureInjection();
  // await Prefs.init();
  runApp(const CovidDetectiveApp());
}

Future<void> setPreferredOrientations() {
  return SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}
