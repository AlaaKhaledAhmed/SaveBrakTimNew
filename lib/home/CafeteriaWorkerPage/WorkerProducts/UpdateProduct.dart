import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:save_break_time/Models/Methods.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Models/AleartDilolg.dart';
import '../../../Models/virables.dart';
import '../../../localization/localization_methods.dart';
import 'package:path/path.dart' as Path;

class UpdateProduct extends StatefulWidget {
  final addImage;
  final addPrice;
  final addQuantity;
  final addName;
  final addId;

  UpdateProduct(
      {this.addName,
      this.addImage,
      this.addPrice,
      this.addId,
      this.addQuantity});

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
   TextEditingController prName ;
   TextEditingController prPrice ;
   TextEditingController prQuantity ;
  
  String imageName;
  Reference imageRef;
  String imageURL;
  File fileImage;
  String userId;
  Color color = deepYallow;
  GlobalKey<FormState> productKey = GlobalKey();
// ignore: missing_return
  String validEmpty(String value) {
    if (value.isEmpty) {
      return getTranslated(context, "Fill in the field");
    }
  }

  @override
  void initState() {
    super.initState();
    userId = FirebaseAuth.instance.currentUser.uid;
  }

  @override
  Widget build(BuildContext context) {
    prName = TextEditingController(text: widget.addName);
    prPrice = TextEditingController(text: widget.addPrice);
    prQuantity = TextEditingController(text: widget.addQuantity);
    return Scaffold(
      appBar: drowAppBar("Edit products", context),
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
                  child: Image.network(
                    "${widget.addImage}",
                    fit: BoxFit.cover,
                    width: double.infinity,
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
                          onChanged:(valu){
                           prName.text=valu;
                          }
                        ),

                        SizedBox(height: 10.h),
//price-----------------------------------------------------------
                        textField(
                          context,
                          nameIcon,
                          priceIcon,
                          "price",
                          hiddText,
                          prPrice,
                          validEmpty,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onChanged:(valu){
                           prPrice.text=valu;
                          }
                        ),
                        SizedBox(height: 10.h),
//quantity-----------------------------------------------------------
                        textField(
                          context,
                          nameIcon,
                          quantityIcon,
                          "Quantity",
                          hiddText,
                          prQuantity,
                          validEmpty,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onChanged:(valu){
                           prQuantity.text=valu;
                          }
                        ),

                        SizedBox(height: 10.h),
//add buttom----------------------------------------------------------------
                        buttoms(context, "Edit", 14.0, black, () {
                          updateProduct();
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
        color = Colors.transparent;
        fileImage = File(imagepeket.path);
        imageName = Path.basename(imagepeket.path);
        imageRef =
            FirebaseStorage.instance.ref("productImage").child("$imageName");
      });
    }
  }

//--------------------------------------------------------------------
  Future<void> updateProduct() async {
    if (productKey.currentState.validate()) {
       dialog(context, 'Edit products', 'wating');
      if (fileImage == null) {
        await FirebaseFirestore.instance
            .collection('product')
            .doc(widget.addId)
            .update({
          'prName': prName.text,
          'prPrice': prPrice.text,
          'prQuantity': prQuantity.text,
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
       
        await imageRef.putFile(fileImage);
        imageURL = await imageRef.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('product')
            .doc(widget.addId)
            .update({
          'prName': prName.text,
          'prPrice': prPrice.text,
          'prQuantity': prQuantity.text,
          'imagePath': imageURL
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
      }
    } else {
      setState(() {
        color = Colors.red;
      });
      dialog(context, "Empty data", "Fill in the field");
    }
  }
}
