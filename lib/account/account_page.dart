import 'package:flutter/material.dart';
import 'package:pets/models/question.dart';
import 'package:pets/services/auth.dart';
import 'package:pets/services/database.dart';
import 'package:pets/widgets/avatar.dart';
import 'package:pets/widgets/platform_alert_dialog.dart';
import 'package:pets/widgets/question_list_tile.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await PlatformAlertDialog(
      title: 'Logout',
      cancelActionText: 'Cancel',
      content: 'Are you Sure that you want to logout?',
      defaultActionText: 'Logout',
    ).show(context);
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Account',
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          FlatButton(
            child: Icon(
              Icons.highlight_off,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              _confirmSignOut(context);
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(130),
          child: _buildUserInfo(user),
        ),
      ),
      body: _buildContent(context),
    );
  }

  Widget _buildUserInfo(User user) {
    return Column(
      children: [
        Avatar(
          borderColor: Colors.black45,
          photoUrl: user.photoUrl,
          radius: 50,
        ),
        SizedBox(
          height: 8.0,
        ),
        // if (user.displayName != null)
        Text(
          user.isAnonymous ? 'Anonymous${user.uid}' : user.displayName,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        SizedBox(
          height: 8,
        )
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return StreamBuilder<List<Question>>(
      stream: database.userQuestionsStream(),
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
