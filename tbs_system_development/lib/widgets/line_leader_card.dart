import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tbssystemdevelopment/providers/dashboard_state.dart';
import 'package:tbssystemdevelopment/utils/colors.dart';

import 'custom_text_widget.dart';

class LineLeaderCardWidget extends StatelessWidget {
  final double height;
  final double width;
  final int count;
  final int headCount;

  const LineLeaderCardWidget({Key? key, required this.height, required this.width, required this.count, required this.headCount}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final dashboardState = Provider.of<DashboardState>(context);
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
            child:  Padding(
              padding: EdgeInsets.all(width*0.05),
              child: Center(child: Image.asset(
                "assets/images/leader.png",
                fit: BoxFit.cover,
              )),
            ),
          ),
          Container(
            height: height * 0.8,
            width: width * 0.65,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextWidget(
                  text: 'Line Leaders',
                  factor: 1.2,
                ),
                SizedBox(height: height * 0.08),
                Container(
                  width: width * 0.9,
                  height: height * 0.45,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          dashboardState.resetLeadersScreen();
                          dashboardState.getLeadersByManger();
                          Navigator.of(context).pushNamed('/leaderList');
                        },
                        child: Container(
                          width: width * 0.25,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomTextWidget(
                                text: 'Head Count',
                                factor: 0.8,
                              ),
                              Text(
                                '$headCount',
                                style: TextStyle(
                                  color: themeColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 2 * width * 0.03,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
                      GestureDetector(
                        onTap: () {
                          dashboardState.resetLeaders();
                          dashboardState.getLeadersList();
                          Navigator.of(context).pushNamed('/userList');
                        },
                        child: Container(
                          width: width * 0.38,
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
