import 'package:flutter/material.dart';

import '../../Models/Methods.dart';
class RequestMain extends StatefulWidget {
  RequestMain({Key key}) : super(key: key);

  @override
  State<RequestMain> createState() => _RequestMainState();
}

class _RequestMainState extends State<RequestMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(context),
       appBar: drowAppBar("REQUEST", context),
      body: Center(child:Text("request")));
  }
}