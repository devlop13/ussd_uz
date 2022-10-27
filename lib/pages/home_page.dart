
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ussd_uz/main.dart';
import 'package:ussd_uz/pages/main_page.dart';
import 'dart:convert';

// Home page for entery file to project
class HomePage extends StatefulWidget {
 const  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Expanded(
          flex: 5,
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Color(0xFFffffff),
                ),
                child: Image.asset(
                  'assets/images/png1/fon/3x.png',
                  height: double.infinity,
                  // width: 50,
                  fit: BoxFit.fill,
                  color: Colors.black12.withOpacity(0.09999),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 55),
                  child: GestureDetector(
                    onDoubleTap: (){
                      showGeneralDialog(
                          context: context,
                          barrierDismissible: true,
                          barrierLabel: MaterialLocalizations.of(context)
                              .modalBarrierDismissLabel,
                          barrierColor: Colors.black45,
                          transitionDuration: const Duration(milliseconds: 200),
                          pageBuilder: (BuildContext buildContext,
                              Animation animation, Animation secondaryAnimation) {
                            return Container(
                              margin: EdgeInsets.fromLTRB(10, 60, 10, 60),
                              child:Material(
                                color: Colors.white,
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(10, 60, 10, 60),
                                  child: Column(
                                    children: [
                                      Text("version: ${ussdBox.get('NEXT_VERSION')}"),
                                    GestureDetector(child:Text("token: ${ussdBox.get('reg_token')}"),onLongPress: (){Clipboard.setData(ClipboardData(text: ussdBox.get('reg_token').toString()));},)
                                    ]
                                  ),
                                ),
                              ),
                            );
                          });

                    },
                    child: Image.asset(
                        'assets/images/png1/logo/3x.png',
                        height: 210,
                        // width: 100,
                      ),
                  ),

                ),
              )
            ],
          ),
        ),
        Expanded(
          flex: 8,
          child: Container(
            color: const Color(0xFFf7f7f7),
            width: double.infinity,
            child: Column(
              children: [
                //Ucell-------
                Expanded(
                  flex: 1,
                  child: Card(
                    elevation: 1.5,
                    margin: const EdgeInsets.only(
                        left: 16, right: 16, top: 22, bottom: 19),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: SizedBox(
                      child: InkWell(
                        splashColor: const Color(0xFFe5e5e5),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainPage(
                                bgColor: const Color(0xFF9703db),
                                imageName: 'assets/images/png1/logo_com/ucell 3x.png',
                                imageSize: '52',
                                mainMenu: jsonDecode(ussdBox.get('2')),
                                iconColor:Colors.white
                              ),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 14),
                              child: Image.asset(
                                'assets/images/png1/logo_com/ucell 3x.png',
                                height: 26,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Ucell',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900),
                                ),
                                Text(
                                  'Ucell.uz',
                                  style: TextStyle(
                                    fontSize: 12.2,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.purple.withOpacity(0.3),
                                    spreadRadius: 5,
                                    blurRadius: 12,
                                    offset: const Offset(
                                        0, 5), // changes position of shadow
                                  ),
                                ],
                              ),
                              margin: const EdgeInsets.only(right: 20),
                              child: Image.asset(
                                'assets/images/png1/arrowsno/3x/Group 1.png',
                                height: 36,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                //MobiUz-------
                Expanded(
                  flex: 1,
                  child: Card(
                    elevation: 1.5,
                    margin: const EdgeInsets.only(
                        left: 16, right: 16, top: 18, bottom: 23),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: SizedBox(
                      child: InkWell(
                        splashColor: const Color(0xFFe5e5e5),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainPage(
                                bgColor: const Color(0xFFe30016),
                                imageName: 'assets/images/png1/logo_com/mobiuz 3x.png',
                                imageSize: '90',
                                mainMenu:  jsonDecode(ussdBox.get('1')),
                                  iconColor:Colors.white
                              ),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 14),
                              child: Image.asset(
                                'assets/images/png1/logo_com/mobiuz 3x.png',
                                height: 33,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Mobiuz',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900),
                                ),
                                Text(
                                  'mobi.uz',
                                  style: TextStyle(
                                    fontSize: 12.2,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.red.withOpacity(0.3),
                                    spreadRadius: 5,
                                    blurRadius: 12,
                                    offset: const Offset(
                                        0, 5), // changes position of shadow
                                  ),
                                ],
                              ),
                              margin: const EdgeInsets.only(right: 20),
                              child: Image.asset(
                                'assets/images/png1/arrowsno/3x/Group 2.png',
                                height: 36,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                //Uztelecom-------
                Expanded(
                  flex: 1,
                  child: Card(
                    elevation: 1.5,
                    margin: const EdgeInsets.only(
                        left: 16, right: 16, top: 15, bottom: 26),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: SizedBox(
                      child: InkWell(
                        splashColor: const Color(0xFFe5e5e5),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainPage(
                                bgColor: const Color(0xFF0093dd),
                                imageName: 'assets/images/png1/logo_com/uztelecom 3x.png',
                                imageSize: '35',
                                mainMenu:  jsonDecode(ussdBox.get('4')),
                                  iconColor:Colors.white
                              ),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 14),
                              child: Image.asset(
                                'assets/images/png1/logo_com/uztelecom 3x.png',
                                height: 16,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Uzmobile',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900),
                                ),
                                Text(
                                  'uztelecom.uz',
                                  style: TextStyle(
                                    fontSize: 12.2,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue.withOpacity(0.3),
                                    spreadRadius: 5,
                                    blurRadius: 12,
                                    offset: const Offset(
                                        0, 5), // changes position of shadow
                                  ),
                                ],
                              ),
                              margin: const EdgeInsets.only(right: 20),
                              child: Image.asset(
                                'assets/images/png1/arrowsno/3x/Group 4.png',
                                height: 36,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                //for Beeline company-------
                Expanded(
                  flex: 1,
                  child: Card(
                    elevation: 2,
                    margin: const EdgeInsets.only(
                        left: 16, right: 16, top: 9, bottom: 32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: SizedBox(
                      child: InkWell(
                        splashColor: const Color(0xFFe5e5e5),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainPage(
                                bgColor: const Color(0xFFfec700),
                                imageName: 'assets/images/png/beeline_2.png',
                                imageSize: '110',
                                mainMenu:  jsonDecode(ussdBox.get('3')),
                                  iconColor:Color(0xFFF16161e)
                              ),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 14),
                              child: Image.asset(
                                'assets/images/png/beeline_2.png',
                                height: 34,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Beeline',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900),
                                ),
                                Text(
                                  'beeline.uz',
                                  style: TextStyle(
                                    fontSize: 12.2,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.yellow.withOpacity(0.3),
                                    spreadRadius: 5,
                                    blurRadius: 12,
                                    offset: const Offset(
                                        0, 5), // changes position of shadow
                                  ),
                                ],
                              ),
                              margin: const EdgeInsets.only(right: 20),
                              child: Image.asset(
                                'assets/images/png1/arrowsno/3x/Group 3.png',
                                height: 36,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

