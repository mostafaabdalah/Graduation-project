import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hommey/Common/Alert.dart';
import 'package:hommey/Models/user.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';

class SingleNot extends StatefulWidget {
  String id;
  String user;
  String order;
  String time;
  String userImage;
  SingleNot({this.id, this.user, this.order, this.time, this.userImage});

  @override
  _SingleNotState createState() => _SingleNotState();
}

class _SingleNotState extends State<SingleNot> {
  final db = Firestore.instance;

  final List<Map<String, dynamic>> userData = [];

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
  void initState() {
    super.initState();
    getAllUserProducts();
  }

  @override
  Widget build(BuildContext context) {
    bool done = true;

    return done
        ? Container(
            margin: EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[350],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  bottomLeft: Radius.circular(40),
                ),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    child: ListTile(
                      title: Text(
                        '${widget.user}',
                        style: TextStyle(
                            fontSize: 20,
                            letterSpacing: 1,
                            color: Colors.black),
                      ),
                      subtitle: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              '${widget.order}',
                              style: TextStyle(color: Colors.black),
                            ),
                            Text(
                              '${widget.time.substring(widget.time.split(".")[0].length - 8).split('.')[0]}',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(widget.userImage),
                      ),
                      trailing: Container(
                          child: IconButton(
                              icon: Icon(
                                Icons.report,
                                color: Colors.red[300],
                              ),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => AlertF(
                                    type: 'Report',
                                  ),
                                ));
                              })),
                    ),
                  ),
                  !widget.order.startsWith('Ordered:')
                      ? Container(
                          child: ButtonBar(
                            children: <Widget>[
                              RaisedButton.icon(
                                color: Colors.green,
                                label: Text('Accept'),
                                icon: Icon(Icons.check),
                                onPressed: () {
                                  setState(() {
                                    done = false;
                                  });

                                  Map<String, dynamic> res = {
                                    'user': new User().getUserName(),
                                    'userImage': userData[0]["image"],
                                    'order': 'Accept the order ${widget.order}',
                                    'email': widget.user,
                                    'time': new DateTime.now().toString(),
                                  };
                                  http
                                      .post(
                                          'https://hommey-b9aa6.firebaseio.com/Notifications.json',
                                          body: json.encode(res))
                                      .then((value) {});
                                },
                              ),
                              RaisedButton.icon(
                                color: Colors.red,
                                label: Text('Refuse'),
                                icon: Icon(Icons.no_encryption),
                                onPressed: () {
                                  setState(() {
                                    done = true;
                                  });
                                  Map<String, dynamic> res = {
                                   'user': new User().getUserName(),
                                    'userImage': userData[0]["image"],
                                    'order': 'Refuse the order ${widget.order}',
                                    'email': widget.user,
                                    'time': new DateTime.now().toString()
                                  };
                                  http
                                      .post(
                                          'https://hommey-b9aa6.firebaseio.com/Notifications.json',
                                          body: json.encode(res))
                                      .then((value) {});
                                },
                              ),
                            ],
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          )
        : Container();
  }
}
