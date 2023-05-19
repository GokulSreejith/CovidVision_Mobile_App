import 'dart:io';

import 'package:covid_detective/src/covid_detective_app.dart';
import 'package:covid_detective/src/core/colors.dart';
import 'package:covid_detective/src/presentations/HomeScreen.dart';
import 'package:covid_detective/utils/notification_helper.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class SelectedImage {
  final ImageSource source;
  final File file;

  SelectedImage({required this.source, required this.file});
}

Future<SelectedImage?> getImage({
  required ImageSource source,
  bool nocrop = false,
  double maxWidth = 1800,
  double maxHeight = 1800,
}) async {
  XFile? pickedFile = await pickImage(
    source: source,
    maxWidth: maxWidth,
    maxHeight: maxHeight,
  );

  if (pickedFile != null && !nocrop) {
    CroppedFile? croppedFile = await cropImage(sourcePath: pickedFile.path);

    if (croppedFile != null) {
      final SelectedImage selectedImage =
          SelectedImage(source: source, file: File(croppedFile.path));
      imageNotifier.value = selectedImage;
      imageNotifier.notifyListeners();
      print(selectedImage);
      return selectedImage;
    }
  }

  if (pickedFile != null && nocrop) {
    final SelectedImage selectedImage =
        SelectedImage(source: source, file: File(pickedFile.path));
    imageNotifier.value = selectedImage;
    imageNotifier.notifyListeners();
    return selectedImage;
  }
  NotificationHelper.showSnackBar(label: 'Image not selected');
  return null;
}

Future<XFile?> pickImage({
  required ImageSource source,
  required double maxWidth,
  required double maxHeight,
}) async {
  XFile? pickedFile = await ImagePicker()
      .pickImage(source: source, maxHeight: maxHeight, maxWidth: maxWidth);
  return pickedFile;
}

Future<CroppedFile?> cropImage({
  required String sourcePath,
  int maxWidth = 300,
  int maxHeight = 300,
}) async {
  CroppedFile? croppedFile = await ImageCropper().cropImage(
    sourcePath: sourcePath,
    maxHeight: maxHeight,
    maxWidth: maxWidth,
    aspectRatioPresets: Platform.isAndroid
        ? [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ]
        : [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio5x3,
            CropAspectRatioPreset.ratio5x4,
            CropAspectRatioPreset.ratio7x5,
            CropAspectRatioPreset.ratio16x9
          ],
    uiSettings: [
      AndroidUiSettings(
        toolbarTitle: 'Cropper',
        toolbarColor: KColors.primaryColor,
        activeControlsWidgetColor: KColors.primaryColor,
        toolbarWidgetColor: KColors.textColor,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
      ),
      IOSUiSettings(
        title: 'Cropper',
      ),
      WebUiSettings(
        context: navigatorKey.currentState!.context,
      ),
    ],
  );
  return croppedFile;
}
