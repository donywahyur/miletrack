import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/karyawan/bindings/karyawan_binding.dart';
import '../modules/karyawan/views/karyawan_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/mobil/bindings/mobil_binding.dart';
import '../modules/mobil/views/mobil_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/transaksi/bindings/transaksi_binding.dart';
import '../modules/transaksi/views/transaksi_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.TRANSAKSI,
      page: () => const TransaksiView(),
      binding: TransaksiBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.KARYAWAN,
      page: () => const KaryawanView(),
      binding: KaryawanBinding(),
    ),
    GetPage(
      name: _Paths.MOBIL,
      page: () => const MobilView(),
      binding: MobilBinding(),
    ),
  ];
}
