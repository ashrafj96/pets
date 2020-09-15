import 'package:flutter/material.dart';

class ComposeBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.orangeAccent[100],
      padding: EdgeInsets.only(right: 16.0, top: 0.0, bottom: 12.0),
      margin: EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 16.0, top: 16.0),
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40.0),
                  border: Border.all(
                    width: 1.0,
                    color: Colors.black45,
                  )),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                    'Ask people something you wanna know about your pet ....'),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 14.0, left: 8.0),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.send,
                color: Colors.white,
                size: 30.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
