import 'package:get/get.dart';
import 'package:miletrack/app/modules/karyawan/controllers/karyawan_controller.dart';
import 'package:miletrack/app/modules/mobil/controllers/mobil_controller.dart';
import 'package:miletrack/app/modules/transaksi/controllers/transaksi_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<TransaksiController>(
      () => TransaksiController(),
    );
    Get.lazyPut<KaryawanController>(
      () => KaryawanController(),
    );
    Get.lazyPut<MobilController>(
      () => MobilController(),
    );
  }
}
