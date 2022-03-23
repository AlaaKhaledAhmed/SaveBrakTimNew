import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:save_break_time/Models/Methods.dart';
import 'package:save_break_time/Models/virables.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_break_time/localization/localization_methods.dart';

import 'AddProduct.dart';

class WorkerProductMainPage extends StatefulWidget {
  @override
  State<WorkerProductMainPage> createState() => _WorkerProductMainPageState();
}

class _WorkerProductMainPageState extends State<WorkerProductMainPage> {
  @override
  CollectionReference<Map<String, dynamic>> productCollection =
      FirebaseFirestore.instance.collection("product");

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
                text(context, 'Available Products', 20, deepWhite,
                    fontWeight: FontWeight.w700),
                SizedBox(
                  height: 15.h,
                ),
//----------------------------------------------------------------
                buttoms(context, "ADD New", 14.0, black, () {
                  goTopage(context, AddProduct());
                },
                    backgrounColor: deepYallow),
                // SizedBox(
                //   height: 10.h,
                // ),
//----------------------------------------------------------------
                Expanded(
                    child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        future: productCollection.get(),
                        builder: (BuildContext context, AsyncSnapshot snapshat) {
                          if (snapshat.hasError) {
                           
                          }
                          if (snapshat.hasData) {
                            print(snapshat.data.runtimeType);
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
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, //عدد العناصر في كل صف
            crossAxisSpacing: 15, // المسافات الراسية
            childAspectRatio: 0.70, //حجم العناصر
            mainAxisSpacing: 15 //المسافات الافقية

            ),
        itemCount: 4, //snapshat.data.docs.length,
        itemBuilder: (context, i) {
          return SizedBox(
            height: 180.h,
            child: Card(
                elevation: 10,
                color: white,
                child: Column(
                  children: [
                    Expanded(flex: 3, child: ClipRRect(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(4.r),topRight:Radius.circular(4.r)),
                      child: Image(image: AssetImage("Assist/image/product.jpg"),fit: BoxFit.cover,))),
                    Expanded(
                      flex: 1,
                      child: textDB(context,"دجاج برياني" , 15, black,
                          fontWeight: FontWeight.w700),
                    ),
                    Expanded(flex: 1, child: textDB(context,"12 "+getTranslated(context, 'SAR') , 15, black,
                          fontWeight: FontWeight.w700)),
                  ],
                )),
          );
        });
  }
}
