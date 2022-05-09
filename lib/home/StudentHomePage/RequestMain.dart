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
  List<Map<String, dynamic>> cafeItem = [];
  List<Map<String, dynamic>> bookItem = [];

  var orderId;
  var totalPrice = 0.0;
//--------------------------------------------------

  @override
  void initState() {
    super.initState();
    orderId = unidOrder();
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

    refrash();
//---------------------------------------------------------
    userCollection.where('userID', isEqualTo: currentUser).get().then((value) {
      for (var element in value.docs) {
        // setState(() {
          name = element["name"];
          userPhone = element["phone"];
        // });
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
                            setState(() {
                              totalPrice -=
                                  snapshat.data.docs[i].data()['total price'];
                              FirebaseFirestore.instance
                                  .collection('card')
                                  .doc("${snapshat.data.docs[i].id}")
                                  .delete();
                              refrash();
                            });
                          },
                          icon: Icon(Icons.remove_circle, color: deepYallow)),
                    );
                  }),
            ),
//confirm order----------------------------------------------------

            buttoms(context, "Confirm orders", 14.0, black, () async {
              dialog(context, 'SING IN', 'wating');
              if (bookItem.length > 0) {
                FirebaseFirestore.instance.collection("order").add({
                  "type": "book",
                  "orderId": orderId,
                  "userName": name,
                  "phone": userPhone,
                  "userId": currentUser,
                  "data": bookItem,
                  "state":false
                }).then((value) async {});
              }
              if (cafeItem.length > 0) {
                FirebaseFirestore.instance.collection("order").add({
                  "type": "cafie",
                  "orderId": orderId,
                  "userName": name,
                  "phone": userPhone,
                  "userId": currentUser,
                  "data": cafeItem,
                  "state":false
                }).then((value) async {});
              }
              Navigator.pop(context);
              dialog(context, "request", "send");
              //delete all user item from card
              cardCollection
                  .where("StudentId", isEqualTo: currentUser)
                  .get()
                  .then((snapshot) {
                for (DocumentSnapshot ds in snapshot.docs) {
                  ds.reference.delete();
                }
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

//-----------------------------------------------------------
  refrash() {
    cafeItem.clear();
    bookItem.clear();
    cardCollection
        .where('StudentId', isEqualTo: currentUser)
        .get()
        .then((value) {
      for (var element in value.docs) {
        if (element["type"] == "cafie") {
          cafeItem.add(element.data());
        } else {
          bookItem.add(element.data());
        }
      }
    });
  }
}
