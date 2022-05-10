import 'package:flutter/material.dart';
import 'package:save_break_time/Logging-SingUp/SingUp.dart';
import 'package:save_break_time/Models/Methods.dart';
import 'package:save_break_time/localization/language.dart';
import 'package:save_break_time/localization/localization_methods.dart';
import '../main.dart';

void changeLanguage(Language lang, BuildContext context) async {
  Locale _temp = await setLocale(context, lang.languageCode);
  goTopage(context, SingUp());
  MyApp.setLocale(context, _temp);
}
void changeLangFromApp(Language lang, BuildContext context) async {
  Locale _temp = await setLocale(context, lang.languageCode);
  MyApp.setLocale(context, _temp);
}
