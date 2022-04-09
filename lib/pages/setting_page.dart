import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:ussd_uz/main.dart';
import 'package:ussd_uz/pages/home_page.dart';

enum SingingCharacter { ru, uz }

SingingCharacter _lanCharacter = SingingCharacter.uz;

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key,required this.isUz,}) : super(key: key);

  final bool isUz;

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {

    _lanCharacter = (widget.isUz)?SingingCharacter.uz:SingingCharacter.ru;

    return Scaffold(
      appBar: AppBar(
        title: Text((widget.isUz)?'Sozlash':'Настройки'),
        backgroundColor: const Color(0xFF212121),
      ),
      body: Stack(
        children: [
          Image(
            image: const AssetImage('assets/images/png/fon_dot2.png'),
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
            color: Colors.black.withOpacity(0.03),
          ),
          Column(
            children: [
               ListTile(
                title: Text(
                  (widget.isUz)?'Asosiy':'Основные',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(
                height: 0,
                thickness: 1,
                color: Color(0xFFd5d5d5),
              ),
              ListTile(
                onTap: () {
                  showGeneralDialog(
                      context: context,
                      barrierDismissible: true,
                      barrierLabel: MaterialLocalizations.of(context)
                          .modalBarrierDismissLabel,
                      barrierColor: Colors.black45,
                      transitionDuration: const Duration(milliseconds: 200),
                      pageBuilder: (BuildContext buildContext,
                          Animation animation, Animation secondaryAnimation) {
                        return Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width - 10,
                            height: 280,
                            padding: const EdgeInsets.all(20),
                            color: Colors.white,
                            child: Material(
                              color: Colors.white,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    (widget.isUz)?'Tilni O\'zagrtirish':'Изменить языка',
                                    style: const TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                 RadioButtons(isUz: widget.isUz,)
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                },
                title: Text(
                  (widget.isUz)?'Tilni O\'zagrtirish':'Изменить языка',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(
                height: 0,
                thickness: 1,
                color: Color(0xFFd5d5d5),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutUs(isUz:widget.isUz)),
                  );
                },
                title: Text(
                  (widget.isUz)?'Biz Haqimizda':'О Нас',
                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(
                height: 0,
                thickness: 1,
                color: const Color(0xFFd5d5d5),
              ),
              ListTile(
                onTap: () {
                  Share.share('''Mazkur Ussd Uzbekistan ilovasi mijozlarga qulaylik yaratish maqsadida ishlab chiqilgan bo'lib, Ilova Qonunchilikka asosan sizning shaxsiy ma'lumotlaringizni yig'ish imkoniyati, raqamingizdagi har qanday moliyaviy va boshqa operatsiyalarni amalga oshirish huquqiga ega emas! Ussd uzbekistan ilovasi 2017.06.13 sanasidan beri mijozlar tomonidan foydalanib kelinmoqda va xozirda Google Play va IOS platformalarida jami 60000 ga yaqin mijozlar tomonidan foydalanib kelinmoqda. Ilova haqidagi fikr va mulohazalaringizni kutib qolamiz. Sizning taklif va tanqidlaringgiz biz uchun muhim!\n Приложение USSD Uzbekistan создано для удобства клиентов. Согласно законодательства данное приложение не имеет прав собирать ваши личные данные, проводить какие-либо финансовые или другие операции по вашему мобильному телефону. Приложение Ussd Uzbekistan пользуется большим спросом среди абонентов с 13 июня 2017 года и в данное время на платформах Google и IOS пользователей около 60 000 тысяч человек. Ждём ваших предложений. Все ваши отзывы важны для нас!\n
https://play.google.com/store/apps/details?id=uz.mobileprovider''');
                },
                title: Text(
                  (widget.isUz)?'Ulashish':'Поделиться',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(
                height: 0,
                thickness: 1,
                color: Color(0xFFd5d5d5),
              )
            ],
          )
        ],
      ),
    );
  }
}

class RadioButtons extends StatefulWidget {
  const RadioButtons({Key? key,required this.isUz,}) : super(key: key);

  final bool isUz;

  @override
  _RadioButtonsState createState() => _RadioButtonsState();
}

class _RadioButtonsState extends State<RadioButtons> {
  bool isVisible = false;
  final double hTops = 40;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(
        // dense: true,
        visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
        contentPadding: const EdgeInsets.only(left: 60, top: 10, bottom: 0),
        title: const Text(
          'O\'zbekcha',
          style: TextStyle(fontSize: 18),
        ),
        leading: Radio<SingingCharacter>(
          activeColor: Colors.black,
          hoverColor: Colors.white,
          value: SingingCharacter.uz,
          groupValue: _lanCharacter,
          onChanged: (SingingCharacter? value) {
            setState(() {
              _lanCharacter = SingingCharacter.uz;
              isVisible = true;
            });
          },
        ),
      ),
      ListTile(
        // dense: true,
        visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
        contentPadding: const EdgeInsets.only(left: 60, top: 0),
        minVerticalPadding: 0,
        title: const Text(
          'Русский',
          style: const TextStyle(fontSize: 18),
        ),
        leading: Radio<SingingCharacter>(
          activeColor: Colors.black,
          value: SingingCharacter.ru,
          groupValue: _lanCharacter,
          onChanged: (SingingCharacter? value) {
            setState(() {
              _lanCharacter = SingingCharacter.ru;
              isVisible = true;

            });
          },
        ),
      ),
      Visibility(
        child: Text(
          (widget.isUz)?'Tilni o\'zgartirsangiz, dastur qayta\n                  yuklanadi':'Если вы измените язык, программа\n                  перезагрузится',
          style: TextStyle(
            color: Colors.red,
          ),
        ),
        visible: isVisible,
      ),
      Container(
        alignment: Alignment.bottomRight,
        margin: EdgeInsets.only(top: hTops),
        child: TextButton(
          onPressed: () {
            if(isVisible){
              ussdBox.put('c_lang', _lanCharacter.name);
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const HomePage()), (route) => false);
            }else{
              Navigator.pop(context);
            }
          },
          child: const Text(
            'Saqlash',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
      ),
    ]);
  }
}

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key,required this.isUz}) : super(key: key);

  final bool isUz;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sozlash'),
        backgroundColor: const Color(0xFF212121),
      ),
      body: Stack(
        children: [
          new Image(
            image: const AssetImage('assets/images/png/fon_dot2.png'),
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
            color: Colors.black.withOpacity(0.03),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            child: Text(
    (isUz)?'''Mazkur Ussd Uzbekistan ilovasi mijozlarga qulaylik yaratish maqsadida ishlab chiqilgan bo'lib, Ilova Qonunchilikka asosan sizning shaxsiy ma'lumotlaringizni yig'ish imkoniyati, raqamingizdagi har qanday moliyaviy va boshqa operatsiyalarni amalga oshirish huquqiga ega emas! Ussd uzbekistan ilovasi 2017.06.13 sanasidan beri mijozlar tomonidan foydalanib kelinmoqda va xozirda Google Play va IOS platformalarida jami 60000 ga yaqin mijozlar tomonidan foydalanib kelinmoqda. Ilova haqidagi fikr va mulohazalaringizni kutib qolamiz. Sizning taklif va tanqidlaringgiz biz uchun muhim!''':'''Приложение USSD Uzbekistan создано для удобства клиентов. Согласно законодательства данное приложение не имеет прав собирать ваши личные данные, проводить какие-либо финансовые или другие операции по вашему мобильному телефону. Приложение Ussd Uzbekistan пользуется большим спросом среди абонентов с 13 июня 2017 года и в данное время на платформах Google и IOS пользователей около 60 000 тысяч человек. Ждём ваших предложений. Все ваши отзывы важны для нас!''',
              style: const TextStyle(fontSize: 18, color: Color(0xFF212121)),
            ),
          )
        ],
      ),
    );
  }
}
