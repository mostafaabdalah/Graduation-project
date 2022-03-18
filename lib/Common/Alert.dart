import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AlertF extends StatelessWidget {
  String type;

  String email;
  String order;
  String time = new DateTime.now().toString();
  String user;
  String userImage;

  String price;
  String name;
  String image;

  AlertF({this.type, this.email, this.order, this.user, this.userImage, this.name, this.price,this.image});

  @override
  Widget build(BuildContext context) {
    orderProduct(product) {
      http.post('https://hommey-b9aa6.firebaseio.com/Notifications.json',
          body: json.encode(product));
    }

    addToCart(product) {
      http.post('https://hommey-b9aa6.firebaseio.com/Cart.json',
          body: json.encode(product));
    }

    return Scaffold(
      body: AlertDialog(
        title: Container(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('${type} confirm')),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('This is a ${type} alert .'),
              SizedBox(
                height: 10,
              ),
              Text('Would you like to approve of this Action?'),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                color: Colors.blue,
                colorBrightness: Brightness.dark,
                child: Text(
                  'Approve',
                  style: TextStyle(letterSpacing: 1),
                ),
                onPressed: () {
                  final Map<String, dynamic> orderPro = {
                    'userImage': userImage,
                    'order': order,
                    'user': user,
                    'email': email,
                    'time': time,
                  };
                  orderProduct(orderPro);

                  final Map<String, dynamic> cartPro = {
                    'Time': time,
                    'chefEmail': email,
                    'email': user,
                    'image': image,
                    'name': name,
                    'price':price
                  };

                  addToCart(cartPro);

                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
