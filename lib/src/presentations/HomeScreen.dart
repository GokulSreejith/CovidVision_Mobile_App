import 'package:covid_detective/src/core/colors.dart';
import 'package:covid_detective/src/core/constant.dart';
import 'package:covid_detective/src/core/images.dart';
import 'package:covid_detective/src/domain/core/failures/main_failure.dart';
import 'package:covid_detective/src/infrastructure/covid_impl.dart';
import 'package:covid_detective/src/domain/covid/models/covid_resp.dart';
import 'package:covid_detective/utils/image_selecter.dart';
import 'package:covid_detective/utils/notification_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

ValueNotifier<SelectedImage?> imageNotifier =
    ValueNotifier<SelectedImage?>(null);
ValueNotifier<int> resultNotifier = ValueNotifier<int>(-1);

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Constant.appName),
        centerTitle: true,
      ),
      body:
          Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: ValueListenableBuilder(
                valueListenable: imageNotifier,
                builder: ((context, value, child) {
                  return Text(
                    value == null
                        ? 'Pick the image for check COVID-19'
                        : 'Click submit to view the result',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: KColors.primaryColor,
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  width: 5,
                  color: KColors.primaryColor,
                ),
              ),
              width: Constant.imageWidth,
              height: Constant.imageHeight,
              child: ValueListenableBuilder(
                valueListenable: imageNotifier,
                builder: ((context, value, child) {
                  return (value == null)
                      ? Image.asset(
                          Images.banner,
                        )
                      : Image.file(value.file);
                }),
              ),
            ),
            const SizedBox(height: 50),
            ValueListenableBuilder(
              valueListenable: imageNotifier,
              builder: ((context, value, child) {
                return value == null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                KColors.primaryColor,
                              ),
                            ),
                            onPressed: () =>
                                getImage(source: ImageSource.gallery),
                            child: const Text(
                              "Gallery",
                              style: TextStyle(color: KColors.textColor),
                            ),
                          )
                        ],
                      )
                    : const SizedBox();
              }),
            ),
            AnimatedBuilder(
              animation: Listenable.merge([imageNotifier, resultNotifier]),
              builder: (BuildContext context, _) {
                return (imageNotifier.value != null &&
                        resultNotifier.value == -1)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                KColors.primaryColor,
                              ),
                            ),
                            onPressed: () => getImage(
                                source: imageNotifier.value?.source ??
                                    ImageSource.camera),
                            child: Text(
                              imageNotifier.value != null &&
                                      imageNotifier.value!.source ==
                                          ImageSource.camera
                                  ? "Retake"
                                  : "Reselect",
                              style: const TextStyle(color: KColors.textColor),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                KColors.primaryColor,
                              ),
                            ),
                            onPressed: () async {
                              if (imageNotifier.value == null) {
                                return;
                              }

                              final covidServices = CovidImpl(); // Instantiate the CovidServices class

                              // Fetch Api
                              final covidResp = await covidServices
                                  .checkCovid(image: imageNotifier.value!.file);

                              // Fold covid and update result notifier
                              final _state = covidResp.fold(
                                (MainFailure failure) {
                                  NotificationHelper.showSnackBar(
                                      label: failure.message);
                                },
                                (CovidResponse resp) {
                                  resultNotifier.value = resp.result.index;
                                  resultNotifier.notifyListeners();
                                },
                              );
                            },
                            child: const Text(
                              "Submit",
                              style: TextStyle(color: KColors.textColor),
                            ),
                          )
                        ],
                      )
                    : const SizedBox();
              },
            ),
            const SizedBox(height: 14),
            ValueListenableBuilder(
              valueListenable: resultNotifier,
              builder: ((context, value, child) {
                return value != -1
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Result: ",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: KColors.primaryColor,
                            ),
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            value == 1 ? "POSITIVE" : "NEGATIVE",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w600,
                              color: value == 0
                                  ? const Color.fromARGB(255, 72, 108, 73)
                                  : KColors.dangerColor,
                            ),
                          ),
                        ],
                      )
                    : const SizedBox();
              }),
            ),
            const SizedBox(height: 30),
            ValueListenableBuilder(
              valueListenable: resultNotifier,
              builder: ((context, value, child) {
                return value != -1
                    ? ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            KColors.primaryColor,
                          ),
                        ),
                        onPressed: () {
                          imageNotifier.value = null;
                          resultNotifier.value = -1;
                          imageNotifier.notifyListeners();
                          resultNotifier.notifyListeners();
                        },
                        child: const Text("Next"))
                    : const SizedBox();
              }),
            ),
          ],
        ),
      ),
    );
  }
}
