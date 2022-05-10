import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:save_break_time/Models/virables.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Models/AleartDilolg.dart';
import '../../../Models/Methods.dart';
import '../../../localization/localization_methods.dart';

class BookWorkerRequest extends StatefulWidget {
  @override
  State<BookWorkerRequest> createState() => _BookWorkerRequestState();
}

class _BookWorkerRequestState extends State<BookWorkerRequest> {
  CollectionReference orderCollection =
      FirebaseFirestore.instance.collection("order");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(context),
      appBar: drowAppBar("REQUEST", context),
      backgroundColor: deepYallow,
      body: continerBackgroundImage(
        '$backBook',
        padding(
            20,
            20,
            30,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                text(context, 'New orders', 20, deepWhite,
                    fontWeight: FontWeight.w700),
//----------------------------------------------------------------
                Expanded(
                    child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: orderCollection
                            .where("type", isEqualTo: "book")
                            .snapshots(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshat) {
                          if (snapshat.hasError) {
                            print("errrrrrrrrrrrrrrrror");
                          }
                          if (snapshat.hasData) {
                            return getProducts(context, snapshat);
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        })),
              ],
            )),
        filterColor: black.withOpacity(.7),
      ),
    );
  }

//----------------------------------------------------------------
  Widget getProducts(BuildContext context, AsyncSnapshot snapshat) {
    return snapshat.data.docs.length > 0
        ? Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: ListView.builder(
                //shrinkWrap: true,
                itemCount: snapshat.data.docs.length,
                itemBuilder: (context, i) {
                  return SizedBox(
                    height: 160.h,
                    child: Card(
                      elevation: 10,
                      color: white,
                      child: Row(
                        children: [
//product accebtReject-------------------------------------
                          Expanded(
                            flex: 2,
                            child: Container(
                                decoration: decoration(
                                  4,
                                  4,
                                  4,
                                  4,
                                  color: deepYallow,
                                ),
                                child: accsebtRetjectBtn(snapshat, i)),
                          ),
                          Expanded(
                            flex: 4,
                            child: Column(
                              children: [
                                Expanded(
                                    child: Container(
                                        width: double.infinity,
                                        height: double.infinity,
                                        color: deepYallow,
                                        child: Center(
                                            child: textDB(
                                                context,
                                                "${getTranslated(context, 'Order number')} ${snapshat.data.docs[i].data()['orderId']}",
                                                fontSize,
                                                black)))),
//---------------------------------------------------------------------
                                Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 8.0.w, right: 8.0.w),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                                child: heder(getTranslated(
                                                    context, "Order"))),
                                            divider(),
                                            Expanded(
                                                child: heder(getTranslated(
                                                    context, "Quantity"))),
                                                    divider(),
                                            Expanded(
                                                child: heder(getTranslated(
                                                    context, "Time"))),
                                          ],
                                        ),
                                      ),
                                    )),
//----------------------------------------------------------------------------
                                Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 8.0.w, right: 8.0.w),
                                      child: Column(
                                        children: [
                                          getStudentOrders(
                                            snapshat,
                                            i,
                                          ),
                                        ],
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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

//-------------------------------------------------------
  Widget heder(String name) {
    return textDB(context, name, 15, deepYallow, fontWeight: FontWeight.w700);
  }
  //--------------------------------------------------

  Widget getStudentOrders(snapshat, i) {
    return Expanded(
      child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              color: Colors.grey[400],
            );
          },
          itemCount: snapshat.data.docs[i].data()['data'].length,
          itemBuilder: (context, j) {
            return Row(
              children: [
                Expanded(
                  child: textDB(
                      context,
                      "${snapshat.data.docs[i].data()['data'][j]["prName"]}",
                      12,
                      black,
                      fontWeight: FontWeight.w700),
                ),
                divider(),
                Expanded(
                  child: textDB(
                      context,
                      "${snapshat.data.docs[i].data()['data'][j]["StudentQuantity"]}",
                      12,
                      black,
                      fontWeight: FontWeight.w700),
                ),
                divider(),
                Expanded(
                  child: textDB(
                      context,
                      "${snapshat.data.docs[i].data()['data'][j]["time"]}",
                      12,
                      black,
                      fontWeight: FontWeight.w700),
                ),
              ],
            );
          }),
    );
    //----------------------------------------------------------------------------
  }

  //---------------------------------------------------------------------------------------------------------
  accsebtRetjectBtn(snapshat, i) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
// الاجمالي-----------------------------------------------

        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            text(context, "number of orders", 13, black,
                fontWeight: FontWeight.w700),
            textDB(context, " ${snapshat.data.docs[i].data()['data'].length}",
                13, black,
                fontWeight: FontWeight.w700),
          ],
        ),
        SizedBox(height: 5.h),

        snapshat.data.docs[i].data()['state'] == false
            ? Column(
                children: [
                  //قبول الطلب-----------------------------------------------
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                    child:
                        buttoms(context, "Acceptance", 14.0, black, () async {
                      dialog(context, 'SING IN', 'wating');
                      await FirebaseFirestore.instance
                          .collection("acceptRequest")
                          .add({
                        'orderId': snapshat.data.docs[i].data()['orderId'],
                        'userId': snapshat.data.docs[i].data()['userId'],
                        'type': "book",
                        'state': 'حالة الطلب'
                      }).then((value) {});
                      FirebaseFirestore.instance.collection("messege").add({
                        'masseg':
                            ' لقد تم قبول طلبك من عامل متجر الكتب ورقم الطلب هو ${snapshat.data.docs[i].data()['orderId']}',
                        'date':
                            "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                        'time':
                            "${DateTime.now().hour} : ${DateTime.now().minute}",
                        'userId': snapshat.data.docs[i].data()['userId'],
                        'createOn': DateTime.now()
                      });
                      orderCollection
                          .doc('${snapshat.data.docs[i].id}')
                          .update({
                        'state': true,
                      });
                      Navigator.pop(context);
                    }, backgrounColor: deepYallow),
                  ),

//رفض الطلب-----------------------------------------------

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                    child: buttoms(context, "Refusal", 14.0, black, () async {
                      dialog(context, 'SING IN', 'wating');

                      await FirebaseFirestore.instance
                          .collection("messege")
                          .add({
                        'masseg': 'نعتزر منك عامل المكتبة لم  يقبل طلبك',
                        'date':
                            "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                        'time':
                            "${DateTime.now().hour} : ${DateTime.now().minute}",
                        'userId': snapshat.data.docs[i].data()['userId'],
                        'createOn': DateTime.now(),
                      }).then((value) {
                        Navigator.pop(context);
                        orderCollection
                            .doc('${snapshat.data.docs[i].id}')
                            .delete();
                      });
                    }, backgrounColor: deepYallow),
                  ),
                ],
              )
            : text(context, "Request accepted", 14, black),
      ],
    );
  }
}
