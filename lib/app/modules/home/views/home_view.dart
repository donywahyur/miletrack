import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:miletrack/app/data/constants.dart';
import 'package:miletrack/app/modules/transaksi/views/transaksi_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: controller.pages[controller.selectedIndex.value],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.selectedIndex.value,
            selectedItemColor: color1,
            unselectedItemColor: Colors.grey,
            onTap: (index) {
              controller.selectedIndex.value = index;
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.note_add_outlined),
                label: 'Transaksi',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: 'Karyawan',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.car_rental_outlined),
                label: 'Mobil',
              ),
            ],
          ),
        ));
  }
}
