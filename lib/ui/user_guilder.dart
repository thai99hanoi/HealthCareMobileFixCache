import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
// import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';

class UserGuilderScreen extends StatefulWidget {
  @override
  _UserGuilderScreenState createState() => _UserGuilderScreenState();
}

class _UserGuilderScreenState extends State<UserGuilderScreen> {
  late PdfViewerController _pdfViewerController;
  String pathPDF = "";
  // PDFDocument? document;

  @override
  void initState() {
    super.initState();
    _pdfViewerController = PdfViewerController();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(78, 159, 193, 1),
          title: const Text("BÁO CÁO SỨC KHOẺ HÀNG NGÀY"),
          automaticallyImplyLeading: true,


          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.keyboard_arrow_up,
                color: Colors.white,
              ),
              onPressed: () {
                _pdfViewerController.previousPage();
              },
            ),
            IconButton(
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
              ),
              onPressed: () {
                _pdfViewerController.nextPage();
              },
            ),
          ],
        ),
        body:
        SfPdfViewer.asset(
          'assets/files/cham-soc-f0.pdf',
          controller: _pdfViewerController,
        ),

            ),
      );

  }
}
