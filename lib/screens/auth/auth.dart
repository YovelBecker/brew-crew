import 'package:brew_crew/screens/auth/register.dart';
import 'package:brew_crew/screens/auth/sign_in.dart';
import 'package:flutter/material.dart';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool showSignIn = true;

  void toggleShowSignIn() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: showSignIn
          ? SignIn(
              toggleShowSignIn: this.toggleShowSignIn,
            )
          : Register(
            toggleShowSignIn: this.toggleShowSignIn,
          ),
    );
  }
}
