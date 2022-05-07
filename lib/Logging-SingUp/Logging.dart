import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:save_break_time/Animation/FadeAnimation.dart';
import 'package:save_break_time/Models/AleartDilolg.dart';
import 'package:save_break_time/Models/Methods.dart';
import 'package:save_break_time/Models/virables.dart';
import 'package:save_break_time/home/CafeteriaWorkerPage/WorkerNavHome.dart';
import 'package:save_break_time/localization/localization_methods.dart';

import '../home/BookStore/BookWorkerNavHome.dart';
import '../home/StudentHomePage/SudentNavHome.dart';
import 'SingUp.dart';

class Logging extends StatefulWidget {
  Logging({Key key}) : super(key: key);

  @override
  _LoggingState createState() => _LoggingState();
}

class _LoggingState extends State<Logging> {
//TextEditingController-------------------------------------------------------

  TextEditingController emailLoginController = TextEditingController();
  TextEditingController passLoginController = TextEditingController();
  GlobalKey<FormState> loggingKey = new GlobalKey();
  bool userFound;
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
              children: [
                //image----------
                image(logoPath, BoxFit.cover),
                SizedBox(
                  height: space,
                ),
                //text----------
                text(context, 'SING IN', 20, deepYallow,
                    fontWeight: FontWeight.w700),
                SizedBox(
                  height: space,
                ),
                Form(
                    key: loggingKey,
                    child: Column(
                      children: [
                        //emali textField-------------
                        textField(context, emailIcon, noIcon, emailHint,
                            hiddText, emailLoginController, validEmail),
                        SizedBox(
                          height: space,
                        ),
                        //pass textField-------------
                        textField(context, passIcon, showPassIcon, passHint,
                            showText, passLoginController, validEmpty),
                        SizedBox(
                          height: space,
                        ),
                        //logging buttom-----------
                        FadeAnimation(
                          2,
                          buttoms(
                              context,
                              singIn,
                              14.0,
                              deepGrey,
                              () => singInApplication(emailLoginController.text,
                                  passLoginController.text),
                              backgrounColor: deepYallow,
                              evaluation: 5),
                        ),
                        SizedBox(
                          height: space,
                        ),
                        //sing up bouttom----------------------------------------------------------------
                        FadeAnimation(
                            2,
                            buttoms(context, singUp, 14.0, deepYallow,
                                () => goTopage(context, SingUp()),
                                evaluation: 0)),
                        SizedBox(
                          height: space + 247,
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

  //-----------------------------------------------------------------------
  singInApplication(String emile, String pass) async {
    FormState validLogging = loggingKey.currentState;

    if (validLogging.validate()) {
      try {
        dialog(context, 'SING IN', 'wating');
        var userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: emile.trim(), password: pass);

        if (userCredential != null) {
          if (passLoginController.text == "123456789" &&
              emailLoginController.text == "bookworker@gmail.com") {
            goTopageReplace(context, BookWorkerNavHome());
            passLoginController.clear();
            emailLoginController.clear();
          } else if (passLoginController.text == "123456789" &&
              emailLoginController.text == "cafworker@gmail.com") {
            goTopageReplace(context, WorkerNavHome());
            passLoginController.clear();
            emailLoginController.clear();
          } else {
            goTopageReplace(context, StudentNavHome());
            passLoginController.clear();
            emailLoginController.clear();
          }
        }
      } on FirebaseException catch (e) {
        Navigator.pop(context);
        if (e.code == 'user-not-found') {
          dialog(context, "Invalid data", "user not found");
        } else if (e.code == 'wrong-password') {
          dialog(context, "Invalid data", "user not found");
        }
      }
    } else {
      dialog(context, "Invalid data", "Verify");
    }
  }

  //---------------------valid methods------------------------------------------------------
  // ignore: missing_return
  String validEmail(String value) {
    if (value.trim().isEmpty) {
      return getTranslated(context, "Fill in the field");
    }
    if (EmailValidator.validate(value.trim()) == false) {
      return 'Invalid email';
    }
  }

  //--------------------------------------------------
  // ignore: missing_return
  String validEmpty(String value) {
    if (value.isEmpty) {
      return getTranslated(context, "Fill in the field");
    }
  }
}
