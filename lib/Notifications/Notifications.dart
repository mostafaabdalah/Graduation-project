import 'package:flutter/material.dart';
import 'package:hommey/Common/Bottombar.dart';
import 'package:hommey/Common/DrawerBar.dart';
import 'package:hommey/Common/loading.dart';
import 'package:hommey/Models/user.dart';
import 'package:hommey/Notifications/SingleNoti.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List<Map<String, dynamic>> nots = [ ];

  getAllNotifications() {

    http
        .get('https://hommey-b9aa6.firebaseio.com/Notifications.json')
        .then((http.Response res) {
      final Map<String, dynamic> resData = json.decode(res.body);
      resData.forEach((String id, dynamic data) {
        if (data["email"] == new User().getUserName()) {
          final obj = {
            "id": id,
            "email": data["email"],
            "order": data["order"],
            "time": data["time"],
            "user": data["user"],
            "userImage": data["userImage"],
          };
          print('not2');
          setState(() {
            nots.add(obj);
          });
        }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllNotifications();
  }

  @override
  Widget build(BuildContext context) {
    // print('***********************${nots.map((e) => e["id"])}');
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
            child: Column(
          children: <Widget>[
            Container(
              color: Colors.orange[900],
              height: 55,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                          onPressed: () {
                          Navigator.of(context).pop();
                          }),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          'Notifications',
                          style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 3,
                              fontFamily: 'Billabong',
                              fontSize: 25,
                              fontWeight: FontWeight.w300),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: nots.isEmpty
                  ? Loading()
                  : SingleChildScrollView(
                      child: Column(
                        children: nots
                            .map((e) => SingleNot(
                                id:e["id"],
                                order: e['order'],
                                time: e['time'],
                                user: e['user'],
                                userImage: e['userImage']))
                            .toList(),
                      ),
                    ),
            ),
          ],
        )),
        bottomNavigationBar: new BottomBar(),
      ),
    );
  }
}
