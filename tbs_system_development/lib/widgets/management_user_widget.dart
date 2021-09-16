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
                width: width*0.55,
                child: Padding(
                  padding: EdgeInsets.all(height*0.01),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomTextWidget(text: 'Code : ${user.code}', factor: 1.0,),
                      CustomTextWidget(text: 'Name : ${user.first_name} ${user.last_name}',factor: 1.0),
                      CustomTextWidget(text: 'Location : ${user.location}',factor: 1.0),
                      CustomTextWidget(text: 'Contact : ${user.mobile_number}',factor: 1.0),
                    ],
                  ),
                )),
            Spacer(),
            Container(
              width: width*0.2,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 5,
                        color: Colors.black
                            .withOpacity(0.23))
                  ]),
              child: Padding(
                padding: EdgeInsets.all(height*0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomTextWidget(text: 'Total',factor: 0.8),
                    SizedBox(height: height*0.02,),
                    CustomTextWidget(text: '${user.totalCount}',factor: 2.0),
                  ],
                ),
              ),
            ),
            Container(
              width: width*0.2,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 5,
                        color: Colors.black
                            .withOpacity(0.23))
                  ]),
              child: Padding(
                padding: EdgeInsets.all(height*0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomTextWidget(text: 'Daily',factor: 0.8),
                    SizedBox(height: height*0.02,),
                    CustomTextWidget(text: '${user.todayCount}',factor: 2.0),
                  ],
                ),
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
        dashboardState.getCoordinatorsList(userId);
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
