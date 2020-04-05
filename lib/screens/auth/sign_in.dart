import 'package:brew_crew/services/auth.service.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/const.dart';

class SignIn extends StatefulWidget {
  final Function toggleShowSignIn;

  SignIn({this.toggleShowSignIn});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  Map errors = {
    'email': 'Enter An Email',
    'password': 'Password must be at least 6 characters long'
  };
  String registerError = '';
  String email = '';
  String password = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading 
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              title: Text('Sign In To Brew Crew'),
              centerTitle: false,
              actions: <Widget>[
                FlatButton.icon(
                  onPressed: widget.toggleShowSignIn,
                  icon: Icon(Icons.person),
                  label: Text('Register'),
                )
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    TextFormField(
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                      validator: (val) => val.isEmpty ? errors['email'] : null,
                      decoration: textInputDecoration('Email'),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      obscureText: true,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                      validator: (val) => val.isEmpty ? errors['password'] : null,
                      decoration: textInputDecoration('Password'),
                    ),
                    SizedBox(height: 20.0),
                    RaisedButton(
                      color: Colors.pink[400],
                      child: Text(
                        'Sign In',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          dynamic res = await _auth.signInWithEmailAndPassword(email, password);
                          if (res == null) {
                            setState(() => registerError = 'Email or Password Not Found');
                          }
                          setState(() => loading = false);
                        }
                      },
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      registerError,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
