import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:counter_button/counter_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_break_time/localization/localization_methods.dart';
import '../../Models/AleartDilolg.dart';
import '../../Models/Methods.dart';
import '../../Models/virables.dart';
import 'SudentNavHome.dart';

class ProductsDetials extends StatefulWidget {
  final String image;
  final String prName;
  final int price;
  final int quantity;
  final int prId;
  final String type;
   final String docId;
  const ProductsDetials(
      {this.image,
      this.prName,
      this.price,
      this.quantity,
      this.prId,
      this.type, this.docId});

  @override
  State<ProductsDetials> createState() => _ProductsDetialsState();
}

class _ProductsDetialsState extends State<ProductsDetials> {
    CollectionReference cardCollection =
      FirebaseFirestore.instance.collection("product");
  var user;
  @override
  void initState() {
    super.initState();
    user=FirebaseAuth.instance.currentUser.uid;
    print( widget.docId);
  }
  final TextEditingController prQuantity = TextEditingController();

  TimeOfDay selectedstarTime = TimeOfDay.now();
  // ignore: non_constant_identifier_names
  String format_Star_Time = "";
  int total = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: drowAppBar("Product details", context),
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0.h),
              child: SizedBox(
                height: 250.h,
                width: double.infinity,
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20.r)),
                    child: Image.network(widget.image, fit: BoxFit.fill)),
              ),
            ),
//-------------------------------------------------
            SizedBox(height: 6.h),
            Padding(
              padding: EdgeInsets.all(10.0.h),
              child: SizedBox(
                height: 45.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    textDB(context, widget.prName, 16, black,
                        fontWeight: FontWeight.w700),
                    SizedBox(width: 10.h),
                    divider(),
                    SizedBox(width: 10.h),
                    textDB(
                        context,
                        "${widget.price} ${getTranslated(context, "SAR")}",
                        16,
                        black,
                        fontWeight: FontWeight.w700)
                  ],
                ),
                
              ),
            ),
//------------------------------------------------------
             textDB(context, "الكمية لمتوفرة ${widget.quantity}", 16, black,
                        fontWeight: FontWeight.w700),
                    SizedBox(width: 10.h),
            SizedBox(height: 10.h),
            showStardTime(),
//-------------------------------------------------

            Padding(
              padding: EdgeInsets.all(8.0.h),
              child: SizedBox(
                width: 160.w,
                child: CounterButton(
                  loading: false,
                  onChange: (int val) {
                    setState(() {
                      total = val;
                    });
                  },
                  count: total,
                  countColor: black,
                  buttonColor: deepYallow,
                  progressColor: deepYallow,
                ),
              ),
            ),
            textDB(
                context,
                "${getTranslated(context, "total")} " +
                    "${widget.price * total}",
                16,
                black,
                fontWeight: FontWeight.w700),

//-------------------------------------------------
            SizedBox(height: 20.h),
            CircleAvatar(
              radius: 30.r,
              backgroundColor: deepYallow,
              child: Center(
                  child: InkWell(
                      onTap: () {
                        if (format_Star_Time.isNotEmpty) {
                          if (total <= 0) {
                            dialog(context, "add to cart",
                                "The quantity must be at least one");
                          } else if (total > widget.quantity) {
                            dialog(context, "add to cart",
                                "Quantity is not enough");
                          } else {
                            dialog(context, "add to cart", "wating");
                            FirebaseFirestore.instance.collection("card").add({
                              "prName": widget.prName,
                              "total price": widget.price * total,
                              "StudentQuantity": total,
                              "prId": widget.prId,
                              "StudentId": user,
                              "type": widget.type,
                              "time":format_Star_Time
                            }).then((value) {
                              goTopage(context, StudentNavHome());
                            });
                          }
                        } else {
                          dialog(context, "Invalid data", "Fill in the field");
                        }
                      },
                      child:
                          Icon(Icons.add_shopping_cart_rounded, color: black))),
            )
          ],
        ));
  }

  //show receve time------------------------------------------------------------
  Widget showStardTime() {
    return container(
        50,
        150,
        8,
        8,
        Row(
          children: [
            Icon(Icons.punch_clock_rounded, size: 25.sp, color: deepYallow),
            SizedBox(
              width: 4,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _selectStarTime(context);
                });
              },
              child: format_Star_Time.isNotEmpty
                  ? textDB(context, "$format_Star_Time", 12, black)
                  : text(context, "Time of receipt", 12, black),
            )
          ],
        ),
        white,
        bottomLeft: 5.r,
        bottomRight: 5.r,
        topLeft: 5.r,
        topRight: 5.r,
        pL: 10.w,
        pR: 10.w,
        bored: Border.all(color: Colors.grey[600]));
  }

  // show clock----------------------------------------------------
  Future<TimeOfDay> _selectStarTime(BuildContext context) async {
    final TimeOfDay timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedstarTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null) {
      setState(() {
        selectedstarTime = timeOfDay;
        format_Star_Time = "${selectedstarTime.format(context)} ";
        return format_Star_Time;
      });
    }
    return null;
  }

  String validEmpty(String value) {
    if (value.isEmpty) {
      return getTranslated(context, "Fill in the field");
    }
  }
}
