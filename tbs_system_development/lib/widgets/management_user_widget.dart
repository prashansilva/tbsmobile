import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tbssystemdevelopment/locator.dart';
import 'package:tbssystemdevelopment/models/dashboard_user_model.dart';
import 'package:tbssystemdevelopment/providers/dashboard_state.dart';
import 'package:tbssystemdevelopment/providers/document_state.dart';
import 'package:tbssystemdevelopment/services/local_storage.dart';
import 'package:tbssystemdevelopment/utils/colors.dart';
import 'package:tbssystemdevelopment/widgets/custom_text_widget.dart';

class ManageUserWidget extends StatelessWidget {
  final DashboardMemberData user;

  const ManageUserWidget({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final documentState = Provider.of<DocumentState>(context);
    final dashboardState = Provider.of<DashboardState>(context);
    return GestureDetector(
      onTap: () => {tapAction(context, documentState, dashboardState, user.role_code, user.id)},
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
                      mainAxisAlignment: user.role_code == '2' ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
                      children: [
                        user.role_code == '2' ? Container(
                          width: width * 0.25,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomTextWidget(
                                text: 'Head Count',
                                factor: 0.8,
                              ),
                              Text(
                                '${user.coordinatorsCount}',
                                style: TextStyle(
                                  color: themeColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 2 * width * 0.03,
                                ),
                              ),
                            ],
                          ),
                        ) : Container(
                          width: width * 0.25,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomTextWidget(
                                text: 'Today',
                                factor: 0.8,
                              ),
                              Text(
                                '${user.todayCount}',
                                style: TextStyle(
                                  color: themeColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 2 * width * 0.03,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: width * 0.01,
                          height: height * 0.5,
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
                          width: width * 0.38,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomTextWidget(
                                text: 'Submission Count',
                                factor: 0.8,
                              ),
                              Text(
                                '${user.totalCount}',
                                style: TextStyle(
                                  color: themeColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 2 * width * 0.03,
                                ),
                              ),
                              user.role_code == '2' ? Row(
                                children: [
                                  Spacer(),
                                  Text('Today', style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 1 * width * 0.03,
                                  )),
                                  SizedBox(width: width * 0.05,),
                                  Text(
                                    '${user.todayCount}',
                                    style: TextStyle(
                                      color: themeColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 1.5 * width * 0.03,
                                    ),
                                  ),

                                ],
                              ) : Container()
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
      ),
    );
  }

  void tapAction(context ,DocumentState documentState, DashboardState dashboardState, String roleCode, String userId) async {
    switch (roleCode) {
      case '2':
        dashboardState.resetCoordinators();
        dashboardState.getCoordinatorsListByManager(userId);
        Navigator.of(context).pushNamed('/coordinatorList');
        break;
      default:
        documentState.resetData(userId, false);
        documentState.getDiscussionDocumentList();
        Navigator.of(context).pushNamed('/discussionList');
        break;
    }
  }
}
