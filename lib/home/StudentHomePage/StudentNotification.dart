import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Models/Methods.dart';
import '../../Models/virables.dart';

class StudentNotification extends StatefulWidget {
  StudentNotification({Key key}) : super(key: key);

  @override
  State<StudentNotification> createState() => _StudentNotificationState();
}

class _StudentNotificationState extends State<StudentNotification> {
  String userId = '';
  @override
  void initState() {
    super.initState();
    userId = FirebaseAuth.instance.currentUser.uid;
  }

  List userRecord = [];
  CollectionReference messegeCollection =
      FirebaseFirestore.instance.collection("messege");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: drawer(context),
        appBar: drowAppBar("NOTIFICATION", context),
        body: continerBackgroundImage(
          '$welcomBacgroundImage',
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            //color: green,
            child: StreamBuilder(
                stream: messegeCollection
                    .where("userId", isEqualTo: userId)
                    .orderBy('createOn', descending: true)
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshat) {
                  if (snapshat.hasError) {
                    print("errrrrrrrrorrrrrrrrrr");
                  }
                  if (snapshat.hasData) {
                    return getUsers(context, snapshat);
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
        ));
  }

  //show products-------------------------------
  Widget getUsers(BuildContext context, AsyncSnapshot snapshat) {
    return snapshat.data.docs.length > 0
        ? Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.0.w, vertical: 14.h),
            child: ListView.builder(
                itemCount: snapshat.data.docs.length,
                itemBuilder: (context, i) {
                  print(
                    snapshat.data.docs.length,
                  );
//delete----------------------------------------------------------
                  return SizedBox(
                    height: 100.h,
                    child: Card(
                      elevation: 5,
                      color: white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          side: BorderSide(color: deepYallow, width: 2)),
                      child: Column(
                        children: [
                          getData(
                              '${snapshat.data.docs[i].data()['masseg']}',
                              '${snapshat.data.docs[i].data()['date']} -' +
                                  ' ${snapshat.data.docs[i].data()['time']}'),
                          SizedBox(height: 5.w),
                        ],
                      ),
                    ),
                  );
                }),
          )
        : Center(child: textDB(context, "لاتوجد اشعارات حاليا", 15, black));
  }

//get data from database--------------------------------------
  Widget getData(text, String subtitle) {
    return Expanded(
      child: ListTile(
          title: textDB(context, text, 12, black),
          leading: CircleAvatar(
            radius: 20.r,
            backgroundColor: deepYallow,
            child: Center(child: Icon(notificationsIcon)),
          ),
          subtitle: textDB(context, subtitle, 12, deepYallow)),
    );
  }
}
