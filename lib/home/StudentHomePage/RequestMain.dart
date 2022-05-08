// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../../Models/AleartDilolg.dart';
import '../../Models/Methods.dart';
import '../../Models/virables.dart';
import '../../localization/localization_methods.dart';

class RequestMain extends StatefulWidget {
  RequestMain({Key key}) : super(key: key);

  @override
  State<RequestMain> createState() => _RequestMainState();
}

class _RequestMainState extends State<RequestMain> {
  CollectionReference cardCollection =
      FirebaseFirestore.instance.collection("card");
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection("user");

  String currentUser;
  String userPhone;
  String name;
  List<String> pr_name = [];
  List<String> workerType = [];
  List<num> pr_quantity = [];
  List<num> pr_pricePerOne = [];
  String farmer_id = '';
  var totalPrice = 0.0;
//--------------------------------------------------
  @override
  void initState() {
    super.initState();
//---------------------------------------------------------
    currentUser = FirebaseAuth.instance.currentUser.uid;
    cardCollection
        .where('StudentId', isEqualTo: currentUser)
        .get()
        .then((value) {
      for (var element in value.docs) {
        setState(() {
          totalPrice += element["total price"];
        });
      }
    });
    //---------------------------------------------------------

    cardCollection
        .where('StudentId', isEqualTo: currentUser)
        .get()
        .then((value) {
      for (var element in value.docs) {
        pr_name.add(element["prName"]);
        pr_quantity.add(element["StudentQuantity"]);
        pr_pricePerOne.add(element["total price"]);
        workerType.add(element["type"]);
      }
    });
//---------------------------------------------------------
    userCollection.where('userID', isEqualTo: currentUser).get().then((value) {
      for (var element in value.docs) {
        setState(() {
          name = element["name"];
          userPhone = element["phone"];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(context),
      appBar: drowAppBar("REQUEST", context),
      body: continerBackgroundImage(
        '$welcomBacgroundImage',
        padding(
          10,
          10,
          5,
          Column(
            children: [
              SizedBox(height: 20.h),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.all(8.0.w),
                child: StreamBuilder(
                    stream: cardCollection
                        .where('StudentId', isEqualTo: currentUser)
                        .snapshots(),
                    builder: (BuildContext context, AsyncSnapshot snapshat) {
                      if (snapshat.hasError) {
                        return Text("${snapshat.error}");
                      }
                      if (snapshat.hasData) {
                        return getCarItem(context, snapshat);
                      }

                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
              )),
            ],
          ),
        ),
        // filterColor: black.withOpacity(.7),
      ),
    );
  }

  Widget getCarItem(BuildContext context, AsyncSnapshot snapshat) {
    return snapshat.data.docs.length > 0
        ? Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//total price-----------------------------------------
              textDB(
                  context,
                  "${getTranslated(context, "Total")} " +
                      "$totalPrice " +
                      getTranslated(context, "SAR"),
                  16,
                  white,
                  fontWeight: FontWeight.w700),
//number of orders-----------------------------------------
              textDB(
                  context,
                  "${getTranslated(context, "number of orders")} " +
                      "${snapshat.data.docs.length}",
                  16,
                  white,
                  fontWeight: FontWeight.w700),
            ]),
            SizedBox(height: 10.h),
//details----------------------------------------------------

            Expanded(
              child: ListView.builder(
                  itemCount: snapshat.data.docs.length,
                  itemBuilder: (context, i) {
                    return ListTile(
                      title: Align(
                        alignment: Alignment.centerRight,
                        child: textDB(
                            context,
                            '${snapshat.data.docs[i].data()['prName']}',
                            14,
                            white),
                      ),
                      subtitle: Row(
                        children: [
                          Icon(quantityIcon, color: deepYallow, size: 20.sp),
                          textDB(
                              context,
                              ' ${snapshat.data.docs[i].data()['StudentQuantity']}',
                              12,
                              white),
                          SizedBox(width: 10.w),
                          Icon(Icons.money, color: deepYallow, size: 20.sp),
                          textDB(
                              context,
                              ' ${snapshat.data.docs[i].data()['total price']}',
                              12,
                              white),
                        ],
                      ),
                      trailing: IconButton(
                          padding: EdgeInsets.zero,
                          alignment: Alignment.centerLeft,
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection('card')
                                .doc("${snapshat.data.docs[i].id}")
                                .delete();
                            setState(() {
                              totalPrice -=
                                  snapshat.data.docs[i].data()['total price'];
                              pr_name.remove(
                                  snapshat.data.docs[i].data()['prName']);
                              workerType
                                  .remove(snapshat.data.docs[i].data()['type']);
                              pr_quantity.remove(snapshat.data.docs[i]
                                  .data()['StudentQuantity']);
                              pr_pricePerOne.remove(
                                  snapshat.data.docs[i].data()['total price']);
                            });
                          },
                          icon: Icon(Icons.remove_circle, color: deepYallow)),
                    );
                  }),
            ),
//confirm order----------------------------------------------------

            buttoms(context, "Confirm orders", 14.0, black, () {
              dialog(context, 'SING IN', 'wating');
              FirebaseFirestore.instance.collection("order").add({
                "orderId": unidOrder(),
                "ordersName": pr_name,
                "quantityPerOrder": pr_quantity,
                "pricePerOrder": pr_pricePerOne,
                "userName": name,
                "phone": userPhone,
                "ordersNumber": snapshat.data.docs.length,
                "totalPrice": totalPrice,
                "userId": currentUser,
                "type": workerType,
              }).then((value) {
                Navigator.pop(context);
                dialog(context, "request", "send");
                //delete all user item from card
                cardCollection
                    .where("StudentId", isEqualTo: currentUser)
                    .get()
                    .then((snapshot) {
                  // for (DocumentSnapshot ds in snapshot.docs) {
                  //   ds.reference.delete();
                  // }
                });
              });
            }, backgrounColor: white),
            SizedBox(height: 25.h),
          ])
        : Align(
            alignment: Alignment.center,
            child: Lottie.asset(
              "Assist/lottie/no-data.json",
              fit: BoxFit.cover,
            ),
          );
  }
}
