import 'package:flutter/material.dart';
import 'package:pets/models/question.dart';

class QuestionListTile extends StatelessWidget {
  const QuestionListTile({Key key, @required this.question}) : super(key: key);
  final Question question;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      elevation: 5.0,
      child: Column(
        children: [
          ListTile(
            title: Text(
              question.petType,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            subtitle: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: Text(
                        '${question.displayName}:',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 17.0,
                            color: Colors.black),
                      ),
                    ),
                    Text(
                      question.questionText,
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: RaisedButton.icon(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(16),
                      ),
                    ),
                    color: Colors.orangeAccent,
                    onPressed: () {},
                    label: Text(
                      'Comment',
                      style: TextStyle(color: Colors.white),
                    ),
                    icon: Icon(
                      Icons.comment,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
