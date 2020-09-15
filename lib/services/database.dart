import 'package:flutter/cupertino.dart';
import 'package:pets/models/question.dart';
import 'package:pets/services/api_path.dart';
import 'package:pets/services/firestore_service.dart';

abstract class Database {
  Future<void> createQuestionInUserProfile(Question question);
  Future<void> createQuestionInCommunity(Question question);
  Stream<List<Question>> userQuestionsStream();
  Stream<List<Question>> allQuestionsStream();
}

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FireStoreDatabase implements Database {
  FireStoreDatabase({@required this.uid, @required this.displayName})
      : assert(uid != null);
  final String uid;
  final String displayName;

  final _service = FirestoreService.instance;

  Future<void> createQuestionInUserProfile(Question question) async =>
      await _service.setData(
        path: APIPath.question(uid, documentIdFromCurrentDate()),
        data: question.toMap(),
      );

  Future<void> createQuestionInCommunity(Question question) async =>
      await _service.setData(
        path: APIPath.createInAllQuestions(documentIdFromCurrentDate()),
        data: question.toMap(),
      );

  Stream<List<Question>> allQuestionsStream() => _service.collectionStream(
        path: APIPath.allQuestions(),
        builder: (data) => Question.formMap(data),
      );

  Stream<List<Question>> userQuestionsStream() => _service.collectionStream(
        path: APIPath.questions(uid),
        builder: (data) => Question.formMap(data),
      );
}
