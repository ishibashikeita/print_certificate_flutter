import 'dart:ffi';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:print_certificate_flutter/const.dart';
import 'package:print_certificate_flutter/vertical_rotated.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'certificate_data.dart';

class PdfPreviewScreen extends StatelessWidget {
  final String template;

  PdfPreviewScreen({required this.template});

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<CertificateData>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('完成イメージ'),
        backgroundColor: subColor,
        foregroundColor: Colors.white,
      ),
      body: PdfPreview(
        build: (format) => _generatePdf(format, data, template),
        canChangePageFormat: false,
        canChangeOrientation: false,
        canDebug: false,
        actionBarTheme: PdfActionBarTheme(
          backgroundColor: subColor,
          iconColor: Colors.white,
        ),
      ),
    );
  }

  Future<Uint8List> _generatePdf(
      PdfPageFormat format, CertificateData data, String template) async {
    final pdf = pw.Document();
    final fontData =
        await rootBundle.load('assets/fonts/YujiSyuku-Regular.ttf');
    List<String> desc = getLines(data.description);
    List<String> presentLines = getLines(data.presenter);

    final ttf = pw.Font.ttf(fontData);

    final imageProvider = template == 'Template 1'
        ? await rootBundle.load('assets/095139.png')
        : await rootBundle.load('assets/097245.png');

    final image = pw.MemoryImage(imageProvider.buffer.asUint8List());

    final pageFormat = _getPageFormat(data.paperSize, template);

    if (template == 'Template 1') {
      print(data.description);
      pdf.addPage(
        pw.Page(
          pageFormat: pageFormat,
          build: (context) {
            return pw.Stack(
              children: [
                pw.Positioned.fill(
                  child: pw.Image(image),
                ),
                pw.Center(
                  child: pw.Column(
                    // mainAxisSize: pw.MainAxisSize.min,
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Container(
                        width: pageFormat.width * 0.8,
                        height: pageFormat.height * 0.8,
                        // color: PdfColors.red,
                        child: pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.end,
                          children: [
                            pw.Container(
                              height: pageFormat.height * 0.8,
                              // color: PdfColors.amber,
                              child: pw.Column(
                                mainAxisAlignment: pw.MainAxisAlignment.end,
                                children: [
                                  VerticalText(
                                    data.presenterName,
                                    style: pw.TextStyle(
                                      fontSize:
                                          data.presenter.length < 10 ? 20 : 15,
                                      font: ttf,
                                    ),
                                  ),
                                  pw.SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                            pw.SizedBox(
                              width: 20,
                            ),
                            pw.Container(
                              height: pageFormat.height * 0.8,
                              // color: PdfColors.amber,
                              child: pw.Column(
                                children: [
                                  pw.SizedBox(
                                    height: 90,
                                  ),
                                  VerticalText(
                                    data.presenter,
                                    style: pw.TextStyle(
                                      fontSize:
                                          data.presenter.length < 10 ? 25 : 15,
                                      font: ttf,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            pw.SizedBox(
                              width: 20,
                            ),
                            pw.Container(
                              height: pageFormat.height * 0.8,
                              // color: PdfColors.amber,
                              child: pw.Column(
                                children: [
                                  pw.SizedBox(
                                    height: 90,
                                  ),
                                  VerticalText(
                                    data.date,
                                    style:
                                        pw.TextStyle(fontSize: 20, font: ttf),
                                  ),
                                ],
                              ),
                            ),
                            pw.SizedBox(width: 10),
                            pw.Container(
                                padding: pw.EdgeInsets.only(
                                  top: 20,
                                  left: 10,
                                  right: 10,
                                  bottom: 20,
                                ),
                                height: pageFormat.height * 0.8,
                                width: pageFormat.width * 0.4,
                                // color: PdfColors.yellow,
                                child: pw.Row(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.center,
                                  children: [
                                    for (final lines in desc)
                                      pw.Column(
                                        // mainAxisAlignment:
                                        //     pw.MainAxisAlignment.end,
                                        children: [
                                          pw.SizedBox(
                                            height: data.description.length < 75
                                                ? 80
                                                : 60,
                                          ),
                                          VerticalText(
                                            lines,
                                            style: pw.TextStyle(
                                              font: ttf,
                                              fontSize:
                                                  data.description.length < 75
                                                      ? 28
                                                      : 18,
                                              letterSpacing: 4,
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                )),
                            pw.SizedBox(width: 30),
                            pw.Container(
                              // color: PdfColors.blue,
                              child: pw.Column(
                                mainAxisAlignment: pw.MainAxisAlignment.end,
                                children: [
                                  VerticalText(
                                    data.recipientName + '殿',
                                    style: pw.TextStyle(
                                      font: ttf,
                                      fontSize: 40,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            pw.SizedBox(width: 10),
                            pw.Container(
                              // color: PdfColors.amber,
                              child: pw.Center(
                                child: VerticalText(
                                  data.awardTitle,
                                  style: pw.TextStyle(fontSize: 70, font: ttf),
                                ),
                              ),
                            ),
                            pw.SizedBox(width: 30),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      );
    } else {
      pdf.addPage(
        pw.Page(
          pageFormat: pageFormat,
          build: (context) {
            return pw.Stack(
              children: [
                pw.Positioned.fill(
                  child: pw.Image(image),
                ),
                pw.Center(
                  child: pw.Column(
                    // mainAxisSize: pw.MainAxisSize.min,
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Container(
                        width: pageFormat.width * 0.8,
                        height: pageFormat.height * 0.8,
                        // color: PdfColors.red,
                        child: pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          children: [
                            pw.SizedBox(height: 30),
                            pw.Container(
                              // color: PdfColors.amber,
                              child: pw.Center(
                                child: pw.Text(
                                  data.awardTitle,
                                  style: pw.TextStyle(
                                    font: ttf,
                                    fontSize: 70,
                                  ),
                                ),
                              ),
                            ),
                            pw.Container(
                              padding: pw.EdgeInsets.only(right: 50),
                              // color: PdfColors.blue,
                              child: pw.Row(
                                mainAxisAlignment: pw.MainAxisAlignment.end,
                                children: [
                                  pw.Text(
                                    data.recipientName + '殿',
                                    style: pw.TextStyle(
                                      font: ttf,
                                      fontSize: 40,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            pw.SizedBox(height: 5),
                            pw.Container(
                              padding: pw.EdgeInsets.only(
                                top: 10,
                                left: 20,
                                right: 20,
                                bottom: 10,
                              ),
                              height: pageFormat.height * 0.4,
                              // color: PdfColors.yellow,
                              child: pw.Center(
                                child: pw.Text(
                                  data.description,
                                  style: pw.TextStyle(
                                    font: ttf,
                                    fontSize:
                                        data.description.length < 75 ? 30 : 25,
                                  ),
                                ),
                              ),
                            ),
                            pw.Container(
                              padding: pw.EdgeInsets.all(10),
                              // color: PdfColors.blue,
                              child: pw.Row(
                                children: [
                                  pw.SizedBox(width: 20),
                                  pw.Text(
                                    data.date,
                                    style: pw.TextStyle(
                                      font: ttf,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            pw.Container(
                              padding: pw.EdgeInsets.all(5),
                              // color: PdfColors.blue,
                              child: pw.Row(
                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                children: [
                                  pw.SizedBox(
                                    width: 20,
                                  ),
                                  pw.Text(
                                    data.presenter,
                                    style: pw.TextStyle(
                                      font: ttf,
                                      fontSize: 25,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            pw.Container(
                              padding: pw.EdgeInsets.all(5),
                              // color: PdfColors.blue,
                              child: pw.Row(
                                mainAxisAlignment: pw.MainAxisAlignment.end,
                                children: [
                                  pw.Text(
                                    data.presenterName,
                                    style: pw.TextStyle(
                                      font: ttf,
                                      fontSize: 20,
                                    ),
                                  ),
                                  pw.SizedBox(width: 20),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      );
    }

    return pdf.save();
  }

  PdfPageFormat _getPageFormat(String paperSize, String template) {
    PdfPageFormat format;
    switch (paperSize) {
      case 'A3':
        format = PdfPageFormat.a3;
        break;
      case 'A4':
        format = PdfPageFormat.a4;
        break;
      case 'A5':
        format = PdfPageFormat.a5;
        break;
      case 'B4':
        format =
            PdfPageFormat(250.0 * PdfPageFormat.mm, 353.0 * PdfPageFormat.mm);
        break;
      case 'B5':
        format =
            PdfPageFormat(176.0 * PdfPageFormat.mm, 250.0 * PdfPageFormat.mm);
        break;
      default:
        format = PdfPageFormat.a4;
    }

    if (template == 'Template 1') {
      format = format.copyWith(
        width: format.height,
        height: format.width,
        marginLeft: 0,
        marginRight: 0,
        marginTop: 0,
        marginBottom: 0,
      );
    } else {
      format = format.copyWith(
        marginLeft: 0,
        marginRight: 0,
        marginTop: 0,
        marginBottom: 0,
      );
    }

    return format;
  }

  List<String> getLines(String text) {
    List<String> lines = [];
    StringBuffer buffer = StringBuffer();
    int chunkSize = text.length < 75 ? 8 : 14;

    for (int i = 0; i < text.length; i++) {
      if (text[i] == '\n') {
        lines.add(buffer.toString());
        buffer.clear();
      } else {
        String char = text[i];
        if (VerticalRotated.map.containsKey(char)) {
          buffer.write(VerticalRotated.map[char]);
        } else {
          buffer.write(char);
        }
        if (buffer.length == chunkSize) {
          lines.add(buffer.toString());
          buffer.clear();
        }
      }
    }

    // 最後に残った文字列を追加
    if (buffer.isNotEmpty) {
      lines.add(buffer.toString());
    }

    return lines.reversed.toList();
  }
}

class VerticalText extends pw.StatelessWidget {
  final String text;
  final pw.TextStyle? style;
  final int charsPerLine;

  VerticalText(this.text, {this.style, this.charsPerLine = 15})
      : assert(charsPerLine > 0, 'charsPerLine must be greater than 0');

  @override
  pw.Widget build(pw.Context context) {
    List<String> lines = [];
    for (int i = 0; i < text.length; i += charsPerLine) {
      lines.add(text.substring(
          i, i + charsPerLine < text.length ? i + charsPerLine : text.length));
    }

    return pw.Column(
      mainAxisSize: pw.MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: lines.map((line) {
        return pw.Column(
          mainAxisSize: pw.MainAxisSize.min,
          children: line.split('').map((char) {
            return pw.Text(
              char,
              style: style,
            );
          }).toList(),
        );
      }).toList(),
    );
  }
}

pw.Widget _rightToLeftText(
    {required String text, required pw.TextStyle? style}) {
  final reversedText = text.split('').reversed.join();
  final List<String> lines = [];
  for (int i = 0; i < reversedText.length; i += 10) {
    lines.add(reversedText.substring(
        i, i + 10 < reversedText.length ? i + 10 : reversedText.length));
  }

  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: lines.map((line) {
      return pw.Column(
        mainAxisSize: pw.MainAxisSize.min,
        children: line.split('').map((char) {
          return pw.Text(
            char,
            style: style,
          );
        }).toList(),
      );
    }).toList(),
  );
}
