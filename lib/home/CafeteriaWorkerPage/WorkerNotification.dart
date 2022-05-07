import 'package:flutter/material.dart';
import 'package:save_break_time/Models/virables.dart';

import '../../Models/Methods.dart';
class WorkerNotification extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       drawer: drawer(context),
       appBar: drowAppBar("NOTIFICATION", context),
      
      body: Center(child: Text("notification"),),
    );
  }
}