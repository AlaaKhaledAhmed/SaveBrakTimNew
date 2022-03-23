import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:save_break_time/Models/Methods.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Models/AleartDilolg.dart';
import '../../../Models/virables.dart';
import '../../../localization/localization_methods.dart';

class AddProduct extends StatefulWidget {
  AddProduct({Key key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final TextEditingController prName = TextEditingController();
  final TextEditingController prPrice = TextEditingController();
  final TextEditingController prQuantity = TextEditingController();

  String validEmpty(String value) {
    if (value.isEmpty) {
      return getTranslated(context, "Fill in the field");
    }
  }

  File imagePath;
  String userId;
  Color color = deepYallow;
  GlobalKey<FormState> productKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    userId = FirebaseAuth.instance.currentUser.uid;
    print(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: drowAppBar("Add products", context),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(height: 20.h),
//image-----------------------------------------------------------
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  pickImageGallery();
                },
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color,
                    border: Border.all(color: color, width: 2),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 0.0,
                        spreadRadius: 0.0,
                      )
                    ],
                  ),
                  child: imagePath != null
                      ? CircleAvatar(
                          backgroundImage: FileImage(imagePath),
                          radius: 200.0,
                        )
                      : Icon(
                          Icons.image,
                          color: white,
                          size: 50.sp,
                        ),
                ),
              ),
            ),
            SizedBox(height: 15.h),
//-------------------------------------------------------------------------------------------

            Expanded(
              flex: 2,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Form(
                    key: productKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 15.h),
//name-----------------------------------------------------------
                        textField(
                          context,
                          nameIcon,
                          noIcon,
                          "product name",
                          hiddText,
                          prName,
                          validEmpty,
                          keyboardType: TextInputType.text,
                          inputFormatters: [
                            FilteringTextInputFormatter(
                                RegExp(r'[a-zA-Z]|[أ-ي]|[ؤ-ئ-لا-لأ-]|[ء]|[ ]'),
                                allow: true)
                          ],
                        ),

                        SizedBox(height: 10.h),
//price-----------------------------------------------------------
                        textField(
                          context,
                          nameIcon,
                          noIcon,
                          "price",
                          hiddText,
                          prPrice,
                          validEmpty,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                        SizedBox(height: 10.h),
//quantity-----------------------------------------------------------
                        textField(
                          context,
                          nameIcon,
                          noIcon,
                          "Quantity",
                          hiddText,
                          prQuantity,
                          validEmpty,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),

                        SizedBox(height: 10.h),
//add buttom----------------------------------------------------------------
                        buttoms(context, "Add", 14.0, black, () {
                          addProduct();
                        }, backgrounColor: deepYallow),
                      ],
                    ),
                  ),
                ),
              ),
            )
//textfield-----------------------------------------------------------
          ],
        ),
      ),
    );
  }

  //pick Image from Gallery
  pickImageGallery() async {
    var imagepeket = await ImagePicker().getImage(source: ImageSource.gallery);
    if (imagepeket != null) {
      setState(() {
        imagePath = File(imagepeket.path);
        color = Colors.transparent;
      });
    }
  }

  Future<void> addProduct() async {
    if ((imagePath == null && productKey.currentState.validate() == false ||
        imagePath == null)) {
      setState(() {
        color = Colors.red;
      });
      dialog(context, "Empty data", "Fill in the field");
    } else if (productKey.currentState.validate()) {
      setState(() {
        color = deepYallow;
      });
      dialog(context, 'Add products', 'wating');
      await FirebaseFirestore.instance.collection('product').add({
        "userID": userId,
        'prName': prName.text,
        'prPrice': prPrice.text,
        'prQuantity': prQuantity.text,
        'imagePath': ''
      }).then((value) {
        Navigator.pop(context);
        dialog(
          context,
          "Process completed",
          "successfully",
        );
        
      }).catchError((e) {
        Navigator.pop(context);
        dialog(
          context,
          "Connection error",
          "connectionError",
        );
      });
    } else {
      setState(() {
        color = Colors.red;
      });
      dialog(context, "Empty data", "Fill in the field");
    }
  }
}
