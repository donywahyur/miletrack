import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miletrack/app/data/constants.dart';
import 'package:miletrack/app/modules/karyawan/controllers/karyawan_controller.dart';

class AddKaryawan extends StatefulWidget {
  const AddKaryawan({super.key});

  @override
  State<AddKaryawan> createState() => _AddKaryawanState();
}

class _AddKaryawanState extends State<AddKaryawan> {
  final _form = GlobalKey<FormState>();
  var controller = Get.find<KaryawanController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color1,
        title: const Text('Tambah Karyawan'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _form,
            child: Column(
              children: [
                const SizedBox(height: 20),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Wajib diisi';
                    }
                    return null;
                  },
                  controller: controller.nama,
                  decoration: InputDecoration(
                    labelText: 'Nama',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: color1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: color1),
                    ),
                    labelStyle: TextStyle(color: color1),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: Get.width,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (controller.loading.value == false) {
                        if (_form.currentState!.validate()) {
                          controller.insertKaryawan();
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: color1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: Obx(() => Text(
                          controller.loading.value == true
                              ? 'Loading...'
                              : 'Simpan',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, letterSpacing: 1),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
