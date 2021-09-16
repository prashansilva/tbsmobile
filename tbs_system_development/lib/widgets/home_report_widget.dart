import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tbssystemdevelopment/providers/dashboard_fliter_state.dart';
import 'package:tbssystemdevelopment/providers/dashboard_state.dart';
import 'package:tbssystemdevelopment/utils/colors.dart';

class HomeReport extends StatelessWidget {
  final String heading;
  final String count;
  final double height;
  final double width;
  final String widgetCode;
  final String roleCode;

  const HomeReport({Key? key, required this.heading, required this.count, required this.height, required this.width, required this.widgetCode, required this.roleCode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dashboardFilter = Provider.of<DashboardFilterState>(context);
    final dashboardState = Provider.of<DashboardState>(context);
    var widthW = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => {
        tapAction(widgetCode, context, dashboardFilter, dashboardState, roleCode)
      },
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: primaryAppColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 5,
                  color: Colors.black
                      .withOpacity(0.23))
            ]),
        padding: EdgeInsets.all(height*0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              heading,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12*widthW*0.003,
              ),
            ),
            Text(
              count,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 40*widthW*0.003
              ),
            ),
          ],
        ),
      ),
    );
  }

  void tapAction(String widgetCode, context, DashboardFilterState dashboardFilterState, DashboardState dashboardState, String roleCode
      ) async {
    switch (widgetCode) {
      case 'TS':
        dashboardFilterState.resetDataTotal();
        dashboardFilterState.getDiscussionDocumentList();
        Navigator.of(context).pushNamed('/documentFilterScreen');
        break;
      case 'TD':
        dashboardFilterState.resetDataDaily();
        dashboardFilterState.getDiscussionDocumentList();
        Navigator.of(context).pushNamed('/documentFilterScreen');
        break;
      case 'LL':
        dashboardState.resetLeadersScreen();
        dashboardState.getLeadersByManger();
        Navigator.of(context).pushNamed('/leaderList');
        break;
      case 'C':
        dashboardState.resetCoordinatorsScreen();
        if(roleCode == "1") {
          dashboardState.getCoordinatorsByManger();
        }
        else {
          dashboardState.getCoordinatorsByLeader();
        }
        Navigator.of(context).pushNamed('/coordinatorListByManager');
        break;
      default:
        dashboardFilterState.resetDataDaily();
        break;
    }

  }
}
