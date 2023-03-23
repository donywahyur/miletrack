import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:miletrack/app/data/constants.dart';
import 'package:miletrack/app/modules/karyawan/controllers/karyawan_controller.dart';

class DetailKaryawan extends StatefulWidget {
  const DetailKaryawan({super.key, required this.row});
  final String row;

  @override
  State<DetailKaryawan> createState() => _DetailKaryawanState();
}

class _DetailKaryawanState extends State<DetailKaryawan> {
  final controller = Get.find<KaryawanController>();
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      controller.detailTransaksi(widget.row);
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: color1,
        title: const Text('Edit Karyawan'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _form,
              child: Obx(() => controller.loading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
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
                        const SizedBox(height: 20),
                        SizedBox(
                          width: Get.width,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              if (controller.loading.value == false) {
                                if (_form.currentState!.validate()) {
                                  controller.updateTransaksi(widget.row);
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: color1,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            child: Obx(() => Text(
                                  controller.loadingUpdate.value == true
                                      ? 'Loading...'
                                      : 'Simpan',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1),
                                )),
                          ),
                        ),
                      ],
                    )),
            )),
      ),
    );
  }
}
