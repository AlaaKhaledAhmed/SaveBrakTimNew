import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_break_time/home/CafeteriaWorkerPage/WorkerNotification.dart';
import 'package:save_break_time/home/CafeteriaWorkerPage/WorkerProducts/Product.dart';
import 'package:save_break_time/home/CafeteriaWorkerPage/WorkerRequest/WorkerRequest.dart';
import '../home/BookStore/BookWorkerProducts/BookWorkerProduct.dart';
import '../home/BookStore/BookWorkerRequest/BookWorkerRequest.dart';
import '../home/StudentHomePage/bookStoreMain.dart';
import '../home/StudentHomePage/RequestMain.dart';
import '../home/StudentHomePage/StudentNotification.dart';
import '../home/StudentHomePage/cafeteriaMain.dart';
import 'Methods.dart';

//colors-----------------------------------------
Color deepGrey = hexToColor('#2f3c42');
Color deepWhite = hexToColor('#fbffff');
Color deepYallow = hexToColor('#fbd220');
Color transparensgrey = hexToColor('#616a6d');
Color black = Colors.black;
const Color tansperns = Colors.transparent;
const Color white = Colors.white;
Color grrey =  Colors.grey[100];
Color gry =  Colors.grey[300];
Color red =  Colors.red[800];

//image path-----------------------------------------
String staticPath="Assist/image/";
String logoPath="$staticPath"+"logo.png";
String welcomBacgroundImage="$staticPath"+"save4.jpg";
String productImage="$staticPath"+"product.jpg";
String backImage="$staticPath"+"bac.jpg";
// Icons name-----------------------------------------
IconData nameIcon=Icons.person;

IconData passIcon=Icons.password_outlined;
IconData emailIcon=Icons.email_rounded;
IconData phoneIcon=Icons.phone_android_rounded;
IconData collegIcon=Icons.location_city_rounded;
IconData levelIcon=Icons.reduce_capacity_rounded;
IconData notificationsIcon=Icons.notifications;
IconData cafeIcon=Icons.food_bank;
IconData bookIcon=Icons.library_books_rounded;
IconData homeIcon=Icons.home;
IconData requstIcon=Icons.list_alt_outlined;
Icon noIcon=Icon(Icons.add,size: 0);
Icon priceIcon=Icon(Icons.money,size: 0);
IconData quantityIcon=Icons.production_quantity_limits;
IconData showPassIcon=Icons.remove_red_eye;
IconData hiddPassIcon=Icons.visibility_off_sharp;

//hintText------------------------------------------------------
String nameHint='Enter name';
String emailHint='Enter email';
String passHint='Enter pass';
String collegHint='Enter colleg';
String levelHint='Enter level';
String phoneHint='Enter phone';
String singUp="SING UP";
String singIn="SING IN";


//show text or not-----------------------------------------------------------
bool showText=true;
bool hiddText=false;

//fontSize-----------------------------------------------------------
double fontSize=12.0.sp;
double space=7.0.h;

//App messegs-----------------------------------------------------------
String fillFields="";

//Navigator menu--------------------------------------------------------
  PageController pageController;
 
  PageController studentPageController;
 