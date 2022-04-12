import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_break_time/Models/virables.dart';
import 'package:save_break_time/localization/localization_methods.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

import '../BookStore/BookWorkerNotification.dart';
import '../BookStore/BookWorkerProducts/BookWorkerProduct.dart';
import '../BookStore/BookWorkerRequest/BookWorkerRequest.dart';
import 'WorkerNotification.dart';
import 'WorkerProducts/Product.dart';
import 'WorkerRequest/WorkerRequest.dart';

class WorkerNavHome extends StatefulWidget {
  WorkerNavHome({Key key}) : super(key: key);

  @override
  State<WorkerNavHome> createState() => _WorkerNavHomeState();
}

class _WorkerNavHomeState extends State<WorkerNavHome> {
  int number = 10;
   int selectedIndex = 1;
   PageController pageController ;
  List <Widget>workerPage=[WorkerNotification(),Product(),WorkerRequest()];
 
 
  void initState() {
    super.initState();
    pageController = PageController(initialPage: selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: workerPage,
        ),
        bottomNavigationBar: ConvexAppBar.badge(
          {0: '$number'},
          badgeColor: red,
          badgeMargin: EdgeInsets.only(bottom: 10.h, right: 50.w),
          style: TabStyle.reactCircle,
          //selest icon color
          activeColor: deepGrey,
          elevation: 10,
          //bar color
          backgroundColor: gry,
          //icon color
          height: 50.h,
         
          color: black.withOpacity(.7),
          items: [
            TabItem(
                icon: notificationsIcon,
                title: '${getTranslated(context, 'NOTIFICATION')}'),
            TabItem(icon: homeIcon, title: '${getTranslated(context, 'HOME')}'),
            TabItem(
                icon: requstIcon,
                title: '${getTranslated(context, 'REQUEST')}'),
          ],
          initialActiveIndex: 1, //optional, default as 0
          onTap: onTap,
        ));
  }

  //click methos--------------------------
  void onTap(int index) {
    setState(() {
      selectedIndex = index;
    });
    pageController.animateToPage(selectedIndex,
        duration: const Duration(milliseconds: 400), curve: Curves.easeInCirc);
  }
}
