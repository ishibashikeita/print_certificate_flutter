import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:print_certificate_flutter/const.dart';
import 'package:print_certificate_flutter/main.dart';
import 'pdf_generator.dart';
import 'dart:math';

class TemplateSelectionScreen extends StatefulWidget {
  @override
  State<TemplateSelectionScreen> createState() =>
      _TemplateSelectionScreenState();
}

class _TemplateSelectionScreenState extends State<TemplateSelectionScreen> {
  bool article = true;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        backgroundColor: subColor,
        foregroundColor: white,
        title: Text(
          '用紙の向きを選ぼう！',
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: size.width,
                    height: size.height * 0.5,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        article = true;
                                      });
                                    },
                                    child: Container(
                                      width: size.width * 0.4,
                                      height: size.width * 0.4,
                                      decoration: BoxDecoration(
                                        color: article == true
                                            ? subColor
                                            : mainColor,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: article == true
                                              ? Colors.transparent
                                              : grey,
                                          width: article == true ? 3 : 1,
                                        ),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.article,
                                          size: size.width * 0.2,
                                          color: article == true
                                              ? mainColor
                                              : grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: size.width * 0.3,
                                    height: size.height * 0.05,
                                    child: FittedBox(
                                      child: Text(
                                        '横書き',
                                        style: TextStyle(
                                          color: article == true ? black : grey,
                                          fontWeight: article == true
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        article = false;
                                      });
                                    },
                                    child: Container(
                                      width: size.width * 0.4,
                                      height: size.width * 0.4,
                                      decoration: BoxDecoration(
                                        color: article == false
                                            ? subColor
                                            : mainColor,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          width: article == false ? 3 : 1,
                                          color: article == false
                                              ? Colors.transparent
                                              : grey,
                                        ),
                                      ),
                                      child: Center(
                                        child: Transform.rotate(
                                          angle: 90 * pi / 180,
                                          child: Icon(
                                            Icons.article,
                                            size: size.width * 0.2,
                                            color: article == false
                                                ? mainColor
                                                : grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: size.width * 0.3,
                                    height: size.height * 0.05,
                                    child: FittedBox(
                                      child: Text(
                                        '縦書き',
                                        style: TextStyle(
                                          color:
                                              article == false ? black : grey,
                                          fontWeight: article == false
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // color: Colors.amber,
                    width: size.width * 0.4,
                    height: size.height * 0.1,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: subColor,
                        foregroundColor: white,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => article == false
                                ? PdfPreviewScreen(template: 'Template 1')
                                : PdfPreviewScreen(template: 'Template 2'),
                          ),
                        );
                      },
                      child: Text(
                        '選択',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: FutureBuilder(
                  future: loadBanner(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final banner = snapshot.data;
                      return SizedBox(
                          height: 64,
                          width: double.infinity,
                          child: AdWidget(ad: banner));
                    } else {
                      return Container();
                    }
                  }),
            ),
          ],
        ),
      ),
      // body: ListView(
      //   children: [
      //     ListTile(
      //       title: Text('Template 1'),
      //       onTap: () {
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //               builder: (context) =>
      //                   PdfPreviewScreen(template: 'Template 1')),
      //         );
      //       },
      //     ),
      //     ListTile(
      //       title: Text('Template 2'),
      //       onTap: () {
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //               builder: (context) =>
      //                   PdfPreviewScreen(template: 'Template 2')),
      //         );
      //       },
      //     ),
      //   ],
      // ),
    );
  }
}
