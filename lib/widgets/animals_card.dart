import 'package:flutter/material.dart';

class AnimalCard extends StatelessWidget {
  final Text description;
  final Text petName;
  final NetworkImage petImage;

  AnimalCard({Key key, this.description, this.petName, this.petImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          ListTile(
              title: petName,
              subtitle: Column(
                children: <Widget>[description],
              ),
              trailing: Image(image: petImage))
        ],
      ),
    );
  }
}
