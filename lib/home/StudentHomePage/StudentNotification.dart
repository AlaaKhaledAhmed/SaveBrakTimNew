import 'package:flutter/material.dart';

import '../../Models/Methods.dart';
class StudentNotification extends StatefulWidget {
  StudentNotification({Key key}) : super(key: key);

  @override
  State<StudentNotification> createState() => _StudentNotificationState();
}

class _StudentNotificationState extends State<StudentNotification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(context),
       appBar: drowAppBar("NOTIFICATION", context),
      body: Center(child:Text("notifcaion")));
  }
}