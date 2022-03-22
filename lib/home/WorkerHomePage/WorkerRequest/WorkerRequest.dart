import 'package:flutter/material.dart';
import 'package:save_break_time/Models/virables.dart';
class WorkerRequest extends StatefulWidget {
 

  @override
  State<WorkerRequest> createState() => _WorkerRequestState();
}

class _WorkerRequestState extends State<WorkerRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: deepYallow,
       body: Center(child: Text("request"),),
    );
  }
}