import 'dart:io';
import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gsheets/gsheets.dart';
import 'package:miletrack/app/data/constants.dart' as constants;
import 'package:miletrack/app/routes/app_pages.dart';

class TransaksiController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;
  final transaksi = [].obs;
  final transaksiKaryawan = [].obs;
  final loading = false.obs;
  final karyawan = [].obs;
  final loadingUpdate = false.obs;
  final selectedKaryawan = [];
  final List<String> selectedKaryawanString = [];
  final loadingDelete = false.obs;
  final fileSuratTugasString = ''.obs;
  final mobil = [].obs;
  final idMobil = ''.obs;
  final selectedMobil = ''.obs;
  final pdfLink = ''.obs;

  TextEditingController nopol = TextEditingController();
  TextEditingController tujuan = TextEditingController();
  TextEditingController pemilik = TextEditingController();
  TextEditingController tanggalKeluar = TextEditingController();
  TextEditingController jamKeluar = TextEditingController();
  TextEditingController jarakKeluar = TextEditingController();
  TextEditingController tanggalMasuk = TextEditingController();
  TextEditingController jamMasuk = TextEditingController();
  TextEditingController jarakMasuk = TextEditingController();
  TextEditingController bahanBakar = TextEditingController();

  File? fileSuratTugas;

  @override
  void onInit() async {
    super.onInit();
    await getTransaksi();
    await getTransaksiKaryawan();
    await getKaryawan();
    await getMobil();
  }

  getTransaksi() async {
    loading.value = true;
    final gsheets = GSheets(constants.credentialsGsheet);
    final ss = await gsheets.spreadsheet(constants.spreadsheetId);
    final sheet = ss.worksheetByTitle('transaksi');
    final data = await sheet?.values.allRows(
      fromRow: 2,
    );
    transaksi.value = data ?? [];
    loading.value = false;
  }

  getTransaksiKaryawan() async {
    loading.value = true;
    final gsheets = GSheets(constants.credentialsGsheet);
    final ss = await gsheets.spreadsheet(constants.spreadsheetId);
    final sheet = ss.worksheetByTitle('transaksi_karyawan');
    final data = await sheet?.values.allRows(
      fromRow: 2,
    );
    transaksiKaryawan.value = data ?? [];
    loading.value = false;
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

  selectKaryawan(value) {
    var data = [];
    selectedKaryawan.clear();
    for (var kar in value) {
      data = karyawan.where((p0) => p0[1] == kar).toList();
      selectedKaryawan.add(data[0]);
    }
  }

  selectMobil(value) {
    var noPlat = value.split(' - ')[0];
    idMobil.value =
        mobil.where((element) => element[1] == noPlat).toList()[0][0];
  }

  insertTransaksi() async {
    loading.value = true;
    final id = DateTime.now().millisecondsSinceEpoch;
    // Create a reference to the file in Firebase Storage
    try {
      final reference = FirebaseStorage.instance
          .ref()
          .child('surat_tugas/' + id.toString() + '.pdf');

      // Upload the file to Firebase Storage
      final uploadTask = reference.putFile(fileSuratTugas!);
      final snapshot = await uploadTask.whenComplete(() {});

      // Get the download URL of the uploaded file
      final downloadUrl =
          "https://firebasestorage.googleapis.com/v0/b/miletrack-d51bb.appspot.com/o/surat_tugas%2F$id.pdf?alt=media";
      final gsheets = GSheets(constants.credentialsGsheet);
      final ss = await gsheets.spreadsheet(constants.spreadsheetId);

      //add to transaksi
      final sheet = ss.worksheetByTitle('transaksi');
      await sheet?.values.appendRow(
        [
          id,
          idMobil.toString(),
          tujuan.text,
          jarakKeluar.text,
          tanggalKeluar.text,
          downloadUrl
        ],
      );
      final sheet2 = ss.worksheetByTitle('transaksi_karyawan');
      for (var data in karyawan) {
        await sheet2?.values.appendRow(
          [DateTime.now().millisecondsSinceEpoch, data[0], id],
        );
      }

      loading.value = false;
      await getTransaksi();
      Get.snackbar('Berhasil', 'Data berhasil ditambahkan');
      // Get.offAllNamed(Routes.TRANSAKSI);
      Get.back();
      clearText();
    } catch (e) {
      loading.value = false;
      Get.snackbar('Gagal', 'Upload file gagal, harap ulangi kembali');
      print(e);
    }
  }

  clearText() {
    nopol.clear();
    tujuan.clear();
    pemilik.clear();
    tanggalKeluar.clear();
    jamKeluar.clear();
    jarakKeluar.clear();
    tanggalMasuk.clear();
    jamMasuk.clear();
    jarakMasuk.clear();
    bahanBakar.clear();
    selectedKaryawan.clear();
    selectedKaryawanString.clear();
    fileSuratTugasString.value = '';
    fileSuratTugas = null;
    idMobil.value = '';
    selectedMobil.value = '';
  }

  detailTransaksi(row) async {
    loading.value = true;
    clearText();
    final gsheets = GSheets(constants.credentialsGsheet);
    final ss = await gsheets.spreadsheet(constants.spreadsheetId);
    final sheet = ss.worksheetByTitle('transaksi');
    final transaksi = await sheet?.values.allRows(fromRow: 2);
    final allData = transaksi ?? [];
    var detail = [];
    for (var trans in allData) {
      if (trans[0] == row) {
        detail = trans;
        break;
      }
    }

    // nopol.text = detail[1].toString();
    idMobil.value = detail[1].toString();
    var searchMobil = mobil.where((p0) => p0[0] == detail[1]).toList();
    selectedMobil.value = searchMobil[0][1] + ' - ' + searchMobil[0][2];
    tujuan.text = detail[2].toString();
    tanggalKeluar.text = detail[4].toString();
    jarakKeluar.text = detail[3].toString();
    jarakMasuk.text = detail.length >= 7 ? detail[6].toString() : '';
    tanggalMasuk.text = detail.length >= 8 ? detail[7].toString() : '';
    pdfLink.value = detail[5];

    final sheet2 = ss.worksheetByTitle('transaksi_karyawan');
    final data = await sheet2?.values.allRows(
      fromRow: 2,
    );
    final karyawan = data ?? [];

    final sheet3 = ss.worksheetByTitle('master karyawan');
    final data2 = await sheet3?.values.allRows(
      fromRow: 2,
    );
    final karyawan2 = data2 ?? [];

    for (var kar in karyawan) {
      if (kar[2] == detail[0]) {
        for (var kar2 in karyawan2) {
          if (kar2[0] == kar[1]) {
            selectedKaryawan.add(kar2[0]);
            selectedKaryawanString.add(kar2[1]);
          }
        }
      }
    }

    loading.value = false;
  }

  updateTransaksi(row) async {
    loading.value = true;
    if (fileSuratTugas != null) {
      try {
        final reference = FirebaseStorage.instance
            .ref()
            .child('surat_tugas/' + row.toString() + '.pdf');

        // Upload the file to Firebase Storage
        final uploadTask = reference.putFile(fileSuratTugas!);
        final snapshot = await uploadTask.whenComplete(() {});
      } catch (e) {
        Get.snackbar('Gagal', 'File gagal di upload, ulangi kembali');
        return;
      }
    }
    final gsheets = GSheets(constants.credentialsGsheet);
    final ss = await gsheets.spreadsheet(constants.spreadsheetId);
    final sheet = ss.worksheetByTitle('transaksi');
    final allData = await sheet?.values.allRows(fromRow: 2);
    final data = allData ?? [];
    final index = data.indexWhere((element) => element[0] == row) + 2;

    var jarakMasukCek = jarakMasuk.text == '' ? '0' : jarakMasuk.text;
    await sheet?.values.insertRow(
        index,
        [
          idMobil,
          tujuan.text,
          jarakKeluar.text,
          tanggalKeluar.text,
          "https://firebasestorage.googleapis.com/v0/b/miletrack-d51bb.appspot.com/o/surat_tugas%2F$row.pdf?alt=media",
          jarakMasuk.text,
          tanggalMasuk.text,
          int.parse(jarakMasukCek) - int.parse(jarakKeluar.text),
        ],
        fromColumn: 2);

    final sheet2 = ss.worksheetByTitle('transaksi_karyawan');
    var delKaryawan = true;
    while (delKaryawan) {
      var indexTransaksiKaryawan =
          transaksiKaryawan.indexWhere((element) => element[2] == row);
      if (indexTransaksiKaryawan == -1) {
        delKaryawan = false;
      } else {
        await sheet2?.deleteRow(indexTransaksiKaryawan + 2);
        transaksiKaryawan.removeAt(indexTransaksiKaryawan);
      }
    }

    for (var data in selectedKaryawan) {
      await sheet2?.values.appendRow(
        [DateTime.now().millisecondsSinceEpoch, data[0], row],
      );
    }
    loading.value = false;
    await getTransaksi();
    Get.snackbar('Berhasil', 'Data berhasil diubah');
    // Get.offAllNamed(Routes.TRANSAKSI);
    Get.back();
  }

  deleteTransaksi(id) async {
    loadingDelete.value = true;
    final gsheets = GSheets(constants.credentialsGsheet);
    final ss = await gsheets.spreadsheet(constants.spreadsheetId);

    var indexTransaksi =
        transaksi.indexWhere((element) => element[0] == id) + 2;

    final sheet = ss.worksheetByTitle('transaksi');
    await sheet?.deleteRow(indexTransaksi);

    var delKaryawan = true;

    final sheet2 = ss.worksheetByTitle('transaksi_karyawan');
    while (delKaryawan) {
      var indexTransaksiKaryawan =
          transaksiKaryawan.indexWhere((element) => element[2] == id);
      // print(delKaryawan.toString() + ' ' + indexTransaksiKaryawan.toString());
      if (indexTransaksiKaryawan == -1) {
        delKaryawan = false;
      } else {
        await sheet2?.deleteRow(indexTransaksiKaryawan + 2);
        transaksiKaryawan.removeAt(indexTransaksiKaryawan);
      }
    }
    try {
      final reference =
          FirebaseStorage.instance.ref().child('surat_tugas%2F$id');
      await reference.delete();
    } catch (e) {
      print(e);
    }

    Get.snackbar('Berhasil', 'Data berhasil dihapus');
    await getTransaksi();
  }
}
