import 'package:flutter/material.dart';
import 'package:hommey/Common/Alert.dart';
import 'package:hommey/Common/Bottombar.dart';
import 'package:hommey/Common/DrawerBar.dart';
import 'package:hommey/Models/user.dart';
import 'package:hommey/profile/Profile_Page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Details extends StatefulWidget {
  String id;
  String image;
  String name;
  String price;

  String category;
  String address;
  String email;
  String inger;
  String dis;
  String time;

  Details(
      {this.time,
      this.id,
      this.image,
      this.name,
      this.price,
      this.address,
      this.category,
      this.dis,
      this.email,
      this.inger});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
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
    return MaterialApp(
        home: Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  Colors.white,
                  Colors.white,
                ],
              ),
            ),
            child: Container(
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
                                'Details',
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
                  Container(
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                      ),
                      image: DecorationImage(
                          image: NetworkImage(
                            widget.image,
                          ),
                          fit: BoxFit.fill),
                    ),
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.all(5)),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                '${widget.name}',
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.black,
                                    letterSpacing: 2,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                '${widget.price} EGP',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    letterSpacing: 2,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.bold),
                              ),
                              Padding(padding: EdgeInsets.all(10)),
                              Container(
                                margin: EdgeInsets.only(left: 15, right: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.location_on,
                                              color: Colors.blue,
                                            ),
                                            Text(
                                              '${widget.address}',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(padding: EdgeInsets.only(left: 30)),
                                    Container(
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.yellow.withOpacity(0.9),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        padding: EdgeInsets.all(2),
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Row(
                                            children: <Widget>[
                                              Icon(
                                                Icons.timer,
                                                color: Colors.green,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'Avilable',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    letterSpacing: 1,
                                                    color: Colors.green),
                                              ),
                                            ],
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Ingredients'),
                              SizedBox(
                                height: 10,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                    // margin: EdgeInsets.,
                                    // color: Colors.amber,
                                    width: 200,
                                    height: 200,
                                    child: ListView.builder(
                                      itemCount:
                                          widget.inger.split(" * ").length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          title: Text(
                                              widget.inger.split(" * ")[index]),
                                        );
                                      },
                                    )),
                              ),
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.directions_bike,
                                      color: Colors.green,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      '${widget.time} min',
                                      style: TextStyle(
                                          fontSize: 20,
                                          letterSpacing: 1,
                                          color: Colors.green),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        '${widget.email}',
                                        style: TextStyle(
                                            fontSize: 20,
                                            letterSpacing: 1,
                                            fontFamily: 'Raleway',
                                            fontWeight: FontWeight.bold),
                                      ),
                                      IconButton(
                                          icon: Icon(Icons.arrow_forward),
                                          onPressed: () {
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                              builder: (context) => ProfilePage(
                                                name: widget.email,
                                              ),
                                            ));
                                          })
                                    ],
                                  )),
                              userData.isEmpty
                                  ? Container()
                                  : Container(
                                      child: RaisedButton.icon(
                                        color: Colors.green,
                                        colorBrightness: Brightness.dark,
                                        icon: Icon(
                                          Icons.send,
                                        ),
                                        label: const Text(
                                          'Order',
                                          style: TextStyle(
                                              fontFamily: 'Raleway',
                                              fontWeight: FontWeight.w700),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => AlertF(
                                                type: 'order',
                                                email: widget.email,
                                                order: widget.name,
                                                user: new User().getUserName(),
                                                userImage: userData[0]['image'],
                                                image: widget.image,
                                                name: widget.name,
                                                price: widget.price,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: new BottomBar(),
      drawer: DarwerBar(),
    ));
  }
}
