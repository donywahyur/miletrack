import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:miletrack/app/data/constants.dart';

import 'app/routes/app_pages.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Future.delayed(const Duration(seconds: 1), () {
    Get.offAllNamed(Routes.HOME);
  });

  runApp(
    GetMaterialApp(
      title: "MileTrack",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
