import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;


class HomePage extends StatefulWidget{
  final String title = 'Pitch';
  final String user; //need to do something with this
  //constructor
  HomePage({this.user});

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          Builder(builder: (BuildContext context) {
            return FlatButton(
              child: const Text('Sign out'),
              textColor: Theme.of(context).buttonColor,
              onPressed: () async {
                final FirebaseUser user = await _auth.currentUser();
                if (user == null) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: const Text('No one has signed in.'),
                  ));
                  return;
                }
                _signOut();
                final String uid = user.uid;
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(uid + ' has successfully signed out.'),
                ));
              },
            );
          })
        ],
      ),
      body: Text("yay."),
    );
  }

  // Example code for sign out.
  void _signOut() async {
    await _auth.signOut();
  }
}
