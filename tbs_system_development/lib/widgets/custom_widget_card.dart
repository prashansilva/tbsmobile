import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tbssystemdevelopment/utils/colors.dart';

import 'custom_text_widget.dart';

class CustomDashboardWidget extends StatelessWidget {
  final double height;
  final double width;
  final int count;
  final String heading;

  const CustomDashboardWidget(
      {Key? key,
      required this.height,
      required this.width,
      required this.count,
      required this.heading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 4),
                blurRadius: 5,
                color: Colors.black.withOpacity(0.23))
          ]),
      height: height,
      width: width,
      child: Row(
        children: [
          Container(
            width: width * 0.05,
            height: height * 0.8,
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 5,
                      color: Colors.black.withOpacity(0.23))
                ]),
          ),
          Container(
            height: height * 0.8,
            width: width * 0.92,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTextWidget(
                  text: '$heading',
                  factor: 1,
                ),
                SizedBox(height: height * 0.08),
                Text(
                  '$count',
                  style: TextStyle(
                    color: themeColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 6 * width * 0.03,
                  ),
                ),
                SizedBox(height: height * 0.01),
                Container(
                  width: width * 0.65,
                  child: Row(
                    children: [
                      Spacer(),
                      FaIcon(FontAwesomeIcons.arrowRight, color: Colors.grey,),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
