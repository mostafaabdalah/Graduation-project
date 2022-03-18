import 'package:flutter/material.dart';
import 'package:hommey/Cart/SingleCart.dart';
import 'package:hommey/Common/Bottombar.dart';
import 'package:hommey/Common/DrawerBar.dart';
import 'package:hommey/Common/loading.dart';
import 'package:hommey/Models/user.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<Map<String, dynamic>> cart = [
    // {"image": 'b1.jpg', "name": 'rice', "ordered": '12-5-2017', "chef": 'Ali',"price":"50"},
    // {"image": 'b2.jpg', "name": 'meat', "ordered": '12-5-2017', "chef": 'Hassan',"price":"20"},
    // {"image": 'b3.jpg', "name": 'Cake', "ordered": '12-5-2017', "chef": 'Tamer',"price":"10"},
  ];

  getAllNotifications() {
    print('cart1 ${new User().getUserName()}');

    http
        .get('https://hommey-b9aa6.firebaseio.com/Cart.json')
        .then((http.Response res) {
      final Map<String, dynamic> resData = json.decode(res.body);
      resData.forEach((String id, dynamic data) {
        if (data["email"] == new User().getUserName()) {
          final obj = {
            "id": id,
            "time": data["Time"],
            "chefEmail": data["chefEmail"],
            "email": data["email"],
            "image": data["image"],
            "name": data["name"],
            "price": data["price"],
          };
          print('cart2');
          setState(() {
            cart.add(obj);
          });
        }
      });
    });
  }

  // Divider(color: Colors.black),

  @override
  void initState() {
    super.initState();
    getAllNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(children: <Widget>[
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
                          'Cart',
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
              child: cart.isEmpty
                  ? Loading()
                  : Container(
                      child: PageView(
                        scrollDirection: Axis.horizontal,
                        children: cart
                            .map((e) => SingleCart(
                                  id: e["id"],
                                  time: e["time"],
                                  chefEmail: e["chefEmail"],
                                  email: e["email"],
                                  image: e["image"],
                                  name: e["name"],
                                  price: e["price"].toString(),
                                ))
                            .toList(),
                      ),
                    ),
            )
          ]),
        ),
        bottomNavigationBar: new BottomBar(),
        drawer: DarwerBar(),
      ),
    );
  }
}
