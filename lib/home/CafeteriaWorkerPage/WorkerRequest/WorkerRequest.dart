import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:save_break_time/Models/virables.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Models/Methods.dart';
import '../../../localization/localization_methods.dart';

class WorkerRequest extends StatefulWidget {
  @override
  State<WorkerRequest> createState() => _WorkerRequestState();
}

class _WorkerRequestState extends State<WorkerRequest> {
  CollectionReference requestCollection =
      FirebaseFirestore.instance.collection("order");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(context),
      appBar: drowAppBar("REQUEST", context),
      backgroundColor: deepYallow,
      body: continerBackgroundImage(
        '$backImage',
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
                        stream: requestCollection
                            .where("type", isEqualTo: "cafie")
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
    return Padding(
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
                                padding:
                                    EdgeInsets.only(left: 8.0.w, right: 8.0.w),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                          child: heder(
                                              getTranslated(context, "Order"))),
                                      divider(),
                                      Expanded(
                                          child: heder(getTranslated(
                                              context, "Quantity"))),
                                    ],
                                  ),
                                ),
                              )),
//----------------------------------------------------------------------------
                          Expanded(
                              flex: 2,
                              child: Padding(
                                padding:
                                    EdgeInsets.only(left: 8.0.w, right: 8.0.w),
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
            text(context, "number of orders", 13, black, fontWeight: FontWeight.w700),
            textDB(context, " ${snapshat.data.docs[i].data()['data'].length}",
                13, black,
                fontWeight: FontWeight.w700),
          ],
        ),
        SizedBox(height: 5.h),
//قبول الطلب-----------------------------------------------
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0.w),
          child: buttoms(context, "Acceptance", 14.0, black, () {},
              backgrounColor: deepYallow),
        ),

//رفض الطلب-----------------------------------------------

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0.w),
          child: buttoms(context, "Refusal", 14.0, black, () {},
              backgrounColor: deepYallow),
        ),
      ],
    );
  }
}
