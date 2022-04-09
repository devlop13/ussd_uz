import 'package:flutter/material.dart';
import 'package:ussd_uz/main.dart';
import 'package:ussd_uz/pages/info_page.dart';
import 'package:ussd_uz/pages/infotab_page.dart';


class MainList extends StatelessWidget {
  const MainList({
    Key? key,
    required this.data,
    required this.mainServices,
    required this.imageName,
    required this.bgColor,
    required this.imageSize,
    required this.isUz,
    required this.iconColor
  }) : super(key: key);

  final Map<String, dynamic> data;
  final List<dynamic> mainServices;
  final String imageName;
  final Color bgColor;
  final String imageSize;
  final Color iconColor;
  final bool isUz;


  @override
  Widget build(BuildContext context) {

    return Material(
      color: Color(0xFF323232),
      child: InkWell(
        // splashColor: Colors.white,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => (data['tab_view'] == "1")
                  ? InfotabPage(
                      bgColor: bgColor,
                      imageName: imageName,
                      imageSize: imageSize,
                      mainServices: mainServices,
                      iconColor:iconColor,
                      isUz:isUz
                    )
                  : InfoPage(
                      bgColor: bgColor,
                      imageName: imageName,
                      imageSize: imageSize,
                      mainServices: mainServices,
                      data: data,
                      iconColor:iconColor,
                      isUz:isUz
              ),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.only(top: 7, bottom: 7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                  children: [
                const Text(
                  '  \u2022 ',
                  style: TextStyle(color: Color(0xFFcccccc), fontSize: 32),
                ),
                Container(
                  width: 185,
                  child: Text(
                    (isUz)?data['name']:data['name_ru'],
                    style: TextStyle(color: Color(0xFFcccccc), fontSize: 14),
                  ),
                ),
              ]),
              Container(
                margin: EdgeInsets.only(right: 15),
                child: const Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: Color(0xFFcccccc),
                  size: 17,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
