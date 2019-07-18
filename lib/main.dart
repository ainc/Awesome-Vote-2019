import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './signin_page.dart';
import './home_page.dart';
import './splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Awesome Vote',
      home: _handleCurrentScreen(),
    );
  }

  Widget _handleCurrentScreen() {
    return new StreamBuilder<FirebaseUser>(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return new SplashScreen();
          } else {
            if (snapshot.hasData) {
              //NOTE: we may want to pass more data here, like a firebase object?
              //https://flutterdoc.com/mobileauthenticating-users-with-firebase-and-flutter-240c5557ac7f
              return new HomePage(user: snapshot.data.uid);
            }
            return new SignInPage();
          }
        });
  }
}

/*class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FirebaseUser user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Image.asset('assets/images/5-Across-Logo.png'),
            alignment: Alignment.center,
            padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
          ),
          Container(
            child: RaisedButton(
              child: const Text('Sign in', style: TextStyle(fontSize: 32)),
              onPressed: () => _pushPage(context, SignInPage()),
            ),
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
          ),
          Container(
            child: RaisedButton(
              child: const Text('Register a new account'),
              onPressed: () => _pushPage(context, RegisterPage()),
            ),
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }

  void _pushPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }
}*/
