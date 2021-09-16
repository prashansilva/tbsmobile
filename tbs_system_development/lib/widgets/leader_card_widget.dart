import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tbssystemdevelopment/models/user_model.dart';
import 'package:tbssystemdevelopment/providers/dashboard_state.dart';
import 'package:tbssystemdevelopment/utils/colors.dart';
import 'package:tbssystemdevelopment/widgets/custom_text_widget.dart';

class LeaderCardWidget extends StatelessWidget {
  final UserData user;
  final bool isCoordinator;
  final bool isManager;

  const LeaderCardWidget(
      {Key? key, required this.user, required this.isCoordinator, required this.isManager})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final dashboardState = Provider.of<DashboardState>(context);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: height * 0.15,
        width: width,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 5,
                  color: Colors.black.withOpacity(0.23))
            ]),
        child: Row(
          children: [
            Container(
              width: width * 0.7,
              child: Padding(
                padding: EdgeInsets.all(height * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomTextWidget(
                        text: 'Name : ${user.first_name} ${user.last_name}',
                        factor: 1.0),
                    CustomTextWidget(
                        text: 'Location : ${user.location}', factor: 1.0),
                    CustomTextWidget(
                        text: 'Contact No : ${user.mobile_number}',
                        factor: 1.0),
                    CustomTextWidget(text: 'Code : ${user.code}', factor: 1.0),
                  ],
                ),
              ),
            ),
            Spacer(),
            isCoordinator && isManager
                ? GestureDetector(
              onTap: () {showingModalBottomSheet(context, dashboardState);},
                  child: Container(
                      width: width * 0.2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                          color: primaryAppColor,
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 4),
                                blurRadius: 5,
                                color: Colors.black.withOpacity(0.23))
                          ]),
                      child: Padding(
                        padding: EdgeInsets.all(height * 0.01),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FaIcon(FontAwesomeIcons.user),
                                FaIcon(FontAwesomeIcons.levelUpAlt),
                              ],
                            ),
                            SizedBox(
                              height: height*0.01,
                            ),
                            CustomTextWidget(text: 'Upgrade', factor: 1.0),
                          ],
                        ),
                      )),
                )
                : Container(
                    width: width * 0.2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 4),
                              blurRadius: 5,
                              color: Colors.black.withOpacity(0.23))
                        ]),
                    child: Padding(
                      padding: EdgeInsets.all(height * 0.01),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(FontAwesomeIcons.userTie),
                        ],
                      ),
                    )),
          ],
        ),
      ),
    );
  }

  showingModalBottomSheet(context, DashboardState dashboardState) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setState /*You can rename this!*/) {
            return SingleChildScrollView(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: Center(child: Text('Do you want to upgrade the coordinator ?')),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () { Navigator.pop(context);},
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),),
                                color: Colors.red,
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 4),
                                      blurRadius: 5,
                                      color: Colors.black.withOpacity(0.23))
                                ]),
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: MediaQuery.of(context).size.height * 0.05,
                            child: Center(
                              child: Text('No'),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            dashboardState.upgradeCoordinatorByManger(user.id).then((value) => {
                              if (value.status) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value.message))),
                                dashboardState.getCoordinatorsByManger().then((
                                    value) => Navigator.pop(context))
                              }
                              else {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value.message))),
                                Navigator.pop(context),
                              }
                            }).catchError((onError) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Something went wrong')));
                            });
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),),
                                  color: primaryAppColor,
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(0, 4),
                                        blurRadius: 5,
                                        color: Colors.black.withOpacity(0.23))
                                  ]),
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: MediaQuery.of(context).size.height * 0.05,
                            child: Center(child: Text('Yes'))
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }

}
