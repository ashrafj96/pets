import 'package:flutter/material.dart';
import 'package:pets/pages/community.dart';

class CategoryCard extends StatelessWidget {
  final Icon cardIcon;
  final Function tapOnCard;
  final String cardTitle;

  const CategoryCard({Key key, this.cardIcon, this.tapOnCard, this.cardTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      margin: EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
        child: InkWell(
          onTap: () {
            tapOnCard();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              SizedBox(
                height: 50.0,
              ),
              Center(child: cardIcon),
              SizedBox(
                height: 20.0,
              ),
              Center(
                child: Text(
                  cardTitle,
                  style: TextStyle(fontSize: 18.0, color: Colors.black),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
