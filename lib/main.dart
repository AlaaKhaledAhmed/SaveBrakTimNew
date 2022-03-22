import 'package:flutter/material.dart';
import 'package:save_break_time/Logging-SingUp/Logging.dart';
import 'package:save_break_time/SelectLangugePage/SelestLangView.dart';
import 'package:save_break_time/localization/localization_methods.dart';
import 'home/WorkerHomePage/WorkerNavHome.dart';
import 'localization/set_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
void main()async {
  runApp(MyApp());
    WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocal(locale);
  }

  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool selectLang = true;
  Locale _local;
  //تحديد لغة التطبيق وفق للغه المختارة------------------------
  void setLocal(Locale local) {
    setState(() {
      _local = local;
      if (_local.toString().compareTo("ar_SA") == 0) {
        selectLang = true;
      } else if (_local.toString().compareTo("en_US") == 0) {
        selectLang = false;
      } else if (_local == null) {
        selectLang = false;
      }
      print(selectLang);
    });
  }

//_local seved in it seleted language
  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._local = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      //screen size
      designSize: const Size(360, 640),
      builder: () => MaterialApp(
        title: "Sava break time",
//اختيار نوع الخط وفقا للغه المختارة-------------------------
        theme: ThemeData(
          fontFamily: selectLang ? "DroidKufi" : "Quicksand",
        ),

//locale  هو كود اللغه المختارة اما ar-SA or en-US
        locale: _local,
        supportedLocales: [
          Locale('en', 'US'),
          Locale('ar', 'SA'),
        ],

//تغير اتجاهات العناصر في الشاشه حسب اللغة--------------
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          SetLocalization.localizationsDelegate
        ],
// التاكد من ان اللغه المختارة مدعومة في الجهاز
        localeResolutionCallback: (deviceLocal, supportedLocales) {
          for (var local in supportedLocales) {
            if (local.languageCode == deviceLocal.languageCode &&
                local.countryCode == deviceLocal.countryCode) {
              return deviceLocal;
            }
          }
          return supportedLocales.first;
        },
        debugShowCheckedModeBanner: false,
        //اظهار الشاشه الولي وفقا لحاله المستخدم, هل قام بالتسجيل مسلقا ام اول مره يظهر التطبيق
        home:WorkerNavHome()
       // _local == null ?
      //SelectLangView()
         // :
         //WorkerNavHome(),
      ),
    );
  }
}
