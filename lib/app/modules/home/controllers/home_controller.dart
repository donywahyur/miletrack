import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gsheets/gsheets.dart';
import 'package:miletrack/app/data/constants.dart' as constants;
import 'package:miletrack/app/modules/karyawan/views/karyawan_view.dart';
import 'package:miletrack/app/modules/mobil/views/mobil_view.dart';
import 'package:miletrack/app/modules/transaksi/views/transaksi_view.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final selectedIndex = 0.obs;

  List<Widget> pages = [
    TransaksiView(),
    KaryawanView(),
    MobilView(),
  ];
}
