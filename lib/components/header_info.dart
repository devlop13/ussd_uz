import 'package:flutter/material.dart';
import 'package:ussd_uz/pages/home_page.dart';

import '../pages/setting_page.dart';

class HeaderInfo extends StatelessWidget {
  const HeaderInfo({
    Key? key,
    required this.imageSize,
    required this.imageName,
    required this.bgColor,
    required this.iconColor,
  }) : super(key: key);

  final String imageSize;
  final String imageName;
  final Color bgColor;
  final Color iconColor;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 20),
            child: Image.asset(
              imageName,
              height: double.parse(imageSize),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            color: bgColor,
            width: double.infinity,
            child: Column(
              children: [
                IconButton(
                  icon: Icon(Icons.home_outlined,color: iconColor,),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()),
                        (route) => false);
                  },
                  color: Colors.white,
                  iconSize: 55,
                  padding: EdgeInsets.only(top: 37),
                ),
                 Divider(
                  height: 18,
                  color: (iconColor==Color(0xff16161e))?Color(0xFFa46c00):iconColor,
                  thickness: 2.4,
                  indent: 17,
                  endIndent: 17,
                ),
                IconButton(
                  icon: Icon(Icons.format_list_bulleted,color: iconColor,),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Colors.white,
                  iconSize: 58,
                  padding: EdgeInsets.only(top: 0),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
