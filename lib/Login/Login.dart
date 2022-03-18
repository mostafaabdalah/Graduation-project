import 'package:flutter/material.dart';
import 'package:hommey/Home/Home.dart';
import 'package:hommey/Models/user.dart';
import 'package:hommey/SignUp/SignUp.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  User c = new User();
  String _email;
  String _password;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool login = false;

  Future getAllUserProducts(context) async {
    final List<Map<String, dynamic>> userData = [];

    await http
        .get('https://hommey-b9aa6.firebaseio.com/Login.json')
        .then((http.Response res) {
      final Map<String, dynamic> resData = json.decode(res.body);

      resData.forEach((String id, dynamic data) {
        print('1');
        if (data["email"].toString() == _email.toString() &&
            data["password"].toString() == _password.toString()) {
          final obj = {
            "id": id,
            "email": data["email"],
            "type": data["type"],
          };
          userData.add(obj);

          User u = new User();
          u.setUserName(_email);
          u.setRole(userData[0]["type"]);
          print('hereeeeeeeeeeeeeeeeeeeeeeeeeeeee');
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Home(),
            ),
          );

          setState(() {
            login = true;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // c.setUserName(null);
    // login = false;

    return MaterialApp(
      home: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [
                Colors.orange[900],
                Colors.orange[800],
                Colors.orange[400],
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 40, horizontal: 25),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Login',
                          style: TextStyle(fontSize: 50, color: Colors.white),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'welcome back',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  flex: 5,
                  child: SingleChildScrollView(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40),
                          )),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 100),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                    bottomLeft: Radius.circular(15),
                                  ),
                                  border:
                                      Border.all(width: 2, color: Colors.black),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                        hintText: "Email",
                                        border: InputBorder.none),
                                    onSaved: (val) {
                                      _email = val;
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                      bottomLeft: Radius.circular(15),
                                    ),
                                    border: Border.all(
                                        width: 2, color: Colors.black)),
                                child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: TextFormField(
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      hintText: "Password",
                                      border: InputBorder.none,
                                    ),
                                    onSaved: (val) {
                                      _password = val;
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              InkWell(
                                onTap: () {
                                  _formKey.currentState.save();
                                  // print(login);

                                  getAllUserProducts(context);

                                  // _formKey.currentState.reset();
                                },
                                child: Container(
                                  height: 50,
                                  margin: EdgeInsets.symmetric(horizontal: 50),
                                  decoration: BoxDecoration(
                                    color: Colors.orange[900],
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'login',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => SignUp(),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 50,
                                  margin: EdgeInsets.symmetric(horizontal: 50),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(color: Colors.black)),
                                  child: Center(
                                    child: Text(
                                      'SignUp',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
