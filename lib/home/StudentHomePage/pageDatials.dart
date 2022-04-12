import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_break_time/localization/localization_methods.dart';
import '../../Models/Methods.dart';
import '../../Models/virables.dart';
import 'SudentNavHome.dart';

class ProductsDetials extends StatefulWidget {
  final String image;
  final String prName;
  final String price;
  final String quantity;
  final String prId;

  const ProductsDetials(
      {this.image, this.prName, this.price, this.quantity, this.prId});

  @override
  State<ProductsDetials> createState() => _ProductsDetialsState();
}

class _ProductsDetialsState extends State<ProductsDetials> {
  final TextEditingController prQuantity = TextEditingController();

  TimeOfDay selectedstarTime = TimeOfDay.now();
  // ignore: non_constant_identifier_names
  String format_Star_Time = "";
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
                        widget.price + " ${getTranslated(context, "SAR")}",
                        16,
                        black,
                        fontWeight: FontWeight.w700)
                  ],
                ),
              ),
            ),
//------------------------------------------------------
            SizedBox(height: 10.h),
            showStardTime(),
//-------------------------------------------------

            Padding(
              padding: EdgeInsets.all(8.0.h),
              child: textField(
                context,
                Icons.production_quantity_limits,
                noIcon,
                "Quantity",
                hiddText,
                prQuantity,
                validEmpty,
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
//-------------------------------------------------
SizedBox(height: 20.h),
           CircleAvatar(
             radius: 30.r,
             backgroundColor:deepYallow,
             child: Center(child:InkWell(onTap:() {
             print("adddddd");  
             },child: Icon(Icons.add_shopping_cart_rounded,color:black))),
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
                : textDB(context, "زمن الاستلام", 12, black),
          )
        ],
      ),
      white,
      
      bottomLeft: 10.r,
      bottomRight: 10.r,
      topLeft: 10.r,
      topRight: 10.r,
      pL: 10.w,
      pR: 10.w,
      bored: Border.all(color: Colors.grey[600]) 
    );
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
