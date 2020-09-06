import 'package:flutter/material.dart';
import 'package:pets/home/landing_page.dart';
import 'package:pets/services/auth.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
      create: (context) => Auth(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pets',
        theme: ThemeData(
            primaryColor: Colors.orangeAccent,
            accentColor: Colors.orangeAccent),
        home: LandingPage(),
      ),
    );
  }
}
