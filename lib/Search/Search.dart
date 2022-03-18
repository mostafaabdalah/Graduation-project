import 'package:flutter/material.dart';
import 'package:hommey/Common/Bottombar.dart';
import 'package:hommey/Common/DrawerBar.dart';
import 'package:hommey/Common/loading.dart';
import 'package:hommey/Details/Details.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchF extends StatefulWidget {
  @override
  _SearchFState createState() => _SearchFState();
}

class _SearchFState extends State<SearchF> {
  List<Map<String, dynamic>> searchOut = [];

  String _searchKey;
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  getAllSearch() {
    print('Serach');

    http
        .get('https://hommey-b9aa6.firebaseio.com/products.json')
        .then((http.Response res) {
      final Map<String, dynamic> resData = json.decode(res.body);
      resData.forEach((String id, dynamic data) {
        if (data["name"] == _searchKey ||
            data["category"] == _searchKey ||
            data["address"] == _searchKey) {
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
          // print('fun2');
          setState(() {
            searchOut.add(obj);
          });
        }
      });
    });
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
                        'Search',
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
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(5),
                      color: Colors.white,
                      child: TextField(
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            border: InputBorder.none,
                            hintText: 'Search'),
                        style: TextStyle(fontSize: 20, letterSpacing: 1),
                        onSubmitted: (value) {
                          setState(() {
                            _searchKey = value;
                            loading = true;
                            searchOut = [];
                            getAllSearch();
                          });
                          // print(value);
                        },
                      ),
                    ),
                    searchOut.isEmpty && loading
                        ? Loading()
                        : Column(
                            children: searchOut
                                .map((e) => Item(
                                    context,
                                    e["id"],
                                    e["category"],
                                    e["address"],
                                    e["email"],
                                    e["inger"],
                                    e["dis"],
                                    e["time"],
                                    e["image"],
                                    e["name"],
                                    e["price"].toString()))
                                .toList(),
                          ),
                  ],
                ),
              ),
            ),
          )
        ])),
        bottomNavigationBar: new BottomBar(),
        drawer: DarwerBar(),
      ),
    );
  }
}

Widget Item(context, id, category, address, email, inger, dis, time, image,
    name, price) {
  return InkWell(
    onTap: () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Details(
            id: id,
            image: image,
            name: name,
            price: price,
            category: category,
            address: address,
            email: email,
            inger: inger,
            dis: dis,
            time: time,
          ),
        ),
      );
    },
    child: Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.grey[350],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          )),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              title: Text(
                '${name}',
                style: TextStyle(fontSize: 20, letterSpacing: 1),
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text('${price} EGP'),
                  SizedBox(
                    width: 30,
                  ),
                  Text('${category}')
                ],
              ),
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(image),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
