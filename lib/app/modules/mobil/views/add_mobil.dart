import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miletrack/app/data/constants.dart';
import 'package:miletrack/app/modules/mobil/controllers/mobil_controller.dart';

class AddMobil extends StatefulWidget {
  const AddMobil({super.key});

  @override
  State<AddMobil> createState() => _AddMobilState();
}

class _AddMobilState extends State<AddMobil> {
  final _form = GlobalKey<FormState>();
  DateTime dateTime = DateTime.now(); //y , m , d
  var controller = Get.find<MobilController>();

  @override
  Widget build(BuildContext context) {
    controller.clearText();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: color1,
        title: const Text('Tambah Mobil'),
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
                  controller: controller.nomorPlat,
                  decoration: InputDecoration(
                    labelText: 'Nomor Plat',
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
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Wajib diisi';
                    }
                    return null;
                  },
                  controller: controller.namaPemilik,
                  decoration: InputDecoration(
                    labelText: 'Nama Pemilik',
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
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Wajib diisi';
                    }
                    return null;
                  },
                  controller: controller.nomorRangka,
                  decoration: InputDecoration(
                    labelText: 'Nomor Rangka',
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
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Wajib diisi';
                    }
                    return null;
                  },
                  controller: controller.nomorMesin,
                  decoration: InputDecoration(
                    labelText: 'Nomor Mesin',
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
                TextFormField(
                  onTap: () async {
                    final date = await pickDate();
                    if (date == null) return;

                    controller.tanggalPajak.text =
                        "${date.day}/${date.month.toString().padLeft(2, '0')}/${date.year}";
                  },
                  readOnly: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Wajib diisi';
                    }
                    return null;
                  },
                  controller: controller.tanggalPajak,
                  decoration: InputDecoration(
                    labelText: 'Tanggal Pajak',
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
                TextFormField(
                  onTap: () async {
                    final date = await pickDate();
                    if (date == null) return;

                    controller.tanggalStnk.text =
                        "${date.day}/${date.month.toString().padLeft(2, '0')}/${date.year}";
                  },
                  readOnly: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Wajib diisi';
                    }
                    return null;
                  },
                  controller: controller.tanggalStnk,
                  decoration: InputDecoration(
                    labelText: 'Tanggal STNK',
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
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Wajib diisi';
                    }
                    return null;
                  },
                  controller: controller.bbm,
                  decoration: InputDecoration(
                    labelText: 'BBM',
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
                          controller.insertMobil();
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

  Future<DateTime?> pickDate() => showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(2022),
      lastDate: DateTime(2100));
}
