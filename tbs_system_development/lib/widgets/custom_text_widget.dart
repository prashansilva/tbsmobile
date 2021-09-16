import 'package:flutter/material.dart';

class CustomTextWidget extends StatelessWidget {
  final String text;
  final double factor;

  const CustomTextWidget({Key? key, required this.text, required this.factor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Text(
      '$text',
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 12 * width * 0.003 * factor,
      ),
    );
  }
}
