import 'package:flutter/material.dart';
import 'package:tbssystemdevelopment/models/user_model.dart';

import 'custom_text_widget.dart';

class NewUserDisplayCard extends StatelessWidget {
  final UserData user;

  const NewUserDisplayCard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 5,
                  color: Colors.black.withOpacity(0.23))
            ]),
        height: height*0.15,
        width: width,
        child: Row(
          children: [
            Container(
              width: width * 0.02,
              height: height * 0.1,
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
              width: width * 0.2,
              height: height * 0.15,
              child:  Padding(
                padding: EdgeInsets.all(width*0.05),
                child: Center(child: Image.asset(
                  "assets/images/contact.png",
                  fit: BoxFit.cover,
                )),
              ),
            ),
            Container(
              height: height * 0.15,
              width: width * 0.65,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextWidget(
                    text: '${user.first_name} ${user.last_name}',
                    factor: 1.2,
                  ),
                  SizedBox(height: height * 0.01),
                  Container(
                    width: width * 0.9,
                    height: height * 0.1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: width * 0.15,
                          height: height * 0.8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Location', style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 10 * width * 0.003,
                              )),
                              Text('Mobile', style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 10 * width * 0.003,
                              )),
                              Text('Code', style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 10 * width * 0.003,
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
                              Text('${user.location}'),
                              Text('${user.mobile_number}'),
                              Text('${user.code}'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
