import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:miletrack/app/data/constants.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
              text: 'Mile',
              style: TextStyle(
                color: color3,
                fontSize: 40,
                letterSpacing: 1,
                fontWeight: FontWeight.bold,
              ),
              children: <TextSpan>[
                TextSpan(text: ' Track', style: TextStyle(color: color4)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const CircularProgressIndicator(),
        ],
      )),
    );
  }
}
