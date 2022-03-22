import 'package:flutter/material.dart';
import 'package:save_break_time/Animation/FadeAnimation.dart';
import 'package:save_break_time/Models/virables.dart';
import 'package:save_break_time/SelectLangugePage/SelectLangModel.dart';
import 'package:save_break_time/localization/language.dart';

import 'package:save_break_time/localization/localization_methods.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//================ convert hex colors to rgb colors================
 Color hexToColor(String hexString, {alphaChannel = 'ff'}) {
  return Color(int.parse(hexString.replaceFirst('#', '0x$alphaChannel')));
}

//===============================Text===============================

Widget text(
  context,
  String key,
  double fontSize,
  Color color, {
  family = "DroidKufi",
  align = TextAlign.center,
  double space = 0,
  FontWeight fontWeight = FontWeight.normal,
}) {
  return Text(
    getTranslated(context, '$key'),
    textAlign: align,
    style: TextStyle(
      color: color,
      fontFamily: family,
      fontSize: fontSize.sp,
      letterSpacing: space.sp,
      fontWeight: fontWeight,
    ),
  );
}
Widget textDB(
  context,
  String key,
  double fontSize,
  Color color, {
  family = "DroidKufi",
  align = TextAlign.center,
  double space = 0,
  FontWeight fontWeight = FontWeight.normal,
}) {
  return Text(
  '$key',
    textAlign: align,
    style: TextStyle(
      color: color,
      fontFamily: family,
      fontSize: fontSize.sp,
      letterSpacing: space.sp,
      fontWeight: fontWeight,
    ),
  );
}
divider({
  double thickness = 2,
  double indent = 15,
  double endIndent = 15,
}) {
  return Align(
    alignment: Alignment.topCenter,
    child: VerticalDivider(
      color: Colors.grey[400],
      thickness: thickness,
      indent: indent,
      endIndent: endIndent,
      //width: 12,
    ),
  );
}
//container decoration-------------------------------------------
decoration(
  double bottomLeft,
  double bottomRight,
  double topLeft,
  double topRight, {
  Color color = white,
  double blurRadius = 0.0,
  double spreadRadius = 0.0,
  BoxBorder border,
}) {
  return BoxDecoration(
    color: color,
     border:border,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(topLeft.r),
      topRight: Radius.circular(topRight.r),
      bottomLeft: Radius.circular(bottomLeft.r),
      bottomRight: Radius.circular(bottomRight.r),
     
    ),
    boxShadow: [
      BoxShadow(
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
      )
    ],
  );
}
//===============================Continer===============================
Widget container(double height, double width, double marginL, double marginR,
    Widget child, Color color,
    {double blur = 0.0,
    Offset offset = Offset.zero,
    double spShadow = 0.0,
    double pL = 0.0,
    double pR = 0.0,
    double pT = 0.0,
    double pB = 0.0,
    double marginT = 0.0,
    double marginB = 0.0,
    double bottomLeft = 0.0,
    double topRight = 0.0,
    double topLeft = 0.0,
    double bottomRight = 0.0}) {
  return Container(
    padding: EdgeInsets.only(left: pL.w, right: pR.w, top: pT.h, bottom: pB.h),
    width: width.w,
    height: height.h,
    margin: EdgeInsets.only(
        left: marginL.w, right: marginR.w, top: marginT.h, bottom: marginB.h),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(bottomLeft),
            topRight: Radius.circular(topRight),
            topLeft: Radius.circular(topLeft),
            bottomRight: Radius.circular(bottomRight)),
        color: color,
        boxShadow: [
          BoxShadow(blurRadius: blur, offset: offset, spreadRadius: spShadow)
        ]),
    child: child,
  );
}

//=============================Padding Widget=================================

Widget padding(double pL, double pR, double pT, Widget child,
    {double pB = 0.0}) {
  return Padding(
    padding: EdgeInsets.only(left: pL.w, right: pR.w, top: pT.h, bottom: pB.h),
    child: child,
  );
}

//=================================Buttoms=============================
Widget buttoms(
    context, String key,fontSize, Color textColor ,void Function() onPressed,
    {Color backgrounColor=tansperns,double horizontal = 0.0, double vertical = 0.0,double evaluation=0.0}) {
  return SizedBox(
    width: double.infinity.w,
    height: 45.h,

    child: TextButton(
      onPressed: onPressed,
      child: text(context, key, fontSize, textColor),
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(evaluation),
        backgroundColor: MaterialStateProperty.all(backgrounColor),
        foregroundColor: MaterialStateProperty.all(textColor),
        padding: MaterialStateProperty.all(EdgeInsets.symmetric(
            horizontal: horizontal.w, vertical: vertical.h)),
      ),
    ),
  );
}

//===============================Go To page===============================
goTopage(context, pageName) {
  return Navigator.push(context, MaterialPageRoute(builder: (_) => pageName));
}

//===========================DropMenu Buttom==============================
Widget selectLangButtom(context,{ IconData icon}) {
  return DropdownButton(
    elevation: 20,
    dropdownColor: grrey,
    underline: SizedBox(),
    iconSize: 35.sp,
    
    icon: Icon(icon, color: black),
    
    items: Language.languageList()
        .map<DropdownMenuItem<Language>>((lang) => DropdownMenuItem(
              value: lang,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    lang.flag,
                    style: TextStyle(fontSize: 20.sp),
                  ),
                  Text(lang.name)
                ],
              ),
            ))
        .toList(),
    onChanged: (Language lang) {
      changeLanguage(lang, context);
    },
  );
}

//==========================Image====================================
Widget image(String path,BoxFit fit,{double height=100,double width=100,}) {
  return Image(image:AssetImage(path),fit:fit,
  height: height.h,
  width: width.w
  );
}
//=============================TextFields=================================
Widget textField(context, icons, suffixIcon, String key,
    bool hintPass, TextEditingController mycontroller, String Function(String) validator,{double dayle=1.5}) {
  return FadeAnimation(dayle,TextFormField(
      
      obscureText: hintPass,
      validator: validator,
      controller: mycontroller,
      decoration: InputDecoration(
        isDense: true,
          filled: true,
          fillColor: grrey,
          labelStyle: TextStyle(color: transparensgrey, fontSize: fontSize.sp),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
          prefixIcon: Icon(icons,color: deepYallow),
          suffixIcon: suffixIcon,
          labelText: "${getTranslated(context, key)}",
          contentPadding: EdgeInsets.all(10.h)),
    ),
     
  );
}

//==============================ContinerWithBackground image================================
Widget continerBackgroundImage(String imagePath,Widget child,{Color filterColor=Colors.black54}) {
  return  Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          color: deepWhite,
          image: DecorationImage(
              image: AssetImage(imagePath),
              colorFilter: ColorFilter.mode(filterColor, BlendMode.darken),
              fit: BoxFit.cover)
              ),
      child: child
      );
}
//==============================================================

