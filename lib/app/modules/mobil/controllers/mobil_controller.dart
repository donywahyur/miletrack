import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gsheets/gsheets.dart';
import 'package:miletrack/app/data/constants.dart' as constants;

class MobilController extends GetxController {
  //TODO: Implement MobilController

  final count = 0.obs;
  final loading = false.obs;
  final mobil = [].obs;
  final loadingDelete = false.obs;
  final loadingUpdate = false.obs;

  TextEditingController nomorPlat = TextEditingController();
  TextEditingController namaPemilik = TextEditingController();
  TextEditingController nomorRangka = TextEditingController();
  TextEditingController nomorMesin = TextEditingController();
  TextEditingController tanggalPajak = TextEditingController();
  TextEditingController tanggalStnk = TextEditingController();
  TextEditingController bbm = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getMobil();
  }

  getMobil() async {
    loading.value = true;

    final gsheets = GSheets(constants.credentialsGsheet);
    final ss = await gsheets.spreadsheet(constants.spreadsheetId);
    final sheet = ss.worksheetByTitle('master mobil');
    final data = await sheet?.values.allRows(
      fromRow: 2,
    );
    mobil.value = data ?? [];
    loading.value = false;
  }

  insertMobil() async {
    loading.value = true;

    final gsheets = GSheets(constants.credentialsGsheet);
    final ss = await gsheets.spreadsheet(constants.spreadsheetId);
    final sheet = ss.worksheetByTitle('master mobil');
    await sheet?.values.appendRow([
      DateTime.now().millisecondsSinceEpoch,
      nomorPlat.text,
      namaPemilik.text,
      nomorRangka.text,
      nomorMesin.text,
      tanggalPajak.text,
      tanggalStnk.text,
      bbm.text,
    ]);
    loading.value = false;
    clearText();
    Get.back();
    Get.snackbar('Berhasil', 'Berhasil menambahkan karyawan');
    getMobil();
  }

  detailTransaksi(row) async {
    loading.value = true;
    clearText();
    final gsheets = GSheets(constants.credentialsGsheet);
    final ss = await gsheets.spreadsheet(constants.spreadsheetId);
    final sheet = ss.worksheetByTitle('master mobil');
    final transaksi = await sheet?.values.allRows(fromRow: 2);
    final allData = transaksi ?? [];
    var detail = [];
    for (var trans in allData) {
      if (trans[0] == row) {
        detail = trans;
        break;
      }
    }

    nomorPlat.text = detail[1].toString();
    namaPemilik.text = detail[2].toString();
    nomorRangka.text = detail[3].toString();
    nomorMesin.text = detail[4].toString();
    tanggalPajak.text = detail[5].toString();
    tanggalStnk.text = detail[6].toString();
    bbm.text = detail[7].toString();

    loading.value = false;
  }

  updateMobil(row) async {
    loadingUpdate.value = true;
    final gsheets = GSheets(constants.credentialsGsheet);
    final ss = await gsheets.spreadsheet(constants.spreadsheetId);
    final sheet = ss.worksheetByTitle('master mobil');
    final allData = await sheet?.values.allRows(fromRow: 2);
    final data = allData ?? [];
    final index = data.indexWhere((element) => element[0] == row) + 2;

    await sheet?.values.insertRow(
        index,
        [
          nomorPlat.text,
          namaPemilik.text,
          nomorRangka.text,
          nomorMesin.text,
          tanggalPajak.text,
          tanggalStnk.text,
          bbm.text,
        ],
        fromColumn: 2);
    loadingUpdate.value = false;
    await getMobil();
    Get.snackbar('Berhasil', 'Data berhasil diubah');
    Get.back();
  }

  clearText() {
    nomorPlat.clear();
    nomorPlat.clear();
    namaPemilik.clear();
    nomorRangka.clear();
    nomorMesin.clear();
    tanggalPajak.clear();
    tanggalStnk.clear();
    bbm.clear();
  }

  deleteMobil(id) async {
    loadingDelete.value = true;
    final gsheets = GSheets(constants.credentialsGsheet);
    final ss = await gsheets.spreadsheet(constants.spreadsheetId);

    var indexKaryawan = mobil.indexWhere((element) => element[0] == id) + 2;

    final sheet = ss.worksheetByTitle('master mobil');
    await sheet?.deleteRow(indexKaryawan);
    loadingDelete.value = false;
    Get.snackbar('Berhasil', 'Data berhasil dihapus');
    getMobil();
  }
}
