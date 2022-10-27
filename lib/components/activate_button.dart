import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ussd_uz/send_ussd_request.dart';

class ActivateButton extends StatelessWidget {
  ActivateButton({
    Key? key,
    required this.text,
    required this.bgColor,
    required this.code,
    required this.textColor,
    required this.isUz,
  }) : super(key: key);

  final String text;
  late String textContent = (text.split('#').length==2)?((isUz)?text.split('#')[0]:text.split('#')[1]):text;
  final Color bgColor;
  final String code;
  final Color textColor;
  final bool isUz;

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.only(bottom: 5, top: 10),
      height: 42,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0)),
      child: Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(30.0),
          color: bgColor,
          child: MaterialButton(
            minWidth: (MediaQuery.of(context).size.width * 5) / 6,
            onPressed: () {
              sendUssdMessage(code);
            },
            
            // Active button for main page
            child: Text(
                textContent.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.0,
                color: textColor,
              ),
            ),
          )),
    );
  }
}
