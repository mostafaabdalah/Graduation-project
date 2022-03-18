import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hommey/Common/Bottombar.dart';
import 'package:hommey/Common/DrawerBar.dart';
import 'package:hommey/Form/formService.dart';
import 'package:hommey/Models/user.dart';
import 'package:image_picker/image_picker.dart';

class FormF extends StatefulWidget {
  @override
  _FormFState createState() => _FormFState();
}

class _FormFState extends State<FormF> {
  String _name;
  String _price;
  String _inger;
  String _dis;
  String _address;
  String _category = 'Snack';
  String _time;
  String _uploadedFileURL;
  bool uploadDone = false;

  List<String> category = ['Vegan', 'Lunch', 'Breakfast', 'Dinner'];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.blue,
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
                            'Add',
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
                    margin: EdgeInsets.only(top: 20),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Form(
                            key: _formKey,
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
                                      SizedBox(
                                        height: 10,
                                      ),
                                      _image == null
                                          ? Text('Please Pick an image')
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              child: Image.file(
                                                _image,
                                                height: 200,
                                                width: 200,
                                                // MediaQuery.of(context).size.width /
                                                //     1.4,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(10),
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: TextFormField(
                                    style: TextStyle(color: Colors.blue),
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(10),
                                        border: InputBorder.none,
                                        labelText: 'Name',
                                        // hintText: 'Name',
                                        prefixIcon: Icon(
                                          Icons.nature,
                                          color: Colors.blue,
                                        )),
                                    validator: (String val) {
                                      if (val.isEmpty) {
                                        return 'required';
                                      }
                                    },
                                    onSaved: (String val) {
                                      _name = val;
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(10),
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    validator: (String val) {
                                      if (val.isEmpty) {
                                        return 'required';
                                      } else if (val.length > 2) {
                                        return 'Can not accept this big number';
                                      }
                                    },
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(10),
                                      border: InputBorder.none,
                                      labelText: 'Price',
                                      prefixIcon: Icon(
                                        Icons.attach_money,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    onSaved: (String val) {
                                      _price = val;
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(10),
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: TextFormField(
                                    validator: (String val) {
                                      if (val.isEmpty) {
                                        return 'required';
                                      }
                                    },
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(10),
                                      border: InputBorder.none,
                                      labelText: 'Ingredients seperate with * ',
                                      prefixIcon: Icon(
                                        Icons.fastfood,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    onSaved: (String val) {
                                      _inger = val;
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(10),
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: TextFormField(
                                    validator: (String val) {
                                      if (val.isEmpty) {
                                        return 'required';
                                      }
                                    },
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(10),
                                      border: InputBorder.none,
                                      labelText: 'Discribe',
                                      prefixIcon: Icon(
                                        Icons.disc_full,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    onSaved: (String val) {
                                      _dis = val;
                                    },
                                  ),
                                ),
                                Text('Catigory is ${_category}'),
                                Container(
                                  child: DropdownButton(
                                    hint: Text("Select Category"),
                                    items: category
                                        .map((e) => DropdownMenuItem(
                                              value: e,
                                              child: Text('${e}'),
                                            ))
                                        .toList(),
                                    onChanged: (Value) {
                                      setState(() {
                                        _category = Value;
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(10),
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: TextFormField(
                                    validator: (String val) {
                                      if (val.isEmpty) {
                                        return 'required';
                                      }
                                    },
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(10),
                                      border: InputBorder.none,
                                      labelText: 'Address',
                                      prefixIcon: Icon(
                                        Icons.location_city,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    onSaved: (String val) {
                                      _address = val;
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(10),
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    validator: (String val) {
                                      if (val.isEmpty) {
                                        return 'required';
                                      }
                                    },
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(10),
                                      border: InputBorder.none,
                                      labelText: 'Time',
                                      prefixIcon: Icon(
                                        Icons.timer,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    onSaved: (String val) {
                                      _time = val;
                                    },
                                  ),
                                ),
                                uploadDone == false
                                    ? Container(
                                        child: Text(
                                            'Save will show when uploading image'))
                                    : RaisedButton(
                                        color: Colors.blue,
                                        colorBrightness: Brightness.dark,
                                        onPressed: () {
                                          if (!_formKey.currentState
                                              .validate()) {
                                            return;
                                          }

                                          _formKey.currentState.save();

                                          final Map<String, dynamic> pro = {
                                            // 'image': _image,
                                            'image': _uploadedFileURL,
                                            'name': _name,
                                            'price': _price,
                                            'inger': _inger,
                                            'dis': _dis,
                                            'address': _address,
                                            'email': new User().getUserName(),
                                            'time': _time,
                                            'category': _category,
                                          };
                                          FormService().addProduct(pro);
                                          _formKey.currentState.reset();
                                          _image = null;
                                          // print(pro);
                                        },
                                        child: Text('Save'),
                                      )
                              ],
                            )),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomBar(),
        drawer: DarwerBar(),
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
