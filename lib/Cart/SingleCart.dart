import 'package:flutter/material.dart';

class SingleCart extends StatefulWidget {
  String id;
  String image;
  String name;
  String price;
  String time;
  String chefEmail;
  String email;
  SingleCart(
      {this.id,
      this.email,
      this.image,
      this.name,
      this.price,
      this.time,
      this.chefEmail});

  @override
  _SingleCartState createState() => _SingleCartState();
}

class _SingleCartState extends State<SingleCart> {
  @override
  Widget build(BuildContext context) {
    // print(widget.image);

    return Container(
      width: 160.0,
      color: Colors.orange[600],
      child: Card(
        margin: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20),
                height: 250,
                child: Image.network(widget.image)),
            SizedBox(
              height: 20,
            ),
            ListTile(
              title: Center(
                child: Text(
                  '${widget.name}',
                  style: TextStyle(fontSize: 25, letterSpacing: 2),
                ),
              ),
              subtitle: Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Text('Price : ${widget.price} EGY'),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Ordered in :${widget.time.split('.')[0]}'),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Chef : ${widget.chefEmail} '),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
