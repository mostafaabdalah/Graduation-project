import 'package:flutter/material.dart';
import 'package:hommey/Common/Bottombar.dart';
import 'package:hommey/Common/DrawerBar.dart';
import 'package:hommey/Common/loading.dart';
import 'package:hommey/Models/user.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PositiveComent extends StatefulWidget {

  String email;
  PositiveComent({this.email});

  @override
  _PositiveComentState createState() => _PositiveComentState();
}

class _PositiveComentState extends State<PositiveComent> {
  final List<Map<String, dynamic>> userComment = [];
  int counter = 0;

  @override
  void initState() {
    super.initState();
    getAllUserComment();
  }

  getAllUserComment() {
     String theEmail;
    if (widget.email.length < 0) {
      theEmail = new User().getUserName();
    } else {
      theEmail = widget.email;
    }
    http
        .get('https://hommey-b9aa6.firebaseio.com/Comments.json')
        .then((http.Response res) {
      print('i am in commen functio2');

      final Map<String, dynamic> resData = json.decode(res.body);
      resData.forEach((String id, dynamic data) {
        if (data["chef"] == theEmail) {
          counter++;
          final obj = {
            "id": id,
            "image": data["image"],
            "chef": data["chef"],
            "name": data["name"].toString().split("@")[0],
            "postedin": data["postedin"],
            "rate": data["rate"],
            "review": data["review"],
          };
          setState(() {
            userComment.add(obj);
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          'Comment',
                          style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 3,
                              fontFamily: 'Billabong',
                              fontSize: 25,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: SingleChildScrollView(
                child: userComment.isEmpty
                    ? Loading()
                    : Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    '${counter}',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    'Comments',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Raleway'),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Column(
                              children: userComment
                                  .map((e) => SingleComment(
                                        e["image"],
                                        e["name"],
                                        e["postedin"],
                                        e["rate"],
                                        e["review"],
                                      ))
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(),
      drawer: DarwerBar(),
    );
  }
}

Widget SingleComment(image, name, postedin, rate, review) {
  return Container(
    child: ListTile(
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(image),
      ),
      title: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              '${name.split("@")[0]}',
              style: TextStyle(fontSize: 20),
            ),
            Container(
                margin: EdgeInsets.only(left: 20),
                child: Row(
                  children: <Widget>[
                    Text('${rate}'),
                    SizedBox(
                      width: 10,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
      subtitle: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(review),
              ),
            ),
            Container(
              child: Text('${postedin}'),
            )
          ],
        ),
      ),
    ),
  );
}
