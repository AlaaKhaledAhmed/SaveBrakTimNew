import 'package:flutter/material.dart';
import 'package:save_break_time/Models/virables.dart';

import '../../Models/Methods.dart';
class BookWorkerNotification extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(context),
       appBar: drowAppBar("NOTIFICATION", context),
      backgroundColor: deepYallow,
      body: Center(child: Text("notification"),),
    );
  }
}