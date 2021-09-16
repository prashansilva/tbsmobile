import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tbssystemdevelopment/models/dashboard_user_model.dart';
import 'package:tbssystemdevelopment/models/user_model.dart';
import 'package:tbssystemdevelopment/providers/dashboard_state.dart';
import 'package:tbssystemdevelopment/utils/colors.dart';
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
        appBar: AppBar(
          bottom: PreferredSize(
              child: Container(
                width: width,
                color: primaryAppColor,
                height: height * 0.05,
                child: Center(child: Text('Discussion Forms')),
              ),
              preferredSize: Size.fromHeight(height * 0.05)),
          title: Text('Leaders'),
        ),
        body: SafeArea(
            child: dashboardState.loading
                ? SizedBox(
                    height: height * 0.5,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : dashboardState.leadersList.length > 0
                    ? SmartRefresher(
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
                      )
                    : Container(
                        child: Center(
                            child: Text(
                          "No Line Leaders!",
                          style: TextStyle(fontSize: 18),
                        )),
                      )));
  }
}
