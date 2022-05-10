import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:save_break_time/Animation/FadeAnimation.dart';
import 'package:save_break_time/Logging-SingUp/Logging.dart';
import 'package:save_break_time/Models/virables.dart';
import 'package:save_break_time/SelectLangugePage/SelectLangModel.dart';
import 'package:save_break_time/localization/language.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

divider(
    {double thickness = 2,
    double indent = 15,
    double endIndent = 15,
    Color color = Colors.grey}) {
  return Align(
    alignment: Alignment.topCenter,
    child: VerticalDivider(
      color: color,
      thickness: thickness,
      indent: indent,
      endIndent: endIndent,
      //width: 12,
    ),
  );
}

//container decoration-------------------------------------------
decoration(
    double bottomLeft, double bottomRight, double topLeft, double topRight,
    {Color color = white,
    double blurRadius = 0.0,
    double spreadRadius = 0.0,
    BoxBorder border,
    BoxShape shap = BoxShape.rectangle}) {
  return BoxDecoration(
    shape: shap,
    color: color,
    border: border,
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
    bored,
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
        border: bored,
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
    context, String key, fontSize, Color textColor, void Function() onPressed,
    {Color backgrounColor = tansperns,
    double horizontal = 0.0,
    double vertical = 0.0,
    double evaluation = 0.0}) {
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

//=======================================================
drowAppBar(String title, context) {
  return AppBar(
    elevation: 0,
    centerTitle: true,
    title: text(context, '$title', 20, white, fontWeight: FontWeight.w700),
  );
}

drowAppBarIcon(String title, context, icon, onPressed) {
  return AppBar(
    elevation: 0,
    centerTitle: true,
    title: text(context, '$title', 20, white, fontWeight: FontWeight.w700),
    actions: [IconButton(onPressed: onPressed, icon: Icon(icon, size: 30.sp))],
  );
}

//===============================Go To page===============================
goTopage(context, pageName) {
  return Navigator.push(context, MaterialPageRoute(builder: (_) => pageName));
}

goTopageReplace(context, pageName) {
  return Navigator.push(context, MaterialPageRoute(builder: (_) => pageName));
}

//===========================DropMenu Buttom==============================
Widget selectLangButtom(context, onChanged, {IconData icon, double size}) {
  return DropdownButton(
      elevation: 20,
      dropdownColor: grrey,
      underline: SizedBox(),
      iconSize: 35.sp,
      icon: Icon(icon, color: white, size: size),
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
      onChanged: onChanged);
}

//==========================Image====================================
Widget image(
  String path,
  BoxFit fit, {
  double height = 100,
  double width = 100,
}) {
  return Image(
      image: AssetImage(path), fit: fit, height: height.h, width: width.w);
}

//=============================TextFields=================================
Widget textField(context, icons, suffixIcon, String key, bool hintPass,
    TextEditingController mycontroller, String Function(String) validator,
    {double dayle = 1.5,
    inputFormatters,
    keyboardType,
    void Function(String) onChanged}) {
  return FadeAnimation(
    dayle,
    TextFormField(
      obscureText: hintPass,
      onChanged: onChanged,
      validator: validator,
      controller: mycontroller,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: grrey,
          labelStyle: TextStyle(color: transparensgrey, fontSize: fontSize.sp),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
          prefixIcon: Icon(icons, color: deepYallow),
          //suffixIcon: Icon(suffixIcon, color: deepYallow),
          labelText: "${getTranslated(context, key)}",
          contentPadding: EdgeInsets.all(10.h)),
    ),
  );
}

//==============================ContinerWithBackground image================================
Widget continerBackgroundImage(String imagePath, Widget child,
    {Color filterColor = Colors.black54}) {
  return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          color: deepWhite,
          image: DecorationImage(
              image: AssetImage(imagePath),
              colorFilter: ColorFilter.mode(filterColor, BlendMode.darken),
              fit: BoxFit.cover)),
      child: child);
}
//==============================================================

String empity(value) {
  if (value.isEmpty) {
    return value = value + "\n" + "املء الحقل اعلاه";
  }
  return null;
}

int unidID() {
  return DateTime.now().millisecondsSinceEpoch.remainder(10000);
}

int unidOrder() {
  return DateTime.now().millisecondsSinceEpoch.remainder(100000);
}

//--------------------------------------------------------
drawer(context) {
  return SizedBox(
    height: 200.h,
    child: Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.r)),
      ),
      backgroundColor: deepYallow,
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(height: 30.h),
        Center(
          child: text(context, "Settings", 17, white),
        ),
        SizedBox(height: 15.h),
        ListTile(
          title: Row(
            children: [
              SizedBox(width:77.w),
              Icon(Icons.logout_rounded, color: white),
              SizedBox(width:10.w),
              text(context, "sign out", 17, white)
            ],
          ),
          onTap: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => Logging()));
          },
        ),
        ListTile(
          title: Row(
            children: [
              selectLangButtom(context, (Language lang) {
                changeLangFromApp(lang, context);
              }, icon: Icons.language, size: 30.sp),
              SizedBox(width:10.w),
              text(context, "choose the language", 17, white),
            ],
          ),
        ),
      ]),
    ),
  );
}

//------------------------------------------------------
Widget drowMenu(
    String insiValue, IconData icon, List<String> item, onchanged, validator,
    {double width = double.infinity}) {
  return SizedBox(
    width: 250.w,
    child: DropdownButtonFormField<String>(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        hint: Text(
          "$insiValue",
          style: TextStyle(
            color: deepYallow,
            fontSize: 12.sp,
          ),
        ),
        dropdownColor: white,
        items: item
            .map((type) => DropdownMenuItem(
                  //  alignment: Alignment.center,
                  value: type,
                  child: Text(
                    type,
                    style: TextStyle(
                      color: deepYallow,
                      fontSize: 13.sp,
                    ),
                  ),
                ))
            .toList(),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(8.0),
          prefixIcon: Icon(icon, color: deepYallow, size: 25),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onChanged: onchanged),
  );
}
