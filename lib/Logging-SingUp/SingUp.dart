import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:save_break_time/Animation/FadeAnimation.dart';
import 'package:save_break_time/Models/AleartDilolg.dart';
import 'package:save_break_time/Models/Methods.dart';
import 'package:save_break_time/Models/virables.dart';
import 'package:save_break_time/localization/localization_methods.dart';

import 'Logging.dart';

class SingUp extends StatefulWidget {
  SingUp({Key key}) : super(key: key);

  @override
  _SingUpState createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController levelController = TextEditingController();
  TextEditingController collegController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  GlobalKey<FormState> singUpKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: continerBackgroundImage(
      welcomBacgroundImage,
      padding(
        20,
        20,
        30,
        Center(
          child: SingleChildScrollView(
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                //image----------
                image(logoPath, BoxFit.cover),
                SizedBox(
                  height: space,
                ),
                //image----------
                text(context, 'Create a new account', 20, deepYallow,
                    fontWeight: FontWeight.w700),
                SizedBox(
                  height: space,
                ),
                Form(
                    key: singUpKey,
                   
                    child: Column(
                      children: [
                        //name textfiled-----------
                        textField(context, nameIcon, noIcon, nameHint, hiddText,
                            nameController, validEmpty),
                        SizedBox(
                          height: space,
                        ),
                        //emali textField-------------
                        textField(context, emailIcon, noIcon, emailHint,
                            hiddText, emailController, validEmail),
                        SizedBox(
                          height: space,
                        ),
                        //pass textField-------------
                        textField(context, passIcon, showPassIcon, passHint,
                            showText, passController, validEmpty),
                        SizedBox(
                          height: space,
                        ),
                        //colleg textField-------------
                        textField(context, collegIcon, noIcon, collegHint,
                            hiddText, collegController, validEmpty),
                        SizedBox(
                          height: space,
                        ),
                        //level textField-------------
                        textField(context, levelIcon, noIcon, levelHint,
                            hiddText, levelController, validEmpty),
                        SizedBox(
                          height: space,
                        ),
                        //phone textField-------------
                        textField(context, phoneIcon, noIcon, phoneHint,
                            hiddText, phoneController, validPhone),
                        SizedBox(
                          height: space,
                        ),
                        //sing up bouttom----------------------------------------------------------------
                        FadeAnimation(
                            2,
                            buttoms(context, singUp, 14.0, deepGrey, () {
                              createAccount(
                                nameController,
                                emailController,
                                passController,
                                collegController,
                                levelController,
                                phoneController,
                              );
                            }, backgrounColor: deepYallow, evaluation: 5)),
                        SizedBox(
                          height: space,
                        ),
                        //logging bouttom----------------------------------------------------------------
                        FadeAnimation(
                            2,
                            buttoms(
                              context,
                              singIn,
                              14.0,
                              deepYallow,
                              () => goTopage(context, Logging()),
                              evaluation: 0,
                            )),
                        SizedBox(
                          height: space,
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    ));
  }

//sing up method-----------------------------------------------------
  createAccount(name, emile, pass, colleg, level, phone) async {
    FormState validData = singUpKey.currentState;
    if (validData.validate()) {
      try {
        //يتم اضافه المستخدم الي قاعده البيانات
        dialog(context,'Create a new account', 'wating');

        var userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emile.text.trim(),
          password: pass.text,
        );
        //في حاله تمت الاضافه بنجاح سيتولد ايدي للمستخدم فيجب اختبار القيمه
        var userID = userCredential.user.uid;

        if (userID != null) {
          if (userCredential != null) {
            await FirebaseFirestore.instance.collection('user').add({
              "userID": userID,
              'name': name.text,
              'Emile': emile.text,
              'pass': pass.text,
              'colleg': colleg.text,
              'level': level.text,
              'phone': phone.text,
            })

                //التحقق ما اذا تمت العمليه بنجاح ام لا
                .then((value) {
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
          Navigator.pop(context);
          dialog(context, "The operation failed",
              "The operation was not completed successfully");
        }
      } on FirebaseException catch (e) {
        //لاخفاء حوار الانتظار===
        Navigator.pop(context);
        if (e.code == 'weak-password') {
          dialog(
            context,
            "Invalid password",
            "Weak password",
          );
        }
        if (e.code == 'email-already-in-use') {
          dialog(
            context,
            "Invalid email",
            "Email already in use",
          );
        }
      } catch (e) {
         dialog(
            context,
            "Invalid password",
            e.toString(),
          );
        print(e);
      }


    } else {
      dialog(context, "Empty data", "Fill in the field");
    }
  }

//--------------------validit methods--------------------------------------------
  // ignore: missing_return
  String validEmpty(String value) {
    if (value.isEmpty) {
      return getTranslated(context, "Fill in the field");
    }
  }

//--------------------------------------------------
  // ignore: missing_return
  String validPhone(String value) {
    if (value.isEmpty) {
      return getTranslated(context, "Fill in the field");
    }
    if (value.length < 10 || value.length > 10) {
      return getTranslated(context, 'The mobile number must be 10 digits');
    }
    if (!value.startsWith('05')) {
      return getTranslated(context, 'Mobile number must start with 05');
    }
  }

//--------------------------------------------------
  // ignore: missing_return
  String validEmail(String value) {
    if (value.trim().isEmpty) {
      return getTranslated(context, "Fill in the field");
    }
    if (EmailValidator.validate(value.trim()) == false) {
      return 'Invalid email';
    }
  }
}
