import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:print_certificate_flutter/const.dart';
import 'package:provider/provider.dart';
import 'certificate_data.dart';
import 'templates.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CertificateData(),
      child: MaterialApp(
        title: 'Certificate Generator',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'NotoSansJP-VariableFont_wght',
        ),
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final focusNode = FocusNode();
    return Focus(
      focusNode: focusNode,
      child: GestureDetector(
        onTap: focusNode.requestFocus,
        child: Scaffold(
          backgroundColor: mainColor,
          appBar: AppBar(
            backgroundColor: subColor,
            foregroundColor: white,
            title: Text(
              '必要事項入力',
            ),
          ),
          body: SafeArea(
            child: CertificateForm(),
          ),
        ),
      ),
    );
  }
}

class CertificateForm extends StatefulWidget {
  @override
  _CertificateFormState createState() => _CertificateFormState();
}

class _CertificateFormState extends State<CertificateForm> {
  final _formKey = GlobalKey<FormState>();
  String certificateType = '賞状';
  TextEditingController nameTextController = TextEditingController();
  TextEditingController contentTextController = TextEditingController();
  TextEditingController dateTextController = TextEditingController();
  TextEditingController presenterTextController = TextEditingController();
  TextEditingController presenterNameTextController = TextEditingController();
  String _paperSize = 'A4';

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: size.width * 0.1,
                              height: size.width * 0.1,
                              // color: white,
                              child: FittedBox(
                                fit: BoxFit.cover,
                                child: GestureDetector(
                                  onTap: () {
                                    try {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return Dialog(
                                              shape: BeveledRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(0)),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      width: size.width * 0.9,
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            width: size.width *
                                                                0.9,
                                                            height:
                                                                size.height *
                                                                    0.9,
                                                            color: white,
                                                            child: Column(
                                                              children: [
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color:
                                                                            mainColor,
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                        border:
                                                                            Border.all(
                                                                          color:
                                                                              subColor,
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          '賞状の作成方法',
                                                                          style:
                                                                              TextStyle(fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 8,
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color:
                                                                            mainColor,
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                          10,
                                                                        ),
                                                                        border:
                                                                            Border.all(
                                                                          color:
                                                                              subColor,
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Expanded(
                                                                            flex:
                                                                                3,
                                                                            child:
                                                                                Container(
                                                                              width: 30,
                                                                              height: 30,
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: FittedBox(
                                                                                  fit: BoxFit.fitHeight,
                                                                                  child: Center(
                                                                                    child: Image.asset(
                                                                                      'assets/賞状縦向きテンプレート.png',
                                                                                      scale: 10,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            flex:
                                                                                4,
                                                                            child: Container(
                                                                                width: size.width * 0.8,
                                                                                child: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.all(2.0),
                                                                                      child: Text('①賞状の種類 : 賞状、表彰状、感謝状の3種類から選べます。'),
                                                                                    ),
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.all(2.0),
                                                                                      child: Text('②送りたい方の名前 : 送りたい方の名前を記入してください。'),
                                                                                    ),
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.all(2.0),
                                                                                      child: Text('③本文の内容 : 50文字以内で文章を記入してください。'),
                                                                                    ),
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.all(2.0),
                                                                                      child: Text(
                                                                                        '※改行やスペースを入れ過ぎるとデザインが崩れる恐れがあります。',
                                                                                        style: TextStyle(color: Colors.red),
                                                                                      ),
                                                                                    ),
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.all(2.0),
                                                                                      child: Text('④日付 : 漢数字で入力することをお勧めします。'),
                                                                                    ),
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.all(2.0),
                                                                                      child: Text('⑤送り主の名前１ : 送り主の名前を記入してください。(会社名など)'),
                                                                                    ),
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.all(2.0),
                                                                                      child: Text('⑥送り主の名前２ : 送り主の名前を記入してください。(役職など)'),
                                                                                    ),
                                                                                  ],
                                                                                )),
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
                                                            width: size.width *
                                                                0.9,
                                                            height:
                                                                size.height *
                                                                    0.4,
                                                            color: white,
                                                            child: Column(
                                                              children: [
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color:
                                                                            mainColor,
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                        border:
                                                                            Border.all(
                                                                          color:
                                                                              subColor,
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          '賞状の完成イメージ',
                                                                          style:
                                                                              TextStyle(fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 2,
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color:
                                                                            mainColor,
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                        border:
                                                                            Border.all(
                                                                          color:
                                                                              subColor,
                                                                        ),
                                                                      ),
                                                                      child: Row(
                                                                          children: [
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Container(
                                                                                child: Center(
                                                                                  child: Image.asset(
                                                                                    'assets/賞状縦向き.png',
                                                                                    scale: 10,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Container(
                                                                                child: Center(
                                                                                  child: Padding(
                                                                                    padding: const EdgeInsets.all(3.0),
                                                                                    child: Image.asset(
                                                                                      'assets/賞状横向き.png',
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ]),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          });
                                    } catch (e) {
                                      print(e);
                                    }
                                  },
                                  child: Icon(
                                    Icons.help,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: size.width * 0.3,
                                    height: size.height * 0.05,
                                    child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text('※賞状の種類')),
                                  ),
                                ],
                              ),
                              Container(
                                width: size.width,
                                color: white.withOpacity(0.5),
                                height: size.height * 0.1,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Radio(
                                                activeColor: subColor,
                                                value: '賞状',
                                                onChanged: (value) {
                                                  setState(() {
                                                    certificateType = value!;
                                                  });
                                                },
                                                groupValue: certificateType,
                                              ),
                                              Text(
                                                '賞状',
                                                style: TextStyle(fontSize: 20),
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
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Radio(
                                                activeColor: subColor,
                                                value: '表彰状',
                                                onChanged: (value) {
                                                  setState(() {
                                                    certificateType = value!;
                                                  });
                                                },
                                                groupValue: certificateType,
                                              ),
                                              Text(
                                                '表彰状',
                                                style: TextStyle(fontSize: 20),
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
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Radio(
                                                activeColor: subColor,
                                                value: '感謝状',
                                                onChanged: (value) {
                                                  setState(() {
                                                    certificateType = value!;
                                                  });
                                                },
                                                groupValue: certificateType,
                                              ),
                                              Text(
                                                '感謝状',
                                                style: TextStyle(fontSize: 20),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: size.width * 0.3,
                                    height: size.height * 0.05,
                                    child: FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text('※送りたい方の名前'),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                width: size.width,
                                color: white.withOpacity(0.5),
                                height: size.height * 0.1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: TextField(
                                      controller: nameTextController,
                                      maxLength: 7,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: white,
                                        hintText: '山田　太郎',
                                        suffixIconColor: black,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: grey),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: grey),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: size.width * 0.3,
                                    height: size.height * 0.05,
                                    child: FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text('※本文の内容(150文字)'),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                width: size.width,
                                color: white.withOpacity(0.5),
                                height: size.height * 0.25,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: TextField(
                                      controller: contentTextController,
                                      maxLength: 150,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: 7,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: white,
                                        hintText: '※最大150文字まで',
                                        suffixIconColor: black,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: grey),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: grey),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: size.width * 0.3,
                                    height: size.height * 0.05,
                                    child: FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text('※日付(漢字がオススメ)'),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                width: size.width,
                                color: white.withOpacity(0.5),
                                height: size.height * 0.1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: TextField(
                                      controller: dateTextController,
                                      maxLength: 12,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: white,
                                        hintText: '令和〇年〇月〇日',
                                        suffixIconColor: black,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: grey),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: grey),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: size.width * 0.3,
                                    height: size.height * 0.05,
                                    child: FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text('※送り主の名前①'),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                width: size.width,
                                color: white.withOpacity(0.5),
                                height: size.height * 0.1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: TextField(
                                      controller: presenterTextController,
                                      maxLength: 15,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: white,
                                        hintText: '株式会社〇〇',
                                        suffixIconColor: black,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: grey),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: grey),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: size.width * 0.3,
                                    height: size.height * 0.05,
                                    child: FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text('※送り主の名前②'),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                width: size.width,
                                color: white.withOpacity(0.5),
                                height: size.height * 0.1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: TextField(
                                      controller: presenterNameTextController,
                                      maxLength: 15,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: white,
                                        hintText: '代表取締役〇〇',
                                        suffixIconColor: black,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: grey),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: grey),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: size.width * 0.3,
                                    height: size.height * 0.05,
                                    child: FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text('※用紙のサイズ'),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                width: size.width,
                                color: white.withOpacity(0.5),
                                height: size.height * 0.1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: DropdownButtonFormField<String>(
                                      value: _paperSize,
                                      decoration: InputDecoration(
                                          labelText: 'Paper Size'),
                                      items: ['A3', 'A4', 'A5', 'B4', 'B5']
                                          .map((size) => DropdownMenuItem(
                                                value: size,
                                                child: Text(size),
                                              ))
                                          .toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          _paperSize = value!;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: subColor,
                        ),
                        onPressed: () {
                          if (nameTextController.text == "" ||
                              contentTextController.text == "" ||
                              presenterTextController.text == "" ||
                              presenterNameTextController.text == "") {
                            Fluttertoast.showToast(msg: '空欄の項目があります');
                            return;
                          }
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            Provider.of<CertificateData>(context, listen: false)
                                .updateData(
                              name: nameTextController.text,
                              title: certificateType,
                              desc: contentTextController.text,
                              date: dateTextController.text,
                              presenter: presenterTextController.text,
                              paperSize: _paperSize,
                              presenterName: presenterNameTextController.text,
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      TemplateSelectionScreen()),
                            );
                          }
                        },
                        child: Text(
                          '決定',
                          style: TextStyle(
                            color: white,
                          ),
                        ),
                      ),
                      SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
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
    );
  }
}

String getAdBannerUnitId() {
  String bannerUnitId = "";
  if (Platform.isAndroid) {
    // Android のとき
    bannerUnitId = kDebugMode
        ? "ca-app-pub-3940256099942544/6300978111" // Androidのデモ用バナー広告ID
        : "ca-app-pub-8594832520315352/4474224488";
  } else if (Platform.isIOS) {
    // iOSのとき
    bannerUnitId = kDebugMode
        ? "ca-app-pub-3940256099942544/2934735716" // iOSのデモ用バナー広告ID
        : "ca-app-pub-8594832520315352/4474224488";
  }
  return bannerUnitId;
}

Future loadBanner() async {
  final bannerId = getAdBannerUnitId();

  BannerAd myBanner = BannerAd(
      adUnitId: bannerId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: const BannerAdListener());
  await myBanner.load();
  return myBanner;
}
