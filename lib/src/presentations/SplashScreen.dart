import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:covid_detective/src/core/colors.dart';
import 'package:covid_detective/src/core/constant.dart';
import 'package:covid_detective/src/core/images.dart';
import 'package:covid_detective/src/presentations/HomeScreen.dart';
import 'package:covid_detective/utils/router_helper.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: Image.asset(
                Images.logo,
                width: 250,
                height: 250,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              Constant.appName,
              style: const TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.w800,
                color: KColors.primaryColor,
              ),
            )
          ],
        ),
      ),
      splashIconSize: 400,
      duration: 2000,
      nextScreen: const HomeScreen(),
      nextRoute: Routes.home,
      backgroundColor: KColors.splashColor,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.fade,
    );
  }
}
