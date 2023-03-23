import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:miletrack/app/data/constants.dart';
import 'package:miletrack/app/modules/transaksi/views/detail_transaksi.dart';

import '../controllers/transaksi_controller.dart';
import 'add_transaksi.dart';

class TransaksiView extends GetView<TransaksiController> {
  const TransaksiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color1,
        title: const Text('Daftar Transaksi'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => controller.loading.value
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: controller.transaksi.length,
                  itemBuilder: (context, index) {
                    final data = controller.transaksi[index];
                    // print(data);
                    // var epch = new DateTime(1899, 12, 30);
                    // var datetime =
                    //     epch.add(new Duration(days: int.parse(data[4])));
                    // var date = datetime.toString().split(" ")[0];
                    var datetime = data[4].split(" ");
                    var datefull = datetime[0].split("/");
                    var date = datefull[0] +
                        " " +
                        bulan[int.parse(datefull[1])] +
                        " " +
                        datefull[2];
                    var mobil =
                        controller.mobil.where((e) => e[0] == data[1]).toList();

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailTransaksi(
                                      row: data[0],
                                    )));
                      },
                      child: Card(
                        elevation: 3,
                        child: ListTile(
                            contentPadding: EdgeInsets.all(10),
                            title: Text(
                                "No Pol : ${mobil[0][1]}\nPemilik : ${mobil[0][2]}"),
                            subtitle: Text(
                                "\nTanggal Keluar : ${date} \nTujuan : ${data[2]}"),
                            trailing: IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: ((context) {
                                      //confirm yes / no
                                      return Obx(() => controller
                                              .loadingDelete.value
                                          ? Dialog(
                                              // The background color
                                              backgroundColor: Colors.white,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 20),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: const [
                                                    // The loading indicator
                                                    CircularProgressIndicator(),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    // Some text
                                                    Text('Loading...')
                                                  ],
                                                ),
                                              ))
                                          : AlertDialog(
                                              title: Text("Konfirmasi"),
                                              content: Text(
                                                  "Apakah anda yakin ingin menghapus data ini?"),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("Tidak")),
                                                TextButton(
                                                    onPressed: () async {
                                                      await controller
                                                          .deleteTransaksi(
                                                              data[0]);
                                                      // controller.getDataByRowId();
                                                      Navigator.pop(context);
                                                      controller.loadingDelete
                                                          .value = false;
                                                    },
                                                    child: Text("Ya")),
                                              ],
                                            ));
                                    }));
                                //pop up dialog

                                // controller.deleteTransaksi(data[0]);
                                // controller.getDataByRowId();
                              },
                              icon: const Icon(Icons.delete),
                            )),
                      ),
                    );
                  },
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: color1,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddTransaksi()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
