import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tbssystemdevelopment/models/form/discussion_form_model.dart';
import 'package:tbssystemdevelopment/providers/dashboard_fliter_state.dart';
import 'package:tbssystemdevelopment/utils/colors.dart';
import 'package:tbssystemdevelopment/utils/constants.dart';
import 'package:tbssystemdevelopment/widgets/discussion_form_widget.dart';

class DocumentFilterScreen extends StatelessWidget {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final dashboardFilterState = Provider.of<DashboardFilterState>(context);
    final ScrollController _scrollController = new ScrollController();
    return Scaffold(
        appBar: AppBar(
          title: Text('Forms'),
          bottom: PreferredSize(
              child: Container(
                width: width,
                color: primaryAppColor,
                height: height * 0.05,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Center(
                      child: Text('Count ${dashboardFilterState.totalCount}'),
                    ),
                    Center(
                        child: (dashboardFilterState.startDate.year == DateTime.parse('1990-01-01').year)
                            ? Text('All of time')
                            : Text(
                                '${DateFormat.yMMMd().format(dashboardFilterState.startDate)} - ${DateFormat.yMMMd().format(dashboardFilterState.endDate)}')),
                  ],
                ),
              ),
              preferredSize: Size.fromHeight(height * 0.05)),
          actions: [
            IconButton(
                onPressed: () => {showingModalBottomSheet(context, dashboardFilterState)},
                icon: FaIcon(FontAwesomeIcons.filter),)
          ],
        ),
        body: SafeArea(
            child: dashboardFilterState.loading
                ? SizedBox(
                    height: height * 0.5,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : dashboardFilterState.documentList.length > 0
                    ? SmartRefresher(
                        enablePullDown: false,
                        enablePullUp: true,
                        controller: _refreshController,
                        onLoading: () async {
                          await dashboardFilterState
                              .getDiscussionDocumentList()
                              .then((value) => {
                                    if (value != null && value.length > 0)
                                      {_refreshController.loadComplete()}
                                    else
                                      {_refreshController.loadNoData()}
                                  });
                        },
                        child: ListView.builder(
                            controller: _scrollController,
                            itemCount:
                            dashboardFilterState.documentList.length,
                            itemBuilder: (context, index) {
                              DiscussionFormData document =
                              dashboardFilterState.documentList[index];
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: DiscussionFormWidget(
                                  document: document,
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
                          "No Documents!",
                          style: TextStyle(fontSize: 18),
                        )),
                      )));
  }

  showingModalBottomSheet(context, DashboardFilterState dashboardFilterState) {
    DateTime startDate = DateTime.now();
    DateTime endDate = DateTime.now();
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setState /*You can rename this!*/) {
            return SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: 54,
                          child: Text('Filters'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: Center(
                                child: Text('Start date'),
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    child: Text(
                                        '${DateFormat.yMMMd().format(startDate)}'),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      DatePicker.showDatePicker(context,
                                          showTitleActions: true,
                                          maxTime: DateTime.now(),
                                          onConfirm: (date) {
                                        setState(() {
                                          startDate = date;
                                        });
                                      });
                                    },
                                    icon: Icon(
                                      Icons.calendar_today,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: Center(
                                child: Text('End date'),
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    child: Text(
                                        '${DateFormat.yMMMd().format(endDate)}'),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      DatePicker.showDatePicker(context,
                                          showTitleActions: true,
                                          maxTime: DateTime.now(),
                                          onConfirm: (date) {
                                        setState(() {
                                          endDate = date;
                                        });
                                      });
                                    },
                                    icon: Icon(
                                      Icons.calendar_today,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Color(appThemeColor),
                                fixedSize: Size(
                                    MediaQuery.of(context).size.width,
                                    MediaQuery.of(context).size.height * 0.08),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50))),
                            child: Text(
                              'Apply',
                            ),
                            onPressed: () {
                              dashboardFilterState.resetFilterDetails(
                                  startDate, endDate);
                              dashboardFilterState.getDiscussionDocumentList();
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }
}
