import 'package:flutter/material.dart';

class DocumentViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(),
            child: Center(
              child: Text('Document view'),
            ),
          ),
        ));
  }
}
