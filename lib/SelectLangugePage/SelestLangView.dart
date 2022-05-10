import 'package:flutter/material.dart';
import 'package:save_break_time/Animation/FadeAnimation.dart';
import 'package:save_break_time/Models/Methods.dart';
import 'package:save_break_time/Models/virables.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../localization/language.dart';
import 'SelectLangModel.dart';

class SelectLangView extends StatefulWidget {
  SelectLangView({Key key}) : super(key: key);

  @override
  _SelectLangViewState createState() => _SelectLangViewState();
}

class _SelectLangViewState extends State<SelectLangView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//main continer-------------------------------
        body: continerBackgroundImage(
      welcomBacgroundImage,
      Column(
        mainAxisSize: MainAxisSize.max,
        children: [
//image----------------------------------------
          padding(
              40.0,
              40.0,
              60.0,
              Image(
                image: AssetImage("$logoPath"),
              )),
          SizedBox(
            height: 80.h,
          ),
//welcom text----------------------------------------
          FadeAnimation(
            8,
            text(
              context,
              'We help you to order your needs from the library or cafeteria without going to it and waiting in queues',
              14.0,
              deepWhite,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 60.h,
          ),
//lang text----------------------------------------
          FadeAnimation(
            10,
            (text(
              context,
              'choose the language',
              13.0,
              deepWhite,
              fontWeight: FontWeight.w700,
            )),
          ),
          SizedBox(
            height: 15.h,
          ),
//lang buttom----------------------------------------
          FadeAnimation(
            10,
            container(
                50.0,
                double.infinity,
                30.0,
                30.0,
                selectLangButtom(context, (Language lang) {
                  changeLanguage(lang, context);
                }, icon: Icons.arrow_drop_down),
                deepYallow,
                bottomLeft: 15,
                bottomRight: 15,
                topLeft: 15,
                topRight: 15),
          )
        ],
      ),
    ));
  }
}
