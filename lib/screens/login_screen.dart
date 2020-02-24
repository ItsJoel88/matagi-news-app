import 'package:flutter/material.dart';

import '../utils/firebase_auth.dart';

import './home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController;
  TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 100.0,
              ),
              Text(
                "Login",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30.0,
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: "Enter Email",
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Enter Password",
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              RaisedButton(
                child: Text("Login"),
                onPressed: () async {
                  if (_emailController.text.isEmpty ||
                      _passwordController.text.isEmpty) {
                    print("Email and password is required");
                    return;
                  } else {
                    bool res = await AuthProvider().signInWithEmail(
                        _emailController.text, _passwordController.text);
                    if (res) {
                      print("login success");
                      return;
                    } else {
                      print("login failed");
                      return;
                    }
                  }
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              _googleButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _googleButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () async {
        bool res = await AuthProvider().loginWithGoogle();
        if (!res) {
          print("Error logging in with google");
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => HomeScreen()));
        }
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage('images/google_logo.png'),
              height: 35.0,
            ),
            Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  "Login with Google",
                  style: TextStyle(fontSize: 20.0, color: Colors.grey),
                ))
          ],
        ),
      ),
    );
  }
}
