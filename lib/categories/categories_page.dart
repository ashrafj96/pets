import 'package:flutter/material.dart';
import 'package:pets/pages/community.dart';
import 'package:pets/pages/more.dart';
import 'package:pets/pages/rescue.dart';
import 'package:pets/widgets/category_card.dart';

class CategoriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Categories',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Container(
          color: Colors.orangeAccent[200],
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
          child: GridView.count(
            crossAxisCount: 2,
            padding: EdgeInsets.all(3.0),
            children: <Widget>[
              CategoryCard(
                cardIcon: Icon(
                  Icons.chat,
                  color: Colors.orangeAccent,
                  size: 40.0,
                ),
                cardTitle: "Community",
                tapOnCard: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Community()));
                },
              ),
              CategoryCard(
                cardIcon: Icon(
                  Icons.local_hospital,
                  color: Colors.orangeAccent,
                  size: 40.0,
                ),
                cardTitle: "Rescue",
                tapOnCard: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Rescue()));
                },
              ),
              CategoryCard(
                cardIcon: Icon(
                  Icons.pets,
                  color: Colors.orangeAccent,
                  size: 40.0,
                ),
                cardTitle: "Adopt",
                tapOnCard: () {},
              ),
              CategoryCard(
                cardIcon: Icon(
                  Icons.shopping_cart,
                  color: Colors.orangeAccent,
                  size: 40.0,
                ),
                cardTitle: "Shops",
                tapOnCard: () {},
              ),
              CategoryCard(
                cardIcon: Icon(
                  Icons.widgets,
                  color: Colors.orangeAccent,
                  size: 40.0,
                ),
                cardTitle: "More...",
                tapOnCard: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => More()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
