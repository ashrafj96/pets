import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pets/widgets/camera_screen.dart';

class Rescue extends StatefulWidget {
  @override
  _RescueState createState() => _RescueState();
}

class _RescueState extends State<Rescue> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Rescue",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            }),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(130),
          child: Center(
            child: Text("be a good person and rescue an animal"),
          ),
        ),
      ),
      body: CameraScreen(),
    );
  }
}
