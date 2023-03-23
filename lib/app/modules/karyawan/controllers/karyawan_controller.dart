import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gsheets/gsheets.dart';
import 'package:miletrack/app/data/constants.dart' as constants;
import 'package:miletrack/app/routes/app_pages.dart';

class KaryawanController extends GetxController {
  //TODO: Implement KaryawanController

  final loading = false.obs;
  final karyawan = [].obs;
  final loadingUpdate = false.obs;
  final loadingDelete = false.obs;

  TextEditingController nama = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getKaryawan();
  }

  getKaryawan() async {
    loading.value = true;

    final gsheets = GSheets(constants.credentialsGsheet);
    final ss = await gsheets.spreadsheet(constants.spreadsheetId);
    final sheet = ss.worksheetByTitle('master karyawan');
    final data = await sheet?.values.allRows(
      fromRow: 2,
    );
    karyawan.value = data ?? [];
    loading.value = false;
  }

  insertKaryawan() async {
    loading.value = true;

    final gsheets = GSheets(constants.credentialsGsheet);
    final ss = await gsheets.spreadsheet(constants.spreadsheetId);
    final sheet = ss.worksheetByTitle('master karyawan');
    await sheet?.values
        .appendRow([DateTime.now().millisecondsSinceEpoch, nama.text]);
    loading.value = false;
    clearText();
    Get.back();
    Get.snackbar('Berhasil', 'Berhasil menambahkan karyawan');
    getKaryawan();
  }

  detailTransaksi(row) async {
    loading.value = true;
    clearText();
    final gsheets = GSheets(constants.credentialsGsheet);
    final ss = await gsheets.spreadsheet(constants.spreadsheetId);
    final sheet = ss.worksheetByTitle('master karyawan');
    final transaksi = await sheet?.values.allRows(fromRow: 2);
    final allData = transaksi ?? [];
    var detail = [];
    for (var trans in allData) {
      if (trans[0] == row) {
        detail = trans;
        break;
      }
    }

    nama.text = detail[1].toString();

    loading.value = false;
  }

  updateTransaksi(row) async {
    loadingUpdate.value = true;
    final gsheets = GSheets(constants.credentialsGsheet);
    final ss = await gsheets.spreadsheet(constants.spreadsheetId);
    final sheet = ss.worksheetByTitle('master karyawan');
    final allData = await sheet?.values.allRows(fromRow: 2);
    final data = allData ?? [];
    final index = data.indexWhere((element) => element[0] == row) + 2;

    await sheet?.values.insertRow(
        index,
        [
          nama.text,
        ],
        fromColumn: 2);
    loadingUpdate.value = false;
    await getKaryawan();
    Get.snackbar('Berhasil', 'Data berhasil diubah');
    Get.back();
  }

  clearText() {
    nama.clear();
  }

  deleteKaryawan(id) async {
    loadingDelete.value = true;
    final gsheets = GSheets(constants.credentialsGsheet);
    final ss = await gsheets.spreadsheet(constants.spreadsheetId);

    var indexKaryawan = karyawan.indexWhere((element) => element[0] == id) + 2;

    final sheet = ss.worksheetByTitle('master karyawan');
    await sheet?.deleteRow(indexKaryawan);
    loadingDelete.value = false;
    Get.snackbar('Berhasil', 'Data berhasil dihapus');
    getKaryawan();
  }
}
