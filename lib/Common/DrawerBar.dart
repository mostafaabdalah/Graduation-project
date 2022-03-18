import 'package:flutter/material.dart';
import 'package:hommey/Common/loading.dart';
import 'package:hommey/Login/Login.dart';
import 'package:hommey/Models/user.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DarwerBar extends StatefulWidget {
  @override
  _DarwerBarState createState() => _DarwerBarState();
}

class _DarwerBarState extends State<DarwerBar> {
  final List<Map<String, dynamic>> userData = [];

  @override
  void initState() {
    super.initState();
    getAllUserProducts();
  }

  getAllUserProducts() {
    http
        .get('https://hommey-b9aa6.firebaseio.com/user.json')
        .then((http.Response res) {
      final Map<String, dynamic> resData = json.decode(res.body);
      resData.forEach((String id, dynamic data) {
        if (data["email"] == new User().getUserName()) {
          final obj = {
            "id": id,
            "image": data["image"],
            "firstName": data["firstName"],
            "lastName": data["lastName"],
            "date": data["date"],
            "phone": data["phone"],
            "email": data["email"],
          };
          setState(() {
            userData.add(obj);
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
                flex: 4,
                child: userData.isEmpty
                    ? Loading()
                    : Container(
                        padding: EdgeInsets.all(10),
                        color: Colors.blue,
                        child: Column(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 60,
                              backgroundImage:
                                  NetworkImage(userData[0]['image']),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${userData[0]['firstName']} ${userData[0]['lastName']}',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Billabong',
                                  fontWeight: FontWeight.w300,
                                  letterSpacing: 2,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${userData[0]['email']}',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${userData[0]['phone']}',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      )),
            Expanded(
                flex: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    RaisedButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Login(),
                        ));
                      },
                      color: Colors.red,
                      colorBrightness: Brightness.dark,
                      icon: Icon(Icons.outlined_flag),
                      label: Text('Logout'),
                    ),
                  ],
                )),
          ],
        )),
      ),
    );
  }
}
