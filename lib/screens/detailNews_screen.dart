import 'package:flutter/material.dart';

class DetailNewsScreen extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String author;
  final String description;
  final String content;

  DetailNewsScreen(
    this.imageUrl,
    this.title,
    this.author,
    this.description,
    this.content,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie Detail"),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                title,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10.0, bottom: 10.0),
              child: Row(
                children: <Widget>[
                  Text(
                    "Author : ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    author,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            FadeInImage.assetNetwork(
                placeholder: "images/image-blank.png", image: imageUrl),
            Padding(
              padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 25.0),
              child: Text(
                description,
                style: TextStyle(fontSize: 18.0, color: Colors.grey),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                content,
                style: TextStyle(height: 1.5),
              ),
            )
          ],
        ),
      ),
    );
  }
}
