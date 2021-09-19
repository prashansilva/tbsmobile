import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tbssystemdevelopment/models/dashboard_user_model.dart';
import 'package:tbssystemdevelopment/models/user_model.dart';
import 'package:tbssystemdevelopment/providers/dashboard_state.dart';
import 'package:tbssystemdevelopment/utils/colors.dart';
import 'package:tbssystemdevelopment/widgets/custom_text_widget.dart';
import 'package:tbssystemdevelopment/widgets/management_user_widget.dart';

class UserListScreen extends StatelessWidget {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final dashboardState = Provider.of<DashboardState>(context);
    final ScrollController _scrollController = new ScrollController();
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        Container(
            height: height * 0.25,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                offset: Offset(0, 10),
                blurRadius: 50,
                color: Colors.white.withOpacity(0.23),
              )
            ]), //
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Positioned(
                    child: Container(
                      height: height * 0.15,
                      width: width,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                              onPressed: () => {Navigator.of(context).pop()},
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              )),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Discussion Form',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16 * width * 0.003,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: primaryAppColor,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0)),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 4),
                                blurRadius: 5,
                                color: Colors.black.withOpacity(0.23))
                          ]),
                    )),
                Positioned(
                    top: height * 0.1,
                    child: Container(
                      height: height * 0.15,
                      width: width * 0.9,
                      child: Row(
                        children: [
                          Container(
                            width: width * 0.25,
                            height: height *0.15,
                            child:  Padding(
                              padding: EdgeInsets.all(width*0.05),
                              child: Center(child: Image.asset(
                                "assets/images/leader.png",
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
                                  text: 'Line Leaders',
                                  factor: 1.0
                                ),
                                SizedBox(height: height * 0.005),
                                Container(
                                  width: width * 0.65,
                                  height: height * 0.10,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: width * 0.25,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            CustomTextWidget(
                                              text: 'Head Count',
                                              factor: 0.8,
                                            ),
                                            Text(
                                              '${dashboardState.lineLeadersCountByManager}',
                                              style: TextStyle(
                                                color: themeColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16 * width * 0.003,
                                              ),
                                            ),
                                          ],
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
                                      Container(
                                        width: width * 0.38,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            CustomTextWidget(
                                              text: 'Submission Count',
                                              factor: 0.8,
                                            ),
                                            Text(
                                              '${dashboardState.lineLeadersTotalSubmissionByManager}',
                                              style: TextStyle(
                                                color: themeColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16 * width * 0.003,
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
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.all(Radius.circular(20.0)),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 4),
                                blurRadius: 5,
                                color: Colors.black.withOpacity(0.23))
                          ]),
                    )),
              ],
            )),
        dashboardState.loading
            ? SizedBox(
                height: height * 0.5,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : dashboardState.leadersList.length > 0
                ? Expanded(
                  child: SmartRefresher(
                      enablePullDown: false,
                      enablePullUp: true,
                      controller: _refreshController,
                      onLoading: () async {
                        _refreshController.loadNoData();
                      },
                      child: ListView.builder(
                          controller: _scrollController,
                          itemCount: dashboardState.leadersList.length,
                          itemBuilder: (context, index) {
                            DashboardMemberData user =
                                dashboardState.leadersList[index];
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ManageUserWidget(
                                user: user,
                              ),
                            );
                          }),
                      footer: CustomFooter(
                          builder: (BuildContext context, LoadStatus? mode) {
                        Widget body;
                        if (mode == LoadStatus.idle) {
                          body = Text("");
                        } else if (mode == LoadStatus.loading) {
                          body = CircularProgressIndicator();
                        } else if (mode == LoadStatus.failed) {
                          body = Text(
                            "Load Failed!Click retry!",
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          );
                        } else if (mode == LoadStatus.canLoading) {
                          body = Text(
                            "Release to load more",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          );
                        } else {
                          body = Text(
                            "No More Data",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          );
                        }
                        return Container(
                          height: 55.0,
                          child: Center(child: body),
                        );
                      }),
                    ),
                )
                : Container(
          height: height*0.4,
                    child: Center(
                        child: Text(
                      "No Line Leaders!",
                      style: TextStyle(fontSize: 18),
                    )),
                  )
      ],
    )));
  }
}
