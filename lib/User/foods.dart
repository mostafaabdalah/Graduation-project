import 'package:flutter/material.dart';
import 'package:hommey/Common/Bottombar.dart';
import 'package:hommey/Common/DrawerBar.dart';
import 'package:hommey/Common/loading.dart';
import 'package:hommey/Home/SingleFood.dart';
import 'package:hommey/Models/user.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Foods extends StatefulWidget {
  String image;
  String email;

  Foods({this.image, this.email});

  @override
  _FoodsState createState() => _FoodsState();
}

class _FoodsState extends State<Foods> {
  final List<Map<String, dynamic>> userFood = [];
  int counter = 0;

  @override
  void initState() {
    super.initState();
    getAllUserProducts();
  }

  getAllUserProducts() {
    String theEmail;
    if (widget.email.length < 0) {
      theEmail = new User().getUserName();
    } else {
      theEmail = widget.email;
    }

    http
        .get('https://hommey-b9aa6.firebaseio.com/products.json')
        .then((http.Response res) {
      print('i am in home functio2');

      final Map<String, dynamic> resData = json.decode(res.body);
      resData.forEach((String id, dynamic data) {
        if (data["email"] == theEmail) {
          counter++;
          final obj = {
            "id": id,
            "image": data["image"],
            "name": data["name"],
            "price": data["price"],
            "category": data["category"],
            "address": data["address"],
            "email": data["email"],
            "inger": data["inger"],
            "dis": data["dis"],
            "time": data["time"]
          };
          setState(() {
            userFood.add(obj);
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
                          'Chef Food',
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
            SingleChildScrollView(
              child: Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(children: <Widget>[
                        ListTile(
                          title: Text(
                            'Find Your Food...',
                            style: TextStyle(
                                fontSize: 15,
                                letterSpacing: 1,
                                color: Colors.black54),
                          ),
                          leading: CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(widget.image),
                          ),
                        ),
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
                                'Food',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Raleway'),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 580,
                          child: userFood.isEmpty
                              ? Loading()
                              : GridView.count(
                                  crossAxisCount: 2,
                                  childAspectRatio: 2.3 / 3,
                                  children: userFood
                                      .map((e) => new SingleFood(
                                            id: e["id"],
                                            image: e["image"],
                                            name: e["name"],
                                            price: e["price"].toString(),
                                            category: e["category"],
                                            address: e["address"],
                                            email: e["email"],
                                            inger: e["inger"],
                                            dis: e["dis"],
                                            time: e["time"].toString(),
                                          ))
                                      .toList(),
                                ),
                        ),
                      ]),
                    ]),
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
