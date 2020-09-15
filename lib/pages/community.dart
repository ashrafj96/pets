import 'package:flutter/material.dart';
import 'package:pets/models/question.dart';
import 'package:pets/pages/add_question_page.dart';
import 'package:pets/services/database.dart';
import 'package:pets/widgets/compose_box.dart';
import 'package:pets/widgets/question_list_tile.dart';
import 'package:provider/provider.dart';

class Community extends StatelessWidget {
  // Future<void> _createQuestion(BuildContext context) async {
  //   try {
  //     final database = Provider.of<Database>(context, listen: false);
  //     await database.createQuestionInUserProfile(
  //         Question(displayName: 'ashraf', questionText: 'my pet is sick'));
  //     await database.createQuestionInCommunity(
  //         Question(displayName: 'ashraf', questionText: 'my pet is sick'));
  //   } on PlatformException catch (e) {
  //     PlatformExceptionAlertDialog(
  //       title: 'Operation Failed',
  //       exception: e,
  //     ).show(context);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Questions", style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(130),
          child: GestureDetector(
              onTap: () => AddQuestionPage.show(context), child: ComposeBox()),
        ),
      ),
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return StreamBuilder<List<Question>>(
      stream: database.allQuestionsStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Something went wrong...'),
          );
        }
        if (snapshot.hasData) {
          final questions = snapshot.data;
          final children = questions
              .map(
                (question) => QuestionListTile(
                  question: question,
                ),
              )
              .toList();
          return ListView(
            children: children,
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
