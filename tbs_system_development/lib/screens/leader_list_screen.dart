import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tbssystemdevelopment/models/user_model.dart';
import 'package:tbssystemdevelopment/providers/dashboard_state.dart';
import 'package:tbssystemdevelopment/utils/constants.dart';
import 'package:tbssystemdevelopment/widgets/custom_text_widget.dart';
import 'package:tbssystemdevelopment/widgets/leader_card_widget.dart';

class LeaderListScreen extends StatelessWidget {
  final _usercode = TextEditingController();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _mobile = TextEditingController();
  final _location = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
          title: Text('Leaders'),
          actions: [
            IconButton(
                onPressed: () =>
                    {Navigator.of(context).pushNamed('/leaderRegister')},
                icon: FaIcon(FontAwesomeIcons.userPlus),)
          ],
        ),
        body: SafeArea(
            child: dashboardState.loading
                ? SizedBox(
                    height: height * 0.5,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : dashboardState.leaderListByManager.length > 0
                    ? SmartRefresher(
                        enablePullDown: false,
                        enablePullUp: true,
                        controller: _refreshController,
                        onLoading: () async {
                          _refreshController.loadNoData();
                        },
                        child: ListView.builder(
                            controller: _scrollController,
                            itemCount:
                                dashboardState.leaderListByManager.length,
                            itemBuilder: (context, index) {
                              UserData user =
                                  dashboardState.leaderListByManager[index];
                              return Container(
                                height: width * 0.4,
                                child: LeaderCardWidget(
                                  isManager: dashboardState.isManager,
                                  isCoordinator: false,
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
                          "No Leaders!",
                          style: TextStyle(fontSize: 18),
                        )),
                      )));
  }

}
