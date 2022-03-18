import 'package:flutter/material.dart';
import 'package:hommey/Cart/Cart.dart';
import 'package:hommey/Form/form.dart';
import 'package:hommey/Home/Home.dart';
import 'package:hommey/Models/user.dart';
import 'package:hommey/Notifications/Notifications.dart';
import 'package:hommey/Search/Search.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {

   static int active =3;

  @override
  Widget build(BuildContext context) {
    _goTo(int x) {
      setState(() {
        active = x;

      });

      switch (x) {
        case 0:
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Cart()));
          break;
        case 1:
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Notifications()));
          break;
  
        case 3:
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Home()));
          break;
        case 4:
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SearchF(),
          ));
          break;
      }
    }

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.add_shopping_cart,color: 0==active?Colors.blueAccent :Colors.black45 ,),
            onPressed: () {
              _goTo(0);
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications_active,color: 1==active?Colors.blueAccent :Colors.black45 ),
            onPressed: () {
              _goTo(1);
            },
          ),
          new User().getRole() !="producer" ? Text('') :
          FlatButton(
            color: Colors.blue,
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => FormF()));
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          IconButton(
            icon: Icon(Icons.home,color: 3==active?Colors.blueAccent :Colors.black45 ),
            onPressed: () {
              _goTo(3);
            },
          ),
          IconButton(
            icon: Icon(Icons.search,color: 4==active?Colors.blueAccent :Colors.black45 ),
            onPressed: () {
              _goTo(4);
            },
          ),
        ],
      ),
    );

  }
}
