import 'package:flutter/cupertino.dart';

class Question {
  Question(
      {@required this.petType,
      @required this.questionText,
      @required this.displayName});

  final String petType;
  final String questionText;
  final String displayName;

  factory Question.formMap(Map<String, dynamic> data) {
    if (data == null) {
      return null;
    }
    final String petType = data['petType'];
    final String questionText = data['questionText'];
    final String displayName = data['displayName'];
    return Question(
        questionText: questionText, petType: petType, displayName: displayName);
  }

  Map<String, dynamic> toMap() {
    return {
      'petType': petType,
      'questionText': questionText,
      'displayName': displayName,
      'created': DateTime.now(),
    };
  }
}
