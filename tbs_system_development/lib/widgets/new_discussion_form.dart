import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tbssystemdevelopment/models/form/discussion_form_model.dart';
import 'package:tbssystemdevelopment/utils/colors.dart';

import 'custom_text_widget.dart';

class NewDiscussionFormWidget extends StatelessWidget {
  final DiscussionFormData document;
  final double height;
  final double width;

  const NewDiscussionFormWidget({Key? key, required this.document, required this.height, required this.width}) : super(key: key);
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
                color:themeColor,
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
            height: height * 0.8,
            width: width * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${DateFormat.yMMMd().format(DateTime.parse(document.date))}', style: TextStyle(
                  color: Colors.grey.shade400,
                  fontWeight: FontWeight.bold,
                  fontSize: 12 * width * 0.003,
                ),),
                SizedBox(height: height * 0.08),
                Container(
                  width: width * 0.9,
                  height: height * 0.45,
                  child: Row(
                    children: [
                      Container(
                        width: width * 0.3,
                        height: height * 0.8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Presenter', style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 14 * width * 0.003,
                            )),
                            Text('Prospector', style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 14 * width * 0.003,
                            )),
                            Text('Contact No', style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 14 * width * 0.003,
                            )),
                          ],
                        ),
                      ),
                      Container(
                        width: width * 0.05,
                        child: Column(
                          children: [
                            Text(':'),
                            Text(':'),
                            Text(':'),
                          ],
                        )
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${document.discussor}'),
                            Text('${document.prospector}'),
                            Text('${document.contact}'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: width * 0.9,
                  child: Row(
                    children: [
                      Spacer(),
                      Container(
                        alignment: Alignment.centerLeft,
                        width:  width * 0.4,
                        height: height*0.15,
                        color: Colors.blue,
                        child: Text('${document.code}'),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
