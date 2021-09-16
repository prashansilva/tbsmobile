import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tbssystemdevelopment/locator.dart';
import 'package:tbssystemdevelopment/models/dashboard_model.dart';
import 'package:tbssystemdevelopment/models/user_model.dart';
import 'package:tbssystemdevelopment/providers/dashboard_state.dart';
import 'package:tbssystemdevelopment/providers/document_state.dart';
import 'package:tbssystemdevelopment/providers/user_state.dart';
import 'package:tbssystemdevelopment/screens/user_screens/user_login_screen.dart';
import 'package:tbssystemdevelopment/services/local_storage.dart';
import 'package:tbssystemdevelopment/utils/colors.dart';
import 'package:tbssystemdevelopment/utils/constants.dart';
import 'package:tbssystemdevelopment/widgets/custom_text_widget.dart';
import 'package:tbssystemdevelopment/widgets/home_report_widget.dart';
import 'package:tbssystemdevelopment/widgets/home_tile_widget.dart';
import 'package:provider/provider.dart';

//class HomeScreen extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    var width = MediaQuery.of(context).size.width;
//    var height = MediaQuery.of(context).size.height;
//    return Scaffold(
//        body: SafeArea(
//          child: Column(
//            children: [
//              Container(
//                height: height*0.2,
//                width: width,
//                decoration: BoxDecoration(
//                  color: primaryAppColor
//                ),
//                child: Column(
//                  children: [
//                    Row(
//                      children: [
//                        Spacer(),
//                        IconButton(onPressed: () => {logout(context)}, icon: Icon(Icons.exit_to_app, color: Colors.white,))
//                      ],
//                    )
//                  ],
//                ),
//              ),
//              Container(
//                height: height*0.7,
//                decoration: BoxDecoration(),
//                child: Padding(
//                  padding: EdgeInsets.all(width*0.05),
//                  child: GridView.count(
//                    primary: false,
//                    childAspectRatio: (1 / 0.6),
//                    crossAxisSpacing: width*0.05,
//                    mainAxisSpacing: width*0.05,
//                    crossAxisCount: 1,
//                    children: [
//                      HomeTileWidget(tileName: 'Documents', routeName: '/documentList',),
//                      HomeTileWidget(tileName: 'Create Document', routeName: '/discussion_form',),
//                    ],
//                  ),
//                ),
//              )
//            ],
//          ),
//        ));
//  }
//
//  void logout(context) {
//    Provider.of<UserState>(context, listen: false).userLogOut();
//    Navigator.pushAndRemoveUntil(
//        context,
//        PageRouteBuilder(pageBuilder: (BuildContext context,
//            Animation animation, Animation secondaryAnimation) {
//          return UserLoginScreen();
//        }, transitionsBuilder: (BuildContext context,
//            Animation<double> animation,
//            Animation<double> secondaryAnimation,
//            Widget child) {
//          return new SlideTransition(
//            position: new Tween<Offset>(
//              begin: const Offset(1.0, 0.0),
//              end: Offset.zero,
//            ).animate(animation),
//            child: child,
//          );
//        }),
//        (Route route) => false);
//  }
//}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  LocalStorage localStorage = locator<LocalStorage>();
  late UserData userData;
  var _isInit = true;
  var _isLoading = false;
  DashboardData dashboard = new DashboardData(
      totalCount: 0,
      todayCount: 0,
      leadersCount: 0,
      coordinatorsCount: 0,
      documents: []);

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    _isInit = false;
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
        _isInit = false;
      });
      Provider.of<DashboardState>(context).getDashboardData().then((value) => {
            if (mounted)
              {
                setState(() {
                  print(value.todayCount);
                  dashboard = value;
                  _isLoading = false;
                })
              }
          });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final dashboardState = Provider.of<DashboardState>(context);
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
              ]),
//            decoration: BoxDecoration(
//                color: Colors.white,
//                borderRadius: BorderRadius.only(
//                    bottomLeft: Radius.circular(20.0),
//                    bottomRight: Radius.circular(20.0)),
//                boxShadow: [
//                  BoxShadow(
//                      offset: Offset(0, 4),
//                      blurRadius: 5,
//                      color: Colors.black.withOpacity(0.23))
//                ]),
            child: _isLoading
                ? Container()
                : Stack(
              alignment: Alignment.topCenter,
              children: [
                Positioned(
                    child: Container(
                  height: height*0.15,
                  width: width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Today ${DateFormat.yMMMd().format(DateTime.now())}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 12 * width * 0.003,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      IconButton(
                          onPressed: () => {logout(context)},
                          icon: Icon(
                            Icons.exit_to_app,
                            color: Colors.white,
                          ))
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
                    top:height*0.1,
                    child: Container(
                      height: height*0.15,
                      width: width*0.9,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomTextWidget(text: 'Welcome ${userData.first_name} !', factor: 2.0,),
                          CustomTextWidget(text: '${renderRoleName(userData.role_code)}', factor: 1.0),
                          CustomTextWidget(text: '${userData.code}', factor: 1.0),
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 4),
                                blurRadius: 5,
                                color: Colors.black.withOpacity(0.23))
                          ]),
                    )),
              ],
            )
          ),
          _isLoading
              ? SizedBox(
                  height: height * 0.5,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Expanded(
                  child: SmartRefresher(
                    enablePullDown: true,
                    controller: _refreshController,
                    onRefresh: () async {
                      await dashboardState.getDashboardData().then((value) => {
                            if (value != null)
                              {
                                setState(() {
                                  dashboard = value;
                                }),
                              },
                            _refreshController.refreshCompleted()
                          });
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(),
                            child: Padding(
                                padding: EdgeInsets.all(width * 0.05),
                                child: Column(
                                  children: [
                                    Container(
                                      child: Row(
                                        children: renderReport(width*0.42, width*0.42, userData.role_code),
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      ),
                                    ),
                                    SizedBox(height: width*0.03,),
                                    Container(
                                      child: Row(
                                        children: renderReportTiles(width*0.42, width*0.42, userData.role_code),
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        children: [],
                                      ),
                                    )
                                  ],
                                )),
                          ),
                          Container(
                            decoration: BoxDecoration(),
                            child: Container(
                              height: height * 0.4,
                              decoration: BoxDecoration(),
                              child: Padding(
                                  padding: EdgeInsets.all(width * 0.05),
                                  child: GridView.count(
                                      primary: false,
                                      childAspectRatio: (1 / 0.5),
                                      crossAxisSpacing: width * 0.05,
                                      mainAxisSpacing: width * 0.05,
                                      crossAxisCount: 1,
                                      children: renderDocumentTypes(height * 0.4))),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
        ],
      ),
    ));
  }

  List<Widget> renderDocumentTypes(double height) {
    List<Widget> documentList = [];
    for (int i = 0; i < dashboard.documents.length; i++) {
      Widget widget = HomeTileWidget(
        height: height,
        tileName: '${dashboard.documents[i].documentName}',
        routeName: '/documentList',
        roleCode: userData.role_code,
        total: dashboard.documents[i].totalCount,
        daily: dashboard.documents[i].todayCount,
      );
      documentList.add(widget);
    }
    return documentList;
  }

  String renderRoleName(String role_code) {
    switch (role_code) {
      case '1':
        return 'Manager';
      case '2':
        return 'Line Leader';
      default:
        return 'Coordinator';
    }
  }

  List<Widget> renderReport(double height, double width, String role) {
    List<Widget> reportTileList = [];
    Widget totalCount = HomeReport(
      heading: 'Total Submission',
      count: '${dashboard.totalCount}',
      height: height,
      width: width,
      widgetCode: 'TS',
      roleCode: role,
    );
    Widget todayCount = HomeReport(
      heading: 'Daily Submission',
      count: '${dashboard.todayCount}',
      height: height,
      width: width,
      widgetCode: 'TD',
      roleCode: role,
    );
    reportTileList.add(totalCount);
    reportTileList.add(todayCount);
    return reportTileList;
  }

  List<Widget> renderReportTiles(double height, double width, String role) {
    List<Widget> reportTileList = [];
    Widget leadersCount = HomeReport(
      heading: 'Leaders',
      count: '${dashboard.leadersCount}',
      height: height,
      width: width,
      widgetCode: 'LL',
      roleCode: role,
    );
    Widget coordinatorsCount = HomeReport(
      heading: 'Coordinators',
      count: '${dashboard.coordinatorsCount}',
      height: height,
      width: width,
      widgetCode: 'C',
      roleCode: role,
    );
    if (role == '1') {
      reportTileList.add(leadersCount);
      reportTileList.add(coordinatorsCount);
    } else if (role == '2') {
      reportTileList.add(coordinatorsCount);
    }
    return reportTileList;
  }

  void logout(context) {
    Provider.of<UserState>(context, listen: false).userLogOut();
    Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(pageBuilder: (BuildContext context,
            Animation animation, Animation secondaryAnimation) {
          return UserLoginScreen();
        }, transitionsBuilder: (BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child) {
          return new SlideTransition(
            position: new Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        }),
        (Route route) => false);
  }

  getData() async {
    localStorage.getUserData().then((value) => setState(() {
          if (value != null) {
            userData = value;
          }
        }));
  }
}
