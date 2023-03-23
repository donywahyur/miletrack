import 'package:get/get.dart';

import '../controllers/mobil_controller.dart';

class MobilBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MobilController>(
      () => MobilController(),
    );
  }
}
