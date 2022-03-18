import 'package:flutter/material.dart';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:hommey/Login/Login.dart';
import 'package:hommey/SignUp/signService.dart';
import 'package:image_picker/image_picker.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUp createState() => _SignUp();
}

class _SignUp extends State<SignUp> {
  String _type = 'Buyer';
  String _firstName;
  String _lastName;
  String _email;
  String _password;
  String _date;
  String _phone;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<String> userType = ['producer', 'buyer'];

  String _uploadedFileURL;
  bool uploadDone = false;

  @override
  Widget build(BuildContext context) {
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
          child: Expanded(
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 25),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Sign Up',
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(60),
                              topRight: Radius.circular(60),
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(0),
                            )),
                        child: Form(
                          key: _formKey,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  child: Column(
                                    children: <Widget>[
                                      _image != null
                                          ? Container()
                                          : OutlineButton(
                                              borderSide: BorderSide(
                                                  color: Colors.blue),
                                              onPressed: () {
                                                _openImageOptins();
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.camera_alt,
                                                    color: Colors.blue,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    'Add Image',
                                                    style: TextStyle(
                                                        color: Colors.blue),
                                                  )
                                                ],
                                              ),
                                            ),
                                     
                                      _image == null
                                          ? Text('Please choose your Image')
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              child: Image.file(
                                                _image,
                                                height: 200,
                                                width: 200,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                        bottomLeft: Radius.circular(15),
                                      ),
                                      border: Border.all(color: Colors.black)),
                                  child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        hintText: "First Name",
                                        border: InputBorder.none,
                                      ),
                                      onSaved: (val) {
                                        _firstName = val;
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
                                      border: Border.all(color: Colors.black)),
                                  child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        hintText: "Last Name",
                                        border: InputBorder.none,
                                        // suffixIcon: Icon(Icons.panorama_fish_eye),
                                      ),
                                      onSaved: (val) {
                                        _lastName = val;
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
                                      border: Border.all(color: Colors.black)),
                                  child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        hintText: "Email",
                                        border: InputBorder.none,
                                      ),
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
                                      border: Border.all(color: Colors.black)),
                                  child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: TextFormField(
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
                                Text('you choose ${_type}'),
                                Container(
                                  child: DropdownButton(
                                    hint: Text("Select Activity"),
                                    items: userType
                                        .map((e) => DropdownMenuItem(
                                              value: e,
                                              child: Text('${e}'),
                                            ))
                                        .toList(),
                                    onChanged: (Value) {
                                      setState(() {
                                        _type = Value;
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      // color: Colors.orangeAccent,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                        bottomLeft: Radius.circular(15),
                                      ),
                                      border: Border.all(color: Colors.black)),
                                  child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        hintText: "Date",
                                        border: InputBorder.none,
                                      ),
                                      onSaved: (val) {
                                        _date = val;
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
                                      border: Border.all(color: Colors.black)),
                                  child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        hintText: "Phone",
                                        border: InputBorder.none,
                                      ),
                                      onSaved: (val) {
                                        _phone = val;
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                uploadDone == false
                                    ? Container()
                                    : InkWell(
                                        onTap: () {
                                          _formKey.currentState.save();
                                          uploadDone = false;

                                          SignIn s = new SignIn();

                                          Map<String, dynamic> user = {
                                            "data": _date,
                                            "email": _email,
                                            "firstName": _firstName,
                                            "image": _uploadedFileURL,
                                            "lastName": _lastName,
                                            "phone": _phone,
                                          };
                                          s.addNewUser(user);

                                          Map<String, dynamic> login = {
                                            "email": _email,
                                            "password": _password,
                                            "type": _type,
                                          };

                                          s.addLoginUser(login);

                                          sleep(const Duration(seconds: 5));

                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => Login(),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          height: 50,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 50),
                                          decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          child: Center(
                                            child: Text(
                                              'Sign UP',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
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
      ),
    );
  }

  /**************************************************************************** */
  File _image;
  final picker = ImagePicker();
  Future getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    setState(() {
      _image = File(pickedFile.path);
      uploadFile();
    });
    Navigator.pop(context);
  }

  Future uploadFile() async {
    StorageReference ref =
        FirebaseStorage.instance.ref().child("uploads/${_image.path}");
    StorageUploadTask uploadTask = ref.putFile(_image);
    await uploadTask.onComplete;

    ref.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedFileURL = fileURL;
        uploadDone = true;
      });
    });
  }

  void _openImageOptins() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            margin: EdgeInsets.all(20),
            height: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                RaisedButton.icon(
                    color: Colors.blueAccent,
                    colorBrightness: Brightness.dark,
                    onPressed: () {
                      getImage(ImageSource.camera);
                    },
                    icon: Icon(Icons.camera_alt),
                    label: Text('Use Camera')),
                RaisedButton.icon(
                    color: Colors.blueAccent,
                    colorBrightness: Brightness.dark,
                    onPressed: () {
                      getImage(ImageSource.gallery);
                    },
                    icon: Icon(Icons.camera),
                    label: Text('Use Gallary')),
              ],
            ),
          );
        });
  }
}
