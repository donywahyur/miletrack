import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:miletrack/app/data/constants.dart';
import 'package:path_provider/path_provider.dart';

class PdfView extends StatefulWidget {
  const PdfView({super.key, required this.link});
  final link;
  @override
  State<PdfView> createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {
  String _localPath = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadPdf().then((value) {
      setState(() {
        _localPath = value;
      });
    });
  }

  Future<String> loadPdf() async {
    var response = await http.get(Uri.parse(widget.link.toString()));
    var dir = await getTemporaryDirectory();
    File file = new File(dir.path + "/file.pdf");
    file.writeAsBytesSync(response.bodyBytes, flush: true);
    return file.path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color1,
        title: Text("File"),
      ),
      body: Center(
          child: _localPath == ""
              ? CircularProgressIndicator()
              : Container(
                  child: PDFView(
                    filePath: _localPath,
                  ),
                )),
    );
  }
}
