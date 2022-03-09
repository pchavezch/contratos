import 'dart:io';

import 'package:flutter/material.dart';
import 'package:advance_pdf_viewer_fork/advance_pdf_viewer_fork.dart';
//import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

//import 'package:path_provider/path_provider.dart';
//import 'package:share_plus/share_plus.dart';
//import 'package:share_plus/share_plus.dart';
//import 'package:share/share.dart';

class PDFScreen extends StatefulWidget {
  var urlToDoc;
  var titleForDoc;

  PDFScreen({Key? key, this.urlToDoc, this.titleForDoc}) : super(key: key);

  _PDFScreenState createState() => _PDFScreenState(urlToDoc, titleForDoc);
}

class _PDFScreenState extends State<PDFScreen> with WidgetsBindingObserver {
  var urlToDoc;
  var titleForDoc;
  bool _isLoading = true;
  late PDFDocument document;

  _PDFScreenState(this.urlToDoc, this.titleForDoc) {}
  @override
  void initState() {
    super.initState();

    print(titleForDoc + "[" + urlToDoc + "]");
    loadDocument();
  }

  loadDocument() async {
    document = await PDFDocument.fromURL(urlToDoc
        //"https://gocorporation.org/Download/GODOC/FIDEICOMISOVEH%C3%8DCULOSBANCODELAUSTROTF-C-263_G3LAKD178978_46901.pdf"
        //"https://unec.edu.az/application/uploads/2014/12/pdf-sample.pdf",
        //"http://192.168.1.105:3747/Recursos/Pdfs/PPDYSC/FIDEICOMISOVEHÍCULOSBANCODELAUSTROTF-C-263_G3LAKD178978_46901.pdf"
        /* cacheManager: CacheManager(
          Config(
            "customCacheKey",
            stalePeriod: const Duration(days: 2),
            maxNrOfCacheObjects: 10,
          ),
        ), */
        );

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          titleForDoc,
          style: TextStyle(fontSize: 12),
        ),
        backgroundColor: Colors.lightGreen,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () async {
              //final ByteData bytes = await rootBundle.load(urlToDoc);
              /*http.Response response = await http.get(Uri.parse(urlToDoc));
              var sharePdf = await response.bodyBytes;
              await Share.file(
                'PDF Document',
                'project.pdf',
                sharePdf.buffer.asUint8List(),

              );*/
              /*if (Platform.isAndroid) {
                var response = await get(urlToDoc);
                final documentDirectory =
                    (await getExternalStorageDirectory())?.path;
                File imgFile = File('$documentDirectory/archive.pdf');
                imgFile.writeAsBytesSync(response.bodyBytes);
                Share.shareFiles(
                  ['$documentDirectory/archive.pdf'],
                  text: 'Hello, check your share files!',
                );
              }*/
              //final ByteData bytes = response.bodyBytes;
              //Share.shareFiles(urlToDoc,"");
            },
          ),
        ],
      ),
      body: Center(
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : PDFViewer(
                  document: document,
                  zoomSteps: 1,
                  //uncomment below line to preload all pages
                  // lazyLoad: false,
                  // uncomment below line to scroll vertically
                  // scrollDirection: Axis.vertical,

                  //uncomment below code to replace bottom navigation with your own
                  /* navigationBuilder:
                      (context, page, totalPages, jumpToPage, animateToPage) {
                    return ButtonBar(
                      alignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.first_page),
                          onPressed: () {
                            jumpToPage(page: 0);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            animateToPage(page: page! - 2);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_forward),
                          onPressed: () {
                            animateToPage(page: page);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.last_page),
                          onPressed: () {
                            jumpToPage(page: totalPages! - 1);
                          },
                        ),
                      ],
                    );
                  },*/
                )),
    );
  }
}
