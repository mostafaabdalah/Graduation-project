import 'package:flutter/material.dart';

class ProfileDetails extends StatelessWidget {
  
  final String  sub;
  final Widget icon;

  const ProfileDetails({Key key,@required this.sub,@required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child:icon,
            ),
            Text(sub),
          ],
        ),
      ),
      
    );
  }
}