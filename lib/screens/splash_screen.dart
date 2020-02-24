import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

import './login_screen.dart';
import './home_screen.dart';

// class SplashScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         color: Theme.of(context).primaryColor,
//         child: SafeArea(
//           child: Container(
//             width: double.infinity,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 CircularProgressIndicator(
//                   backgroundColor: Colors.white,
//                 ),
//                 Text(
//                   "loading",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.w400,
//                     fontSize: 18.0,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    _startSplashScreen();
  }

  _startSplashScreen() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) {
          return StreamBuilder(
            stream: FirebaseAuth.instance.onAuthStateChanged,
            builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
              if (!snapshot.hasData || snapshot.data == null) {
                return LoginScreen();
              }
              return HomeScreen();
            },
          );
        }),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE6EFF9),
      body: Center(
        child: Image.asset(
          "images/globe.gif",
          width: 300.0,
          height: 200.0,
        ),
      ),
    );
  }
}
