import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tbssystemdevelopment/models/form/discussion_form_model.dart';
import 'package:tbssystemdevelopment/widgets/custom_text_widget.dart';

class DiscussionFormWidget extends StatelessWidget {
  final DiscussionFormData document;

  const DiscussionFormWidget({Key? key, required this.document}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: height*0.15,
      width: width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 4),
                blurRadius: 5,
                color: Colors.black
                    .withOpacity(0.23))
          ]),
      child: Row(
        children: [
          Container(
              width: width*0.3,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 5,
                        color: Colors.black
                            .withOpacity(0.23))
                  ]),
              child: Padding(
                padding: EdgeInsets.all(height*0.01),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomTextWidget(text: '${document.code}',factor: 1.0),
                    CustomTextWidget(text: '${DateFormat.yMMMd().format(DateTime.parse(document.date))}',factor: 1.0),
                  ],
                ),
              )),
          Spacer(),
          Container(
            width: width*0.6,
            child: Padding(
              padding: EdgeInsets.all(height*0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomTextWidget(text: 'Discussor : ${document.discussor}',factor: 1.0),
                  CustomTextWidget(text: 'Prospector : ${document.prospector}',factor: 1.0),
                  CustomTextWidget(text: 'Contact No : ${document.contact}',factor: 1.0),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
