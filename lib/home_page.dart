import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class HomePage extends StatefulWidget {
  final String title = 'Pitch';
  final String user;
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
        backgroundColor: Colors.red,
        centerTitle: true,
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            retrieveUserData(),
            _handlePitches(),
          ],
        ),
      ),
    );
  }

  // Example code for sign out.
  void _signOut() async {
    await _auth.signOut();
  }

  Widget _handlePitches() {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('pitch_ideas').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Text('Loading...');
          default:
            return new ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                return new Column(children: <Widget>[
                  ListTile(
                    title: new Text(document['pitch1'][0]),
                    subtitle: new Text(document['pitch1'][1]),
                  ),
                  ListTile(
                    title: new Text(document['pitch2'][0]),
                    subtitle: new Text(document['pitch2'][1]),
                  ),
                  ListTile(
                    title: new Text(document['pitch3'][0]),
                    subtitle: new Text(document['pitch3'][1]),
                  ),
                ]);
              }).toList(),
            );
        }
      },
    );
  }

  //retrieve and format user data for top of display from database
  Widget retrieveUserData() {
    return new StreamBuilder(
      stream: Firestore.instance.collection('user_data').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Text('Loading...');
          default:
            return new Column(
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                
                String username = document[widget.user].toString();
                //print(username);
                return new Column(children: <Widget>[
                  Text(
                    "Current point total: " + document[username].toString(),
                  ),
                ]);
              }).toList(),
            );
        }
      },
    );
  }

}
