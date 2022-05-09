import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_break_time/Models/virables.dart';
import 'package:save_break_time/localization/localization_methods.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'Accepted requests.dart';
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
  PageController pageController;
  List<Widget> workerPage = [WorkerRequest(),Product(),AcceptedRequests()];

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
        bottomNavigationBar: ConvexAppBar(
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
                icon: requstIcon,
                title: '${getTranslated(context, 'REQUEST')}'),
            TabItem(icon: homeIcon, title: '${getTranslated(context, 'HOME')}'),
            TabItem(
                icon: myorder,
                title: '${getTranslated(context, 'accept')}'),
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
