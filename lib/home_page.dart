import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';
import 'sign_in.dart';

final _auth = FirebaseAuth.instance;

class HomePage extends StatefulWidget {
  @override
  State createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Image.network(user.photoURL),
              ),
              Text('Name', style: TextStyle(color: Colors.grey[600]),),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  user.displayName,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Text('Email', style: TextStyle(color: Colors.grey[600]),),
              Padding(
                padding: const EdgeInsets.only(bottom: 60),
                child: Text(
                  user.email,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              _signOutButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signOutButton() => OutlineButton(
        splashColor: Colors.grey,
        onPressed: () {
          signOutGoogle().then((value) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return LoginPage();
                },
                maintainState: false,
              ),
            );
          });
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        highlightElevation: 0,
        borderSide: BorderSide(color: Colors.grey),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sign out',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[800],
                ),
              )
            ],
          ),
        ),
      );
}
