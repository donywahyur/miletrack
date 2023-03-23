import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miletrack/app/data/constants.dart';
import 'package:miletrack/app/modules/transaksi/controllers/transaksi_controller.dart';

class AddTransaksi extends StatefulWidget {
  const AddTransaksi({super.key});

  @override
  State<AddTransaksi> createState() => _AddTransaksiState();
}

class _AddTransaksiState extends State<AddTransaksi> {
  final _form = GlobalKey<FormState>();
  DateTime dateTime = DateTime.now(); //y , m , d
  var controller = Get.find<TransaksiController>();

  @override
  Widget build(BuildContext context) {
    controller.clearText();
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: color1,
        title: const Text('Tambah Transaksi'),
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
                DropdownSearch<String>(
                    onChanged: (value) {
                      controller.selectMobil(value);
                    },
                    validator: (value) {
                      return value == null ? 'Wajib diisi' : null;
                    },
                    mode: Mode.MENU,
                    showSelectedItems: true,
                    items: controller.mobil
                        .map((element) =>
                            element[1].toString() +
                            " - " +
                            element[2].toString())
                        .toList(),
                    showSearchBox: true,
                    dropdownSearchDecoration: InputDecoration(
                      labelText: 'Mobil',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: color1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: color1),
                      ),
                      labelStyle: TextStyle(color: color1),
                    )),
                // TextFormField(
                //   validator: (value) {
                //     if (value!.isEmpty) {
                //       return 'Wajib diisi';
                //     }
                //     return null;
                //   },
                //   controller: controller.nopol,
                //   decoration: InputDecoration(
                //     labelText: 'No Polisi',
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(10),
                //       borderSide: BorderSide(color: color1),
                //     ),
                //     focusedBorder: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(10),
                //       borderSide: BorderSide(color: color1),
                //     ),
                //     labelStyle: TextStyle(color: color1),
                //   ),
                // ),
                const SizedBox(height: 20),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Wajib diisi';
                    }
                    return null;
                  },
                  controller: controller.tujuan,
                  decoration: InputDecoration(
                    labelText: 'Keperluan / Tujuan',
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
                TextFormField(
                  readOnly: true,
                  onTap: pickDateTime,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Wajib diisi';
                    }
                    return null;
                  },
                  controller: controller.tanggalKeluar,
                  decoration: InputDecoration(
                    labelText: 'Tanggal Keluar',
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
                TextFormField(
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Wajib diisi';
                    }
                    return null;
                  },
                  controller: controller.jarakKeluar,
                  decoration: InputDecoration(
                    labelText: 'Km Keluar',
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
                const SizedBox(
                  height: 20,
                ),
                DropdownSearch<String>.multiSelection(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Wajib diisi';
                    }
                    return null;
                  },
                  mode: Mode.MENU,
                  showSelectedItems: true,
                  items: controller.karyawan
                      .map((element) => element[1].toString())
                      .toList(),
                  showSearchBox: true,
                  dropdownSearchDecoration: InputDecoration(
                    labelText: 'Karyawan',
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
                  onChanged: (value) {
                    controller.selectKaryawan(value);
                    // print(value);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton.icon(
                      icon: const Icon(
                        Icons.upload_file,
                        color: Colors.white,
                        size: 24.0,
                      ),
                      label:
                          const Text('File', style: TextStyle(fontSize: 16.0)),
                      onPressed: () async {
                        FilePickerResult? result = await FilePicker.platform
                            .pickFiles(
                                type: FileType.custom,
                                allowedExtensions: ['pdf']);
                        if (result != null) {
                          controller.fileSuratTugasString.value =
                              result.files.single.name;
                          controller.fileSuratTugas =
                              File(result.files.single.path.toString());
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: color3,
                        minimumSize: const Size(122, 48),
                        maximumSize: const Size(122, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Obx(() => Flexible(
                          child: Text(
                            controller.fileSuratTugasString.value == ''
                                ? 'File Surat Tugas'
                                : controller.fileSuratTugasString.value,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: Get.width,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (controller.loading.value == false) {
                        if (controller.fileSuratTugasString.value == '') {
                          Get.snackbar('Error', 'File Surat Tugas Wajib Diisi');
                          return;
                        }
                        if (_form.currentState!.validate()) {
                          controller.insertTransaksi();
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
  Future<TimeOfDay?> pickTime() => showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute));

  Future pickDateTime() async {
    DateTime? date = await pickDate();
    if (date == null) return;
    TimeOfDay? time = await pickTime();
    if (time == null) return;

    final dateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    controller.tanggalKeluar.text =
        "${dateTime.day}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:00";
  }
}
