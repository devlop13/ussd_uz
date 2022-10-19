import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ussd_advanced/ussd_advanced.dart';

import 'package:ussd_uz/main.dart';
import 'package:ussd_uz/send_ussd_request.dart';
import '../components/activate_button.dart';
import '../components/header_info.dart';
import '../components/more_description_modal.dart';

List<dynamic> lastList = [];
Function callbackFunc = () {};

class InfoPage extends StatefulWidget {
  const InfoPage({
    Key? key,
    required this.imageName,
    required this.bgColor,
    required this.imageSize,
    required this.mainServices,
    required this.data,
    required this.iconColor,
    required this.isUz,
  }) : super(key: key);

  final String imageName;
  final Color bgColor;
  final String imageSize;
  final List<dynamic> mainServices;
  final Map<String, dynamic> data;
  final Color iconColor;
  final bool isUz;

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage>
    with SingleTickerProviderStateMixin {
  late TabController rightPnlTabController;
  late var services = widget.mainServices;

  @override
  void initState() {
    super.initState();

    rightPnlTabController = TabController(length: 1, vsync: this);
    //Controll1 = rightPnlTabController;
  }

  @override
  void dispose() {
    rightPnlTabController.dispose();
    lastList = [];
    Function callbackFunc = () {};
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Image(
            image: const AssetImage('assets/images/png/newfon4.png'),
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
            color: Colors.black.withOpacity(0.04),
          ),
          Column(
            children: [
              Expanded(
                flex: 1,
                child: HeaderInfo(
                  bgColor: widget.bgColor,
                  imageName: widget.imageName,
                  imageSize: widget.imageSize,
                  iconColor: widget.iconColor,
                ),
              ),
              Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Row(children: [
                        Container(
                          height: 49,
                          padding: const EdgeInsets.only(left: 20, right: 1),
                          color: widget.bgColor,
                          child: GestureDetector(
                            onTap: () {
                              if (lastList.isEmpty) {
                                Navigator.pop(context);
                              } else {
                                callbackFunc();
                                lastList = [];
                              }
                            },
                            child: Icon(
                              Icons.arrow_back,
                              size: 29,
                              color: widget.iconColor,
                            ),
                          ),
                        ),
                        Expanded(
                            child: Container(
                          height: 49,
                          color: widget.bgColor,
                          child: Center(
                            child: Text(
                              (widget.isUz)
                                  ? widget.data['name']
                                  : widget.data['name_ru'],
                              style: TextStyle(color: widget.iconColor),
                            ),
                          ),
                        )),
                      ]),
                      Expanded(
                          child: TabBarView(
                              controller: rightPnlTabController,
                              children: [
                            Page2(
                              services: services,
                              bgColor: widget.bgColor,
                              iconColor: widget.iconColor,
                              isUz: widget.isUz,
                            )
                          ])),
                    ],
                  )),
            ],
          ),
        ],
      ),
    );
  }
}

class Page2 extends StatefulWidget {
  const Page2({
    Key? key,
    required this.services,
    required this.bgColor,
    required this.iconColor,
    required this.isUz,
  }) : super(key: key);

  final List<dynamic> services;
  final Color bgColor;
  final Color iconColor;
  final bool isUz;

  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  late var service = widget.services;
  late List<bool> _isOpen = List.generate(service.length, (index) => false);
  int openIndex = -1;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        textBaseline: TextBaseline.alphabetic,
        mainAxisSize: MainAxisSize.min,
        children: [
          ExpansionPanelList(
            animationDuration: const Duration(milliseconds: 20),
            dividerColor: widget.bgColor,
            expandedHeaderPadding: EdgeInsets.zero,
            elevation: 1,
            expansionCallback: (int i, bool isOpen) {
              setState(() {
                _isOpen[i] = !_isOpen[i];
                if (openIndex != -1 && openIndex != i) {
                  _isOpen[openIndex] = false;
                }
                openIndex = i;
                String a = (service[i]['description'] != "")
                    ? service[i]['description']!.replaceAll("\n", "")
                    : service[i]['description'];
                if (a == "" && service[i]['code'] == "") {
                  lastList = service;
                  service = jsonDecode(ussdBox.get(service[i]['id']));
                  openIndex = -1;
                  _isOpen = List.generate(service.length, (index) => false);

                  callbackFunc = () {
                    setState(() {
                      service = lastList;
                      _isOpen = List.generate(service.length, (index) => false);
                    });
                  };
                } else if (service[i]['code'] != "" &&
                    service[i]['description'] == "" &&
                    service[i]['short_description'] == "") {
                  sendUssdMessage(service[i]['code']);
                  //  UssdAdvanced.sendUssd(code: "*100#");
                }
              });
            },
            children: List.generate(
              service.length,
              (i) {
                String a = (service[i]['description'] != "")
                    ? service[i]['description']!.replaceAll("\n", "")
                    : service[i]['description'];
                if (a != "") {
                  var tableData = {};
                  bool isJson = false;

                  String tableString = (widget.isUz)
                      ? service[i]['short_description'].trim()
                      : service[i]['description'].trim();

                  if (tableString != "") if (tableString[0] == '{' &&
                      tableString[tableString.length - 1] == '}') {
                    tableString = tableString.replaceAll("\n", "");
                    tableString = tableString.replaceAll("\r", "");
                    tableString = tableString.replaceAll("\t", "");

                    try {
                      tableData = jsonDecode(tableString);
                      isJson = true;
                    } on Exception catch (e) {
                      print(
                          "you have some error on: convert json to string in the infotab_page.dart !");
                    }
                  }

                  return ExpansionPanel(
                    backgroundColor: Colors.transparent,
                    isFirst: true,
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return Container(
                        padding: const EdgeInsets.only(left: 6),
                        margin: EdgeInsets.zero,
                        child: Row(
                          textBaseline: TextBaseline.alphabetic,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 4),
                              child: const Text(
                                '\u2022',
                                style: TextStyle(
                                  color: Color(0xFF767374),
                                  fontSize: 30,
                                ),
                              ),
                            ),
                            Container(
                              width: 280,
                              padding: const EdgeInsets.only(
                                  top: 15, bottom: 15, left: 4),
                              child: Text(
                                (widget.isUz)
                                    ? service[i]['name']
                                    : service[i]['name_ru'],
                                style: TextStyle(
                                  color: const Color(0xFF767374),
                                  fontSize: 14,
                                  fontWeight: FontWeight.lerp(
                                      FontWeight.w500, FontWeight.w600, 0.5),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    canTapOnHeader: true,
                    body: Material(
                      color: Colors.transparent,
                      child: Column(children: [
                        Container(
                          padding: const EdgeInsets.only(
                              left: 16, top: 0, bottom: 16, right: 13),
                          child: (!isJson)
                              ? Column(children: [
                                  if (service[i]['news_date'] != "")
                                    Container(
                                      width: double.infinity,
                                      margin: EdgeInsets.only(bottom: 6,top: 2),
                                      child: Text(
                                        service[i]['news_date'],
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            color: Color(0xFF767573),
                                            fontSize: 12.2),
                                      ),
                                    ),
                                  Html(
                                    data: (widget.isUz)
                                        ? service[i]['short_description']
                                        : service[i]['description'],
                                    onLinkTap: (String? url,
                                        RenderContext context,
                                        Map<String, String> attributes,
                                        element) {
                                      launch(url!);
                                    },
                                    shrinkWrap: true,
                                    style: {
                                      "p": Style(
                                        fontSize: const FontSize(12.2),
                                      ),
                                      "li": Style(
                                        fontSize: const FontSize(12.2),
                                      ),
                                      "a": Style(
                                          fontSize: const FontSize(12.2),
                                          color: Colors.black),
                                      "font": Style(
                                        fontSize: const FontSize(12.2),
                                      ),
                                      "*": Style(
                                          fontSize: const FontSize(12.2),
                                          padding: const EdgeInsets.all(0),
                                          margin: const EdgeInsets.all(0)),
                                    },
                                    customRender: {},
                                  ),
                                ])
                              : _DescriptionTable(tableData['data']),
                        ),
                        if (service[i]['activate'] != "" &&
                            service[i]['code'] != "")
                          ActivateButton(
                            text: service[i]['activate'],
                            code: service[i]['code'],
                            bgColor: widget.bgColor,
                            textColor: widget.iconColor,
                            isUz: widget.isUz,
                          ),
                        Container(
                          padding: const EdgeInsets.only(
                              right: 15, bottom: 10, top: 5),
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if (service[i]['full_desc_uz'] != "")
                                  GestureDetector(
                                    child: Text(
                                      (widget.isUz) ? 'Batafsil' : 'Подробно',
                                      textAlign: TextAlign.end,
                                      style: const TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontSize: 15,
                                      ),
                                    ),
                                    onTap: () {
                                      MoreDescriptionModal(
                                          context, i, service, widget.isUz);
                                    },
                                  ),
                                if (service[i]['activate'] != "" &&
                                    service[i]['base_code'] != "" &&
                                    service[i]['code'].trim()[0] == "*")
                                  IconButton(
                                    onPressed: () {
                                      Share.share((widget.isUz)
                                          ? "Kompaniya: ${service[i]['provider']}\nXizmat turi: ${(widget.isUz) ? service[i]['name'] : service[i]['name_ru']}\nFaollashtirish kodi: ${service[i]['code']}\n\n\n https://play.google.com/store/apps/details?id=uz.mobileprovider"
                                          : "Компания: ${service[i]['provider']}\nТип обслуживания: ${(widget.isUz) ? service[i]['name_ru'] : service[i]['name_ru']}\nКод активации: ${service[i]['code']}\n\n\n https://play.google.com/store/apps/details?id=uz.mobileprovider");
                                    },
                                    icon: const Icon(Icons.share_outlined),
                                    iconSize: 22,
                                    visualDensity: const VisualDensity(
                                        vertical: VisualDensity.minimumDensity,
                                        horizontal:
                                            VisualDensity.minimumDensity),
                                  ),
                              ]),
                        )
                      ]),
                    ),
                    isExpanded: _isOpen[i],
                  );
                } else {
                  return _demoExpandList(i, service, widget.isUz);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  _DescriptionTable(descriptions) => Column(
        children: List.generate(descriptions.length, (index) {
          String strval = descriptions[index]['value'].replaceAll(" ", "");
          String strname = descriptions[index]['name'].replaceAll(" ", "");

          int flex1 = 3;
          int flex2 = 2;

          if (strname.length < 19) {
            flex1 = 3;
            flex2 = 7;
          }
          if (strval.length < 15) {
            flex1 = 7;
            flex2 = 2;
          }

          if (strval == "" ||
              strval == "<b><\/b>" ||
              strval == "<b></b>" ||
              strval == "<center><fontsize=6color=#696969><\/font><\/center>") {
            flex1 = 120;
            flex2 = 1;
          } else if (strname == "" ||
              strname == "<b><\/b>" ||
              strname == "<b></b>" ||
              strname ==
                  "<center><fontsize=6color=#696969><\/font><\/center>") {
            flex1 = 1;
            flex2 = 1200;
          }

// print(descriptions[index]['name']+"Valuesi = "+strval);
          return Row(
            textBaseline: TextBaseline.alphabetic,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: flex1,
                child: Html(
                  data: descriptions[index]['name'],
                  style: {
                    "body": Style(
                        padding: const EdgeInsets.all(3),
                        margin: const EdgeInsets.all(0)),
                    "font":
                        Style(fontSize: const FontSize(14), color: Colors.black
                            //   color: Color(0xFF696969)
                            ),
                    "a": Style(color: Colors.black)
                  },
                ),
              ),
              Expanded(
                flex: flex2,
                child: Html(
                  shrinkWrap: true,
                  data: descriptions[index]['value'],
                  style: {
                    "body": Style(
                        textAlign: TextAlign.end,
                        padding: const EdgeInsets.all(0),
                        margin: const EdgeInsets.all(0)),
                    "font": Style(
                      fontSize: const FontSize(14),
                    ),
                    "a": Style(color: Colors.black),
                    "*": Style(textAlign: TextAlign.end)
                  },
                ),
              ),
            ],
          );
        }),
      );

  _demoExpandList(i, service, isUz) => ExpansionPanel(
        isFirst: false,
        backgroundColor: Colors.transparent,
        headerBuilder: (BuildContext context, bool isExpanded) {
          return Container(
            padding: const EdgeInsets.only(
              left: 6,
            ),
            margin: EdgeInsets.zero,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 4),
                  child: const Text(
                    '\u2022',
                    style: TextStyle(
                      color: const Color(0xFF767374),
                      fontSize: 30,
                    ),
                  ),
                ),
                Container(
                  width: 260,
                  padding: const EdgeInsets.only(top: 15, bottom: 15, left: 4),
                  child: Text(
                    (isUz) ? service[i]['name'] : service[i]['name_ru'],
                    style: TextStyle(
                      color: const Color(0xFF767374),
                      fontSize: 14,
                      fontWeight: FontWeight.lerp(
                          FontWeight.w500, FontWeight.w600, 0.5),
                    ),
                  ),
                )
              ],
            ),
          );
        },
        canTapOnHeader: true,
        body: Material(
          color: Colors.white,
          child: Container(
            padding: const EdgeInsets.all(13),
            child: Text(
              service[i]['short_description'],
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
        isExpanded: _isOpen[i],
      );
}
