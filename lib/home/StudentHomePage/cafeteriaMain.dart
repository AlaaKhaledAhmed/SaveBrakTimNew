import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../../Models/Methods.dart';
import '../../Models/virables.dart';
import '../../localization/localization_methods.dart';
import 'pageDatials.dart';

class CafeteriaMain extends StatefulWidget {
  CafeteriaMain({Key key}) : super(key: key);

  @override
  State<CafeteriaMain> createState() => _CafeteriaMainState();
}

class _CafeteriaMainState extends State<CafeteriaMain> {
  CollectionReference<Map<String, dynamic>> productCollection =
      FirebaseFirestore.instance.collection("product");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: drowAppBar("cafeteria products", context),
        body: Column(children: [
          SizedBox(
            height: 15.h,
          ),
          //-----------------------------------------
          Center(
            child: text(context, 'Available Products', 20, black,
                fontWeight: FontWeight.w200),
          ),
          SizedBox(
            height: 15.h,
          ),
//-------------------------------------------------
          Expanded(
              child: Padding(
            padding: EdgeInsets.all(8.0.h),
            child: StreamBuilder(
                stream: productCollection
                    .where('workerType', isEqualTo: 'cafie')
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshat) {
                  if (snapshat.hasError) {
                    return Text("Connection error");
                  }
                  if (snapshat.hasData) {
                    return getProducts(context, snapshat);
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          )),
//-------------------------------------------------

//-------------------------------------------------

//-------------------------------------------------
        ]));
  }

  //----------------------------------------------------------------
  Widget getProducts(BuildContext context, AsyncSnapshot snapshat) {
    return snapshat.data.docs.length > 0
        ? GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, //عدد العناصر في كل صف
                crossAxisSpacing: 15, // المسافات الراسية
                childAspectRatio: 0.70, //حجم العناصر
                mainAxisSpacing: 15 //المسافات الافقية

                ),
            itemCount: snapshat.data.docs.length,
            itemBuilder: (context, i) {
              return InkWell(
                onTap: () {
                  goTopage(context, ProductsDetials(
                    image:snapshat.data.docs[i].data()['imagePath'] ,
                    prId: snapshat.data.docs[i].data()['prId'],
                    prName: snapshat.data.docs[i].data()['prName'],
                    price: snapshat.data.docs[i].data()['prPrice'],
                    quantity:snapshat.data.docs[i].data()['prQuantity'] ,
                  ));
                },
                child: SizedBox(
                  height: 180.h,
                  child: Card(
                      elevation: 10,
                      color: white,
                      child: Column(
                        children: [
                          Expanded(
                              flex: 3,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(4.r),
                                    topRight: Radius.circular(4.r)),
                                child: Image.network(
                                  "${snapshat.data.docs[i].data()['imagePath']}",
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              )),
                          Expanded(
                            flex: 1,
                            child: Container(
                              color: deepYallow,
                              width: double.infinity,
                              padding: EdgeInsets.all(10.h),
                              child: textDB(
                                  context,
                                  "${snapshat.data.docs[i].data()['prName']}",
                                  15,
                                  black,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: Container(
                                color: deepYallow,
                                width: double.infinity,
                                child: textDB(
                                    context,
                                    "${snapshat.data.docs[i].data()['prPrice']} " +
                                        getTranslated(context, 'SAR'),
                                    15,
                                    black,
                                    fontWeight: FontWeight.w700),
                              )),
                        ],
                      )),
                ),
              );
            })
        : Align(
            alignment: Alignment.center,
            child: Lottie.asset(
              "Assist/lottie/no-data.json",
              fit: BoxFit.cover,
            ),
          );
  }
}
