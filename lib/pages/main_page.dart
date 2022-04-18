// import 'dart:ffi';

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ussd_uz/components/main_list.dart';
import 'package:ussd_uz/pages/setting_page.dart';

import '../main.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    Key? key,
    required this.imageName,
    required this.bgColor,
    required this.imageSize,
    required this.mainMenu,
    required this.iconColor
  }) : super(key: key);

  final String imageName;
  final Color bgColor;
  final String imageSize;
  final List<dynamic> mainMenu;
  final Color iconColor;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isUz = (ussdBox.get('c_lang')=='uz')?true:false;

  @override
  Widget build(BuildContext context) {
    print("dfsd");
    return Scaffold(
      body: Stack(
        children: [
          Image(
            image: const AssetImage('assets/images/png/newfon4.png'),
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
            color: Colors.black.withOpacity(0.03),
          ),
          Column(
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 20),
                        child: Image.asset(
                          widget.imageName,
                          height: double.parse(widget.imageSize),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: widget.bgColor,
                        width: double.infinity,
                        child: Column(
                          children: [
                            IconButton(
                              icon: Icon(Icons.home_outlined,color: widget.iconColor,),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              color: Colors.white,
                              iconSize: 55,
                              padding: EdgeInsets.only(top: 37),
                            ),
                            Divider(
                              height: 18,
                              color: (widget.iconColor==Color(0xff16161e))?Color(0xFFa46c00):widget.iconColor,
                              thickness: 2.4,
                              indent: 17,
                              endIndent: 17,
                            ),
                            IconButton(
                              icon: Icon(Icons.settings,color: widget.iconColor,),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SettingPage(isUz:isUz)
                                  ),
                                );
                              },
                              color: Colors.white,
                              iconSize: 56,
                              padding: EdgeInsets.only(top: 0),
                            ),
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child:Container(
                        height: double.infinity,
                          color: Color(0xFF323232),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                   ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    padding: EdgeInsets.all(0),
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: widget.mainMenu.length,
                                    itemBuilder: (BuildContext context,index){
                                      return  Column(
                                          children: [
                                            MainList(
                                              data: widget.mainMenu[index],
                                              mainServicesId: widget.mainMenu[index]['id'],
                                              bgColor:widget.bgColor,
                                              imageName:widget.imageName,
                                              imageSize:widget.imageSize,
                                              iconColor:widget.iconColor,
                                              isUz:isUz
                                            ),
                                            Divider(
                                              color: Color(0xFF404040),
                                              height: 2,
                                              thickness: 1,
                                            ),
                                          ]
                                      );
                                    },),

                              ],
                            ),
                          ),
                        ),

                    ),

                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(top: 8,left: 7,right: 7),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                            'assets/images/gr_4x/Group-2.png',
                            height: 45,
                          ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Image.asset(
                                'assets/images/gr_4x/Group-3.png',
                                height: 45,
                              ),
                            ),
                            Image.asset(
                              'assets/images/gr_4x/Group-1.png',
                              height: 45,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Image.asset(
                                'assets/images/gr_4x/Group-4.png',
                                height: 45,
                              ),
                            ),
                            Image.asset(
                              'assets/images/gr_4x/Group-5.png',
                              height: 45,
                              color: Color(0xFF4d4d4c),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Image.asset(
                                'assets/images/gr_4x/Frame.png',
                                height: 45,
                              ),
                            ),
                            Image.asset(
                              'assets/images/gr_4x/Frame 2.png',
                              height: 45,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Image.asset(
                                'assets/images/gr_4x/Group.png',
                                height: 45,
                              ),
                            ),
                          ]
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
