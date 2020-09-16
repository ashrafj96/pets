import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pets/models/image_picker_handler.dart';

class CameraScreen extends StatefulWidget {
  final String title;

  const CameraScreen({Key key, this.title}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with TickerProviderStateMixin, ImagePickerListener {
  File _image;
  AnimationController _controller;
  ImagePickerHandler imagePicker;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    imagePicker = new ImagePickerHandler(this, _controller);
    imagePicker.init();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => imagePicker.showDialog(context),
        child: Center(
            child: _image == null
                ? Stack(
                    children: <Widget>[
                      Center(
                        child: CircleAvatar(
                          radius: 80.0,
                          backgroundColor: const Color(0xFF778899),
                        ),
                      ),
                      Center(
                          child: Image.network(
                              'https://w0.pngwave.com/png/873/489/avatar-youtube-cat-cute-dog-png-clip-art.png')),
                    ],
                  )
                : Container(
                    height: 160.0,
                    width: 160.0,
                    decoration: BoxDecoration(
                        color: const Color(0xff7c94b6),
                        image: DecorationImage(
                            image: ExactAssetImage(_image.path),
                            fit: BoxFit.cover),
                        border: Border.all(color: Colors.red, width: 5.0),
                        borderRadius: BorderRadius.all(Radius.circular(80.0))),
                  )),
      ),
    );
  }

  @override
  userImage(File _image) {
    setState(() {
      this._image = _image;
    });
  }
}
