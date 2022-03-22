import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_break_time/Models/Methods.dart';
import 'package:save_break_time/Models/virables.dart';
import 'package:lottie/lottie.dart';

dialog(context, String title, String content,
    {bool showButtom = false, yesFunction, noFunction}) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          titlePadding: EdgeInsets.zero,
          elevation: 0,
          backgroundColor: content == "wating" ? Colors.transparent : white,

//titel-------------------------------------------------------------------

          title: content != "wating"
              ? Container(
                  decoration: BoxDecoration(
                      color: deepYallow,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(3.r),
                          topRight: Radius.circular(3.r))),
                  width: double.infinity,
                  height: 50,
                  child: Center(
                    child: text(
                      context,
                      title,
                      14,
                      white,
                    ),
                  ),
                )
              : SizedBox(),
//contint area-------------------------------------------------------------------

          content: content != "wating"
              ? SizedBox(
                  height: 100.h,
                  width: double.infinity,
                  child: Column(
                    children: [
                      SizedBox(height: 10.h),
//contint titel-------------------------------------------------------------------
                      Expanded(
                        flex: 3,
                        child: Center(
                          child: text(
                            context,
                            content,
                            13,
                            black,
                          ),
                        ),
                      ),

//divider-------------------------------------------------------------------

                      showButtom
                          ? Divider(
                              thickness: 2,
                              color: gry,
                            )
                          : SizedBox(),
                      SizedBox(height: 10.h),
//buttoms-------------------------------------------------------------------

                      showButtom
                          ? Expanded(
                              flex: 1,
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
// yes buttoms-------------------------------------------------------------------

                                    Expanded(
                                        child: buttoms(
                                      context,
                                      "YES",
                                      16.0,
                                      deepYallow,
                                      () {
                                        yesFunction();
                                      },
                                      evaluation: 0,
                                    )),

                                    SizedBox(width: 20.w),
//no buttom-------------------------------------------------------------------

                                    Expanded(
                                        child: buttoms(
                                      context,
                                      "NO",
                                      16.0,
                                      deepYallow,
                                      () {
                                        noFunction();
                                      },
                                      evaluation: 0,
                                    ))
                                  ]),
                            )
                          : SizedBox(),
                    ],
                  ))
//Show Waiting image-------------------------------------------------------
              : SizedBox(
                  width: double.infinity,
                  height: 150.h,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Lottie.asset(
                      "Assist/lottie/loading.json",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

//Show buttoms -------------------------------------------------------

          actions: [
            showButtom == false && content != "wating"
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.clear, color: deepYallow)),
                  )
                : SizedBox()
          ],
        );
      });
} /*

*/
