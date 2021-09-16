import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tbssystemdevelopment/locator.dart';
import 'package:tbssystemdevelopment/providers/dashboard_state.dart';
import 'package:tbssystemdevelopment/providers/document_state.dart';
import 'package:tbssystemdevelopment/services/local_storage.dart';
import 'package:tbssystemdevelopment/utils/colors.dart';
import 'package:provider/provider.dart';

class HomeTileWidget extends StatelessWidget {
  final String tileName;
  final String routeName;
  final int total;
  final int daily;
  final String roleCode;
  final double height;

  const HomeTileWidget(
      {Key? key,
      required this.tileName,
      required this.routeName,
      required this.roleCode, required this.total, required this.daily, required this.height})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final documentState = Provider.of<DocumentState>(context);
    final dashboardState = Provider.of<DashboardState>(context);
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => {
        tapAction(routeName, context, documentState, dashboardState, roleCode)
      },
      child: Container(
        decoration: BoxDecoration(
            color: primaryAppColor,
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
              width: width * 0.35,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: renderTileName(context, roleCode, width),
              ),
            ),
            Spacer(),
            Container(
              width: width * 0.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: width * 0.5,
                    height: width*0.225,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),),
                        color: primaryAppColor,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 4),
                              blurRadius: 5,
                              color: Colors.black.withOpacity(0.23))
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Today',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12 * width * 0.003,
                          ),
                        ),
                        Text(
                          '$daily',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 40 * width * 0.003),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: width * 0.5,
                    height: width*0.22,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20),),
                        color: primaryAppColor, boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 4),
                          blurRadius: 5,
                          color: Colors.black.withOpacity(0.23)),
                    ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Total',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12 * width * 0.003,
                          ),
                        ),
                        Text(
                          '$total',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 40 * width * 0.003),
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

  List<Widget> renderTileName(context, String roleCode, double width) {
    List<Widget> list = [];
    Widget text = Center(child: Text(
      tileName,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16 * width * 0.003,
      ),
    ),);
    list.add(text);
//    if(roleCode == '3') {
//      Widget add = IconButton(
//          onPressed: () => {
//            Navigator.of(context).pushNamed('/discussion_form')
//          },
//          icon: FaIcon(FontAwesomeIcons.fileAlt));
//      list.add(add);
//    }
    Widget add = IconButton(
        onPressed: () => {
          Navigator.of(context).pushNamed('/discussion_form')
        },
        icon: FaIcon(FontAwesomeIcons.fileAlt));
    list.add(add);
    return list;
  }

  void tapAction(String route, context, DocumentState documentState,
      DashboardState dashboardState, String roleCode) async {
    LocalStorage localStorage = locator<LocalStorage>();
    late String managerCode;
    late String leaderCode;
    late String coordinatorCode;
    switch (roleCode) {
      case '1':
        await localStorage.getUserData().then((value) => {
              if (value != null) {managerCode = value.id}
            });
        dashboardState.resetLeaders();
        dashboardState.getLeadersList(managerCode);
        Navigator.of(context).pushNamed('/userList');
        break;
      case '2':
        await localStorage.getUserData().then((value) => {
              if (value != null) {leaderCode = value.id}
            });
        dashboardState.resetCoordinators();
        dashboardState.getCoordinatorsList(leaderCode);
        Navigator.of(context).pushNamed('/coordinatorList');
        break;
      default:
        await localStorage.getUserData().then((value) => {
              if (value != null) {coordinatorCode = value.id}
            });
        documentState.resetData(coordinatorCode, true);
        documentState.getDiscussionDocumentList();
        Navigator.of(context).pushNamed('/discussionList');
        break;
    }
  }
}
