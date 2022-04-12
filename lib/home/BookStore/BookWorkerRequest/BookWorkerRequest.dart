import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:save_break_time/Models/virables.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Models/Methods.dart';
import '../../../localization/localization_methods.dart';

class BookWorkerRequest extends StatefulWidget {
  @override
  State<BookWorkerRequest> createState() => _BookWorkerRequestState();
}

class _BookWorkerRequestState extends State<BookWorkerRequest> {
  CollectionReference<Map<String, dynamic>> requestCollection =
      FirebaseFirestore.instance.collection("product");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: deepYallow,
      body: continerBackgroundImage(
        '$backImage',
        padding(
            20,
            20,
            50,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                text(context, 'New orders', 20, deepWhite,
                    fontWeight: FontWeight.w700),
//----------------------------------------------------------------
                Expanded(
                    child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        future: requestCollection.get(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshat) {
                          if (snapshat.hasError) {
                            print("");
                          }
                          if (snapshat.hasData) {
                            print(snapshat.data.runtimeType);
                            return getProducts(context, snapshat);
                          }
                          // }  if (snapshat.hasData==null) {
                          //   print("NO DAAAAAAAAAAAAAAAAAAAATA FOUND");
                          // }
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
          itemCount: 5,//snapshat.data.docs.length,
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
                          decoration: decoration(4, 4, 4, 4, color: deepYallow,

                           ),
                          child: accsebtRetjectBtn()),
                    ),
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
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
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(child: heder(getTranslated(context, "Order"))),
                                      divider(),
                                      Expanded(child: heder(getTranslated(context, "Quantity"))),
                                     
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
           itemCount:5,// snapshat.data.docs[i].data()['ordersName'].length,
          itemBuilder: (context, j) {
            return Row(
              children: [
                Expanded(
                  child: textDB(context, "name", 12, black,
                      fontWeight: FontWeight.w700),
                ),
                divider(),
                Expanded(
                  child: textDB(context, "name", 12, black,
                      fontWeight: FontWeight.w700),
                ),
               
              ],
            );
          }),
    );
    //----------------------------------------------------------------------------
  }

  //---------------------------------------------------------------------------------------------------------
  accsebtRetjectBtn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
// الاجمالي-----------------------------------------------

        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            text(context, "Total", 13, black,
                fontWeight: FontWeight.w700),
            textDB(context, " 5", 13, black, fontWeight: FontWeight.w700),
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
