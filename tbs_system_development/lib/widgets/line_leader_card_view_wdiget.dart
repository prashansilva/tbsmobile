//import 'package:flutter/material.dart';
//import 'package:tbssystemdevelopment/utils/colors.dart';
//
//import 'custom_text_widget.dart';
//
//class LineLeaderViewCard extends StatelessWidget {
//  final double height;
//  final double width;
//  final int count;
//  final int headCount;
//
//  const LineLeaderViewCard({Key? key, required this.height, required this.width, required this.count, required this.headCount}) : super(key: key);
//
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      height: height*0.15,
//      width: width,
//      decoration: BoxDecoration(
//          color: Colors.white,
//          borderRadius: BorderRadius.circular(20),
//          boxShadow: [
//            BoxShadow(
//                offset: Offset(0, 4),
//                blurRadius: 5,
//                color: Colors.black
//                    .withOpacity(0.23))
//          ]),
//      child: Row(
//        children: [
//          Container(
//              width: width*0.55,
//              child: Padding(
//                padding: EdgeInsets.all(height*0.01),
//                child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                  children: [
//                    CustomTextWidget(text: 'Code : ${user.code}', factor: 1.0,),
//                    CustomTextWidget(text: 'Name : ${user.first_name} ${user.last_name}',factor: 1.0),
//                    CustomTextWidget(text: 'Location : ${user.location}',factor: 1.0),
//                    CustomTextWidget(text: 'Contact : ${user.mobile_number}',factor: 1.0),
//                  ],
//                ),
//              )),
//          Spacer(),
//          Container(
//            width: width*0.2,
//            decoration: BoxDecoration(
//                color: Colors.white,
//                boxShadow: [
//                  BoxShadow(
//                      offset: Offset(0, 4),
//                      blurRadius: 5,
//                      color: Colors.black
//                          .withOpacity(0.23))
//                ]),
//            child: Padding(
//              padding: EdgeInsets.all(height*0.02),
//              child: Column(
//                crossAxisAlignment: CrossAxisAlignment.center,
//                children: [
//                  CustomTextWidget(text: 'Total',factor: 0.8),
//                  SizedBox(height: height*0.02,),
//                  CustomTextWidget(text: '${user.totalCount}',factor: 2.0),
//                ],
//              ),
//            ),
//          ),
//          Container(
//            width: width*0.2,
//            decoration: BoxDecoration(
//                borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
//                color: Colors.white,
//                boxShadow: [
//                  BoxShadow(
//                      offset: Offset(0, 4),
//                      blurRadius: 5,
//                      color: Colors.black
//                          .withOpacity(0.23))
//                ]),
//            child: Padding(
//              padding: EdgeInsets.all(height*0.02),
//              child: Column(
//                crossAxisAlignment: CrossAxisAlignment.center,
//                children: [
//                  CustomTextWidget(text: 'Daily',factor: 0.8),
//                  SizedBox(height: height*0.02,),
//                  CustomTextWidget(text: '${user.todayCount}',factor: 2.0),
//                ],
//              ),
//            ),
//          )
//        ],
//      ),
//    )
//  }
//}
