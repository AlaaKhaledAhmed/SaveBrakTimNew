import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'set_localization.dart';

String getTranslated(BuildContext context, String key) {
  return SetLocalization.of(context).getTranslateValue(key);
}

const String ENGLISH = 'en';
const String ARABIC = 'ar';
const String LANG_CODE = 'LANG_CODE';

// save selected languge
Future<Locale> setLocale(context,String languageCode) async {
  
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString(LANG_CODE, languageCode);
  return locale(languageCode);


}

//get selected lang and seve it in _temp 
Locale locale(String langCode) {
  Locale _temp;
  switch (langCode) {
    case ENGLISH:
      {
        _temp = Locale(langCode, 'US');
      }
      break;
    case ARABIC:
      {
        _temp = Locale(langCode, 'SA');
      }
      break;
    default:
      _temp = Locale(ARABIC, 'SA');
      break;
  }
  return _temp;
}



 //get selected language
 Future<Locale> getLocale() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  //?? تعني انه اذا لم يختار اللغة يرجع اللغة الانجليزية
  String languageCode=preferences.getString(LANG_CODE) ?? ARABIC;
  return locale(languageCode);

}