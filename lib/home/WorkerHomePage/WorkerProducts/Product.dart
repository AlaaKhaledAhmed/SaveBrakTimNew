import 'package:flutter/material.dart';
import 'package:save_break_time/Models/Methods.dart';
import 'package:save_break_time/Models/virables.dart';

class WorkerProductMainPage extends StatefulWidget {
  

  @override
  State<WorkerProductMainPage> createState() => _WorkerProductMainPageState();
}

class _WorkerProductMainPageState extends State<WorkerProductMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: deepYallow,
       body: continerBackgroundImage(
         '$productImage',
         padding(20, 20, 50, Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
          
           text(context, 'Available Products', 20, deepWhite ,fontWeight: FontWeight.w700),
         ],)),
         filterColor: black.withOpacity(.7),
         ),
    );
  }
}