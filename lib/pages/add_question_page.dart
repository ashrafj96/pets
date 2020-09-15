import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pets/models/question.dart';
import 'package:pets/services/auth.dart';
import 'package:pets/services/database.dart';
import 'package:pets/widgets/platform_exception_alert_dialog.dart';
import 'package:provider/provider.dart';

class AddQuestionPage extends StatefulWidget {
  const AddQuestionPage({Key key, @required this.database}) : super(key: key);

  final Database database;

  static Future<void> show(BuildContext context) async {
    final database = Provider.of<Database>(context, listen: false);
    await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AddQuestionPage(
              database: database,
            ),
        fullscreenDialog: true));
  }

  @override
  _AddQuestionPageState createState() => _AddQuestionPageState();
}

class _AddQuestionPageState extends State<AddQuestionPage> {
  final _formKey = GlobalKey<FormState>();

  String _petType;
  String _question;

  bool _validateAndSaveForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> _submit() async {
    final user = Provider.of<User>(context, listen: false);
    if (_validateAndSaveForm()) {
      try {
        final question = Question(
            petType: _petType,
            questionText: _question,
            displayName: user.displayName);
        await widget.database.createQuestionInUserProfile(question);
        await widget.database.createQuestionInCommunity(question);
        Navigator.of(context).pop();
      } on PlatformException catch (e) {
        PlatformExceptionAlertDialog(
          title: 'Operation failed',
          exception: e,
        ).show(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text(
          'New Question',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          FlatButton(
            child: Text(
              'Post',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            onPressed: _submit,
          )
        ],
      ),
      body: _buildContent(),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildFormChildren(),
      ),
    );
  }

  List<Widget> _buildFormChildren() {
    return [
      TextFormField(
        decoration: InputDecoration(
          labelText: 'Pet type',
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.orangeAccent, width: 5.0),
          ),
        ),
        validator: (value) =>
            value.isNotEmpty ? null : 'Pet type can\'t be empty',
        onSaved: (value) => _petType = value,
      ),
      SizedBox(
        height: 10.0,
      ),
      TextFormField(
        decoration: InputDecoration(
          labelText: 'Question',
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.orangeAccent, width: 5.0),
          ),
        ),
        maxLength: 300,
        maxLines: null,
        // expands: true,
        keyboardType: TextInputType.multiline,
        validator: (value) =>
            value.isNotEmpty ? null : 'Question can\'t be empty',
        onSaved: (value) => _question = value,
      ),
    ];
  }
}
