import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:async';

import './screens/splash_screen.dart';

// import './people.dart';
// import './button.dart';

Future main() async {
  await DotEnv().load('.env');
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Splash Screen',
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter Demo",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreenPage(),
    );
  }
}

// class MainScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: FirebaseAuth.instance.onAuthStateChanged,
//       builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
//         // if (snapshot.connectionState == ConnectionState.waiting) {
//         //   return SplashScreen();
//         // }
//         // if (!snapshot.hasData || snapshot.data == null) {
//         //   return LoginScreen();
//         // }
//         if (!snapshot.hasData || snapshot.data == null) {
//           return SplashScreenPage();
//         }
//         return HomeScreen();
//       },
//     );
//   }
// }

// class MyApp extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return _MyAppState();
//   }
// }

// class _MyAppState extends State<MyApp> {
//   var _people = ["dexter", "nuel", "dina", "joko", "eksi"];
//   var _peopleIndex = 0;
//   void _answer() {
//     setState(() {
//       _peopleIndex += 1;
//     });
//     if (_peopleIndex > _people.length - 1) {
//       setState(() {
//         _peopleIndex = 0;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text("My First App"),
//         ),
//         body: Column(
//           children: [
//             People(_people[_peopleIndex]),
//             ...(_people).map((person) {
//               return Button(_answer, person);
//             }).toList()
//           ],
//         ),
//       ),
//     );
//   }
// }

// class SplashScreenPage extends StatefulWidget {
//   @override
//   _SplashScreenPageState createState() => _SplashScreenPageState();
// }

// class _SplashScreenPageState extends State<SplashScreenPage> {
//   @override
//   void initState() {
//     super.initState();
//     _startSplashScreen();
//   }

// _startSplashScreen() async {
//   var duration = const Duration(seconds: 5);
//   return Timer(duration, () {
//     Navigator.of(context).pushReplacement(
//       MaterialPageRoute(builder: (_) {
//         // print(DotEnv().env['API_KEY']);
//         return MyApp();
//       }),
//     );
//   });
// }

//   // E6EFF9
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFE6EFF9),
//       body: Center(
//         child: Image.asset(
//           "images/globe.gif",
//           width: 300.0,
//           height: 200.0,
//         ),
//       ),
//     );
//   }
// }
