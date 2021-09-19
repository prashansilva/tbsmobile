import 'package:flutter/material.dart';
import 'package:tbssystemdevelopment/utils/colors.dart';

import 'custom_text_widget.dart';

class MyPersonalCard extends StatelessWidget {
  final double height;
  final double width;
  final int count;

  const MyPersonalCard({Key? key, required this.height, required this.width, required this.count}) : super(key: key);

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
            width: width * 0.025,
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
            width: width * 0.3,
            height: height * 0.8,
            child: Padding(
              padding: EdgeInsets.all(width*0.05),
              child: Center(child: Image.asset(
                "assets/images/leader.png",
                fit: BoxFit.cover,
              )),
            ),
          ),
          Container(
            height: height * 0.8,
            width: width * 0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextWidget(
                  text: 'My Personal',
                  factor: 1.2,
                ),
                SizedBox(height: height * 0.08),
                Container(
                  width: width * 0.65,
                  height: height * 0.45,
                  child: Row(
                    children: [
                      Container(
                        width: width * 0.01,
                        height: height * 0.8,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 4),
                                  blurRadius: 5,
                                  color: Colors.black.withOpacity(0.23))
                            ]),
                      ),
                      Container(
                        width: width * 0.1,
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomTextWidget(
                              text: 'Submission Count',
                              factor: 0.8,
                            ),
                            Text(
                              '$count',
                              style: TextStyle(
                                color: themeColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 2 * width * 0.03,
                              ),
                            ),
                          ],
                        ),
                      )
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
