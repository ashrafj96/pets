import 'package:flutter/material.dart';
import 'package:pets/widgets/animals_card.dart';

class More extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Good to Know",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Center(
            child: Text(
              "Some pets Information",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      body: _petsInformation(context),
    );
  }

  Widget _petsInformation(BuildContext context) {
    /// this will still as a row data without backend functionality
    return ListView(
      children: <Widget>[
        AnimalCard(
            petImage: NetworkImage(
                "https://i.pinimg.com/originals/ae/a4/ee/aea4eef2519bfd26961d090da069aabb.jpg"),
            petName: Text("Persian"),
            description: Text(
                "The breed is very soft and very calm. They aren't necessarily active, especially as they get older. They also tend to get tired very easily")),
        AnimalCard(
          petName: Text("sphynx"),
          description: Text(
              "The sphynx is a medium-sized cat with a striking appearance,identified by her hairlesswrinkled skin and large ears. She has a sleek"),
          petImage: NetworkImage(
              "https://i.pinimg.com/736x/b5/bb/4c/b5bb4c4596f7eeb7df37242ab13df92a.jpg"),
        ),
        AnimalCard(
          petImage: NetworkImage(
              "https://cdn.wimmel-napkins.com/F/1/AM/g13312895.jpg"),
          petName: Text("Golden retriever"),
          description: Text(
              "The Golden Retriever is one of the most popular dog breeds in the United States. The breed’s friendly, tolerant attitude makes them great family pets, and their intelligence makes them highly capable working dogs"),
        )
      ],
    );
  }
}
