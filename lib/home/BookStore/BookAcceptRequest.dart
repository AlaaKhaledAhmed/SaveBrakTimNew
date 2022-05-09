import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:save_break_time/Models/virables.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Models/AleartDilolg.dart';
import '../../Models/Methods.dart';
import '../../localization/localization_methods.dart';
class BookAcceptRequest extends StatefulWidget {
  @override
  State<BookAcceptRequest> createState() => _BookAcceptRequestState();
}

class _BookAcceptRequestState extends State<BookAcceptRequest> {
 String stateValue = '';

  List<String> stutsCode = [
    "طلبك قيد التجهيز",
    "تم الانتهاء من طلبك"
  ];

  CollectionReference acceptRequestCollection =
      FirebaseFirestore.instance.collection("acceptRequest");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(context),
      appBar: drowAppBar("Accepted requests", context),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                backBook,
              ),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken)),
        ),
        child: StreamBuilder(
            stream: acceptRequestCollection.where('type',isEqualTo:"book",).snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshat) {
              if (snapshat.hasError) {
                print("errrorrrrrrrrr");
              }
              if (snapshat.hasData) {
                return getUsers(context, snapshat);
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }

  Widget getUsers(BuildContext context, AsyncSnapshot snapshat) {
    return snapshat.data.docs.length > 0
        ? Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.0.w, vertical: 14.h),
            child: ListView.builder(
                //shrinkWrap: true,
                itemCount: snapshat.data.docs.length,
                itemBuilder: (context, i) {
                  print(
                    snapshat.data.docs.length,
                  );
                  return SizedBox(
                    height: 150.h,
                    child: Padding(
                        padding: EdgeInsets.all(8.0.h),
                        child: Card(
                            elevation: 5,
                            color: white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                    child: getData("${getTranslated(context, "Order number")}",
                                        '${snapshat.data.docs[i].data()['orderId']}')),

                                Expanded(
                                  child: snapshat.data.docs[i]
                                              .data()['state'] !=
                                          'تم الانتهاء من طلبك'
                                      ? drowMenu(
                                          '${snapshat.data.docs[i].data()['state']}',
                                          Icons.delivery_dining_outlined,
                                          stutsCode, (value) {
                                          setState(() {
                                            stateValue = value;
                                            dialog(
                                                context, 'SING IN', 'wating');

                                            acceptRequestCollection
                                                .doc(
                                                    "${snapshat.data.docs[i].id}")
                                                .update({
                                              'state': stateValue,
                                            }).then((value) {
                                              Navigator.pop(context);
                                              FirebaseFirestore.instance
                                                  .collection("messege")
                                                  .add({
                                                'masseg': '$stateValue',
                                                'date':
                                                    "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                                                'time':
                                                    "${DateTime.now().hour} : ${DateTime.now().minute}",
                                                'userId': snapshat
                                                    .data.docs[i]
                                                    .data()['userId'],
                                                'createOn': DateTime.now(),
                                              });
                                            });
                                          });
                                          print(stateValue);
                                        }, (value) {
                                          if (value == null) {
                                            return getTranslated(
                                                context, "Fill in the field");
                                          } else {
                                            return null;
                                          }
                                        }, width: 250.w)
                                      : text(
                                          context,
                                          "Order completed",
                                          14,
                                          deepYallow,
                                        ),
                                ),
                              ],
                            ))),
                  );
                }),
          )
        : Align(
            alignment: Alignment.center,
            child: Lottie.asset(
              "Assist/lottie/no-data.json",
              fit: BoxFit.cover,
            ),
          );
  }

  Widget getData(String title, String title2) {
    return Row(children: [
      Expanded(child: textDB(context, title, 13, black)),
      SizedBox(width: 10.w),
      Expanded(child: textDB(context, title2, 13, black))
    ]);
  }
}
