import 'dart:convert';

import 'package:first_app/utils/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

import './detailNews_screen.dart';
import './login_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String apiKey = DotEnv().env["API_KEY"];
  List data;
  var index = 1;
  bool isSearching = false;
  final searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    this.getJsonData(page: index);
  }

  Future<bool> getJsonData({int page, String keyword = 'bitcoin'}) async {
    try {
      var response = await http.get(
        Uri.encodeFull(
            "http://newsapi.org/v2/everything?q=${keyword}&apiKey=${apiKey}&pageSize=10&page=${page}"),
        headers: {"Accept": "application/json"},
      );

      setState(() {
        var convertDataToJSON = json.decode(response.body);
        data = convertDataToJSON['articles'];
      });

      return true;
    } catch (err) {
      print(err.toString());
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: !this.isSearching
                ? Text('Home Page')
                : TextField(
                    style: TextStyle(color: Colors.white),
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: "Searching...",
                      icon: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          setState(() {
                            this.isSearching = false;
                          });
                        },
                      ),
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                  ),
            actions: <Widget>[
              !this.isSearching
                  ? IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        setState(() {
                          this.isSearching = true;
                        });
                      },
                    )
                  : IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        setState(() async {
                          index = 1;
                          if (searchController.text != '') {
                            var resp = await this.getJsonData(
                                page: index, keyword: searchController.text);
                            if (!resp) {
                              return AlertDialog(
                                content: Text("An error occurred"),
                              );
                            } else {
                              setState(() {
                                this.isSearching = false;
                              });
                            }
                          } else {
                            return AlertDialog(
                              content: Text("An error occurred"),
                            );
                          }
                        });
                      },
                    ),
              Padding(
                padding: EdgeInsets.only(right: 20.0, top: 20.0),
                child: GestureDetector(
                  child: Text(
                    "Logout",
                  ),
                  onTap: () {
                    AuthProvider().logOut();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => LoginScreen()));
                  },
                ),
              )
            ],
          ),
          body: Column(children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Page ${index}",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            data == null
                ? Text("loading...")
                : Expanded(
                    child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 10.0),
                        width: double.infinity,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              GestureDetector(
                                child: Column(
                                  children: <Widget>[
                                    FadeInImage.assetNetwork(
                                      image: data[index]['urlToImage'],
                                      placeholder: 'images/image-blank.png',
                                      width: double.infinity,
                                      height: 195.0,
                                    ),
                                    Card(
                                      child: Container(
                                        width: double.infinity,
                                        child: Text(data[index]['title']),
                                        padding: EdgeInsets.all(20.0),
                                      ),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              DetailNewsScreen(
                                                  data[index]['urlToImage'],
                                                  data[index]['title'],
                                                  data[index]['author'],
                                                  data[index]['description'],
                                                  data[index]['content'])));
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: data == null ? 0 : data.length,
                  )),
            _navigationPage(),
          ]),
        ));
  }

  Widget _navigationPage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
            width: 115.0,
            padding: EdgeInsets.only(right: 7.0),
            child: RaisedButton.icon(
              onPressed: index > 1
                  ? () {
                      setState(() async {
                        index = index - 1;
                        await getJsonData(page: index);
                      });
                    }
                  : null,
              icon: Text('Before'),
              label: Icon(
                Icons.navigate_before,
                size: 30.0,
              ),
            )),
        Container(
            width: 115.0,
            padding: EdgeInsets.only(left: 7.0),
            child: RaisedButton.icon(
              onPressed: () {
                setState(() async {
                  index = index + 1;
                  await getJsonData(page: index);
                });
              },
              icon: Icon(
                Icons.navigate_next,
                size: 30.0,
              ),
              label: Text('Next'),
            )),
      ],
    );
  }
}
