import 'package:flutter/material.dart';
import 'package:hommey/Common/Bottombar.dart';
import 'package:hommey/Common/loading.dart';
import 'package:hommey/Models/user.dart';
import 'package:hommey/User/foods.dart';
import 'package:hommey/User/positiveComment.dart';
import 'package:hommey/profile/profile_details.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  String name = '';
  ProfilePage({this.name});
  String theEamil;


  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final List<Map<String, dynamic>> userData = [];

  @override
  void initState() {
    super.initState();
    getAllUserProducts();
  }

  getAllUserProducts() {
    if (widget.name.length < 0) {
      widget.theEamil = new User().getUserName();
    } else {
      widget.theEamil = widget.name;
    }

    http
        .get('https://hommey-b9aa6.firebaseio.com/user.json')
        .then((http.Response res) {
      final Map<String, dynamic> resData = json.decode(res.body);
      resData.forEach((String id, dynamic data) {
        if (data["email"] == widget.theEamil) {
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
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/1.jpg'),
              fit: BoxFit.fill,
            ),
          ),
          child: userData.isEmpty
              ? Loading()
              : Column(children: <Widget>[
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
                                'profile',
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
                  SafeArea(
                    child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: <Widget>[
                            Center(
                              child: Column(
                                children: <Widget>[
                                  CircleAvatar(
                                    radius: 70,
                                    backgroundImage:
                                        NetworkImage(userData[0]["image"]),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        '${userData[0]["firstName"]} ${userData[0]["lastName"]} ',
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontFamily: 'Raleway',
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1,
                                            color: Colors.black),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        '${userData[0]["email"]}',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'Raleway',
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1,
                                            color: Colors.black),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        '${userData[0]["phone"]}',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'Raleway',
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1,
                                            color: Colors.black),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Table(
                      children: [
                        TableRow(children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Foods(
                                        image: userData[0]["image"],
                                        email: widget.theEamil,
                                      )));
                            },
                            child: ProfileDetails(
                              sub: "Chef Food",
                              icon: Icon(
                                Icons.restaurant,
                                color: Colors.blue[300],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PositiveComent(
                                  email: widget.theEamil,
                                ),
                              ));
                            },
                            child: ProfileDetails(
                              sub: " Comment",
                              icon: Icon(
                                Icons.comment,
                                color: Colors.blue[300],
                              ),
                            ),
                          ),
                        ]),
                      ],
                    ),
                  ),
                ]),
        ),
      ),
      bottomNavigationBar: new BottomBar(),
    );
  }
}
