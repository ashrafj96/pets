import 'package:flutter/material.dart';
import 'package:pets/services/auth.dart';
import 'package:pets/widgets/avatar.dart';
import 'package:pets/widgets/platform_alert_dialog.dart';
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
    // final userData = Provider.of<UsersData>(context);
    final user = Provider.of<User>(context);
    // final database = Provider.of<Database>(context);
    // database.readUserData();
    // FireStoreDatabase databaseU;
    // print(databaseU.displayName);

    // UsersData data;
    // UsersData.formDocument(user.uid);
    // print(data.displayName);
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
}
