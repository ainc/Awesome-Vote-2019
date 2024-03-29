import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class RegisterPage extends StatefulWidget {
  final String title = 'Registration';
  @override
  State<StatefulWidget> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userController = TextEditingController();

  String _errorMessage = '';
  bool _success;
  String _userEmail;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(vertical: 40.0),
                child: Text(
                    'Register a new account and begin betting on pitches!',
                    style: new TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold)),
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Please enter some text.';
                  } else if (!value.contains("@") || !value.contains(".")) {
                    return 'Invalid email.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                    labelText: 'Password (must be longer than 6 characters)'),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Please enter some text.';
                  } else if (value.length < 6) {
                    return 'Password must be longer than 6 characters.';
                  }
                  return null;
                },
                obscureText: true,
              ),
              TextFormField(
                controller: _userController,
                decoration: InputDecoration(labelText: 'Username'),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Please enter some text.';
                  } else if (value.length < 6) {
                    return 'Username must be longer than 6 characters.';
                  }
                  return null;
                },
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                alignment: Alignment.center,
                child: RaisedButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      _register();
                    }
                  },
                  child: const Text('Submit'),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                    _success == null
                        ? ''
                        : (_success
                            ? 'Successfully registered ' + _userEmail
                            : 'Registration failed:' + _errorMessage),
                    style: _success == null //change color depending on success
                        ? TextStyle(color: Colors.white)
                        : (_success
                            ? TextStyle(color: Colors.green)
                            : TextStyle(color: Colors.red))),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    _emailController.dispose();
    _passwordController.dispose();
    _userController.dispose();
    super.dispose();
  }

  //give us some data in the database so we can record this user's points
  void addToDatabase(FirebaseUser user) {
    Firestore.instance.collection('user_data').document('oEhWy7r2M055e8a4PIUr').updateData({
      user.uid: _userController.text, //user uid to lookup username
      _userController.text: 200, //everyone starts with 200, completely arbitrary numbet
    });
  }

  // Code for registration.
  void _register() async {
    try {
      final FirebaseUser user = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (user != null) {
        setState(() {
          _success = true;
          _userEmail = user.email;
        });
        //make a new user in the database
        addToDatabase(user);
      } else {
        _success = false;
      }
    } on Exception catch (e) {
      _errorMessage = e.toString();
      _errorMessage = _errorMessage.substring(_errorMessage.indexOf(',') + 1);
      _errorMessage = _errorMessage.substring(0, _errorMessage.indexOf(','));
      //print(_errorMessage);
      _success = false;
    }
  }
}
