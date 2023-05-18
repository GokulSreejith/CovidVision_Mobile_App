import 'package:covid_detective/src/core/colors.dart';
import 'package:covid_detective/src/core/constant.dart';
import 'package:covid_detective/utils/router_helper.dart';
import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class CovidDetectiveApp extends StatelessWidget {
  const CovidDetectiveApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constant.appName,
      navigatorKey: navigatorKey,
      routes: Routes.routes,
      theme: ThemeData(
        primarySwatch: KColors.primaryColor,
      ),
      initialRoute: Routes.splash,
      debugShowCheckedModeBanner: false,
    );
  }
}
