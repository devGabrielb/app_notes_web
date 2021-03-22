import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 7,
      borderRadius: BorderRadius.circular(5),
      child: Container(
        padding: EdgeInsets.only(bottom: 3, top: 3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        child: TextField(
          decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              border: InputBorder.none,
              prefixIcon: Icon(Icons.search),
              hintText: "Search Notes..."),
        ),
      ),
    );
  }
}
