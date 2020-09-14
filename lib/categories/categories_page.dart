import 'package:flutter/material.dart';
import 'package:pets/pages/community.dart';
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
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
        child: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(3.0),
          children: <Widget>[
            CategoryCard(
              cardIcon: Icon(Icons.chat),
              cardTitle: "Community",
              tapOnCard: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Community()));
              },
            ),
            CategoryCard(
              cardIcon: Icon(Icons.local_hospital),
              cardTitle: "Rescue",
              tapOnCard: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Community()));
              },
            ),
            CategoryCard(
              cardIcon: Icon(Icons.pets),
              cardTitle: "Adopt",
              tapOnCard: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Community()));
              },
            ),
            CategoryCard(
              cardIcon: Icon(Icons.shopping_cart),
              cardTitle: "Shops",
              tapOnCard: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Community()));
              },
            ),
            CategoryCard(
              cardIcon: Icon(Icons.widgets),
              cardTitle: "More...",
              tapOnCard: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Community()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
