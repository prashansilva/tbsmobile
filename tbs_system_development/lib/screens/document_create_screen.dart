import 'package:flutter/material.dart';

class DocumentCreateScreen extends StatefulWidget {
  @override
  _DocumentCreateScreenState createState() => _DocumentCreateScreenState();
}

class _DocumentCreateScreenState extends State<DocumentCreateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(),
            child: Center(
              child: Text('Document create screen'),
            ),
          ),
        ));
  }
}
