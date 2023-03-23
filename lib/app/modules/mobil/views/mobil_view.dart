import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:miletrack/app/data/constants.dart';
import 'package:miletrack/app/modules/mobil/views/add_mobil.dart';
import 'package:miletrack/app/modules/mobil/views/detail_mobil.dart';

import '../controllers/mobil_controller.dart';

class MobilView extends GetView<MobilController> {
  const MobilView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color1,
        title: const Text('Daftar Mobil'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => controller.loading.value
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: controller.mobil.length,
                  itemBuilder: (context, index) {
                    final data = controller.mobil[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailMobil(
                                      row: data[0],
                                    )));
                      },
                      child: Card(
                        elevation: 3,
                        child: ListTile(
                            contentPadding: EdgeInsets.all(10),
                            title: Text(
                                "Nomor Plat : ${data[1]}\n\nNama Pemilik : ${data[2]}"),
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
                                                          .deleteMobil(data[0]);
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
              context, MaterialPageRoute(builder: (context) => AddMobil()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
