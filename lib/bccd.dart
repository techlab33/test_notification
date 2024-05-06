import 'package:flutter/material.dart';
import 'package:noti/newpage.dart';

class New1 extends StatefulWidget {
  const New1({super.key});

  @override
  State<New1> createState() => _New1State();
}

class _New1State extends State<New1> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(),
        body: Center(
          child: ElevatedButton(onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => NotificationPage(),));
            print("okay");

          }, child: Text("check it!")),
        ),
    );
  }
}
