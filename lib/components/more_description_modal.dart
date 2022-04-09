import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';



MoreDescriptionModal(context, i, service,isUz) => showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black45,
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (BuildContext buildContext, Animation animation,
        Animation secondaryAnimation) {
      return Center(
        child: Container(
          width: MediaQuery.of(context).size.width - 30,
          height: MediaQuery.of(context).size.height - 50,
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.only(top: 25),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30), color: Colors.white),
          child: Material(
              color: Colors.white,
              child: Column(children: [
                Container(
                  width: MediaQuery.of(context).size.width - 30,
                  height: MediaQuery.of(context).size.height - 160,
// padding: EdgeInsets.only(bottom: 100),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Html(
                      data: (isUz)?service[i]['full_desc_uz']:service[i]['full_desc_ru'],
                      onLinkTap: (String? url, RenderContext context, Map<String, String> attributes, element) {
                        launch(url!);
                      },
                      shrinkWrap: false,
                      style: {
                        "a":Style(
                          color: Color(0xFFF0000ed)
                        )
                      },
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: const Offset(0, 1.5),
                        spreadRadius: 0.01,
//(x,y)
                        blurRadius: 3.0,
                      ),
                    ],
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFbbbbbb), Color(0xFFdfdfdf)],
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: MaterialButton(
                    elevation: 5,
                    minWidth: (MediaQuery.of(context).size.width * 1) / 2,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 15.0),
                    child: const Text(
                      'OK',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Color(0xFF131313),
                      ),
                    ),
                  ),
                ),
              ])),
        ),
      );
    });