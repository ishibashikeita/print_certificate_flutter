import 'package:flutter/material.dart';

class CertificateData with ChangeNotifier {
  String recipientName = '';
  String awardTitle = '';
  String description = '';
  String date = '';
  String presenter = '';
  String presenterName = '';
  String paperSize = 'A4';

  void updateData({
    required String name,
    required String title,
    required String desc,
    required String date,
    required String presenter,
    required String paperSize,
    required String presenterName,
  }) {
    recipientName = name;
    awardTitle = title;
    description = desc;
    this.presenterName = presenterName;
    this.presenter = presenter;
    this.date = date;
    this.paperSize = paperSize;
    notifyListeners();
  }
}
