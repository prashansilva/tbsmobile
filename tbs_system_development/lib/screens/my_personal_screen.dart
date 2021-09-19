import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tbssystemdevelopment/models/form/discussion_form_model.dart';
import 'package:tbssystemdevelopment/providers/document_state.dart';
import 'package:tbssystemdevelopment/utils/colors.dart';
import 'package:tbssystemdevelopment/utils/constants.dart';
import 'package:tbssystemdevelopment/widgets/custom_text_widget.dart';
import 'package:tbssystemdevelopment/widgets/discussion_form_widget.dart';
import 'package:tbssystemdevelopment/widgets/new_discussion_form.dart';

class MyPersonalListScreen extends StatelessWidget {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final documentState = Provider.of<DocumentState>(context);
    final ScrollController _scrollController = new ScrollController();
    return Scaffold(
      bottomNavigationBar: Container(
        height: height*0.05,
        decoration: BoxDecoration(
            color: themeColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0)),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 5,
                  color: Colors.black.withOpacity(0.23))
            ]),
        child: Center(

          child: IconButton(
              onPressed: () =>
              {Navigator.of(context).pushNamed('/discussion_form')},
              icon: Icon(
                Icons.create_new_folder,
                color: Colors.white,
              ))
        ),
      ),
        body: SafeArea(
      child: Container(
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
                                'Discussion Forms',
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
                      top: height * 0.07,
                      child: Container(
                        height: height * 0.175,
                        width: width * 0.9,
                        child: Row(
                          children: [
                            Container(
                              height: height * 0.15,
                              width: width * 0.2,
                              child: Padding(
                                padding: EdgeInsets.all(width*0.05),
                                child: Center(child: Image.asset(
                                  "assets/images/leader.png",
                                  fit: BoxFit.cover,
                                )),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomTextWidget(
                                      text: 'My Personal',
                                      factor: 1.0,
                                    ),
                                    SizedBox(height: height * 0.01),
                                    Text(
                                      'Submission Count',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10 * width * 0.003,
                                      ),
                                    ),
                                    Container(
                                      width: width * 0.65,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Spacer(),
                                          Container(
                                            width: width * 0.65,
                                            child: Column(
                                             mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text('${documentState.myPersonalCount}',style: TextStyle(
                                              color: themeColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 1.5 * width * 0.03,
                                            ),),
                                                Row(
                                                  children: [
                                                    Text(
                                                        'From ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10 * width * 0.003),),
                                                    Text(
                                                        '${DateFormat.yMMMd().format(documentState.startDate)}'),
                                                    Text(
                                                        ' To ',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10 * width * 0.003),),
                                                    Text(
                                                        '${DateFormat.yMMMd().format(documentState.endDate)}'),
                                                    GestureDetector(
                                                      onTap: () {showingModalBottomSheet(context, documentState);},
                                                      child: Container(
                                                        height: height*0.07,
                                                        width: width*0.07,
                                                        child: Center(child: Image.asset(
                                                          "assets/images/history.png",
                                                          fit: BoxFit.cover,
                                                        )),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
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
          documentState.loading
              ? SizedBox(
                  height: height * 0.5,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : documentState.discussionDocumentList.length > 0
                  ? Expanded(
                    child: SmartRefresher(
                        enablePullDown: false,
                        enablePullUp: true,
                        controller: _refreshController,
                        onLoading: () async {
                          await documentState
                              .getMyPersonal()
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
                                documentState.discussionDocumentList.length,
                            itemBuilder: (context, index) {
                              DiscussionFormData document =
                                  documentState.discussionDocumentList[index];
                              return Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: NewDiscussionFormWidget(
                                  document: document,
                                  height: height*0.2,
                                  width: width*0.8,
                                ),
                              );
                            }),
                        footer: CustomFooter(builder:
                            (BuildContext context, LoadStatus? mode) {
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
                        "No Documents!",
                        style: TextStyle(fontSize: 18),
                      )),
                    )
        ],
      )),
    ));
  }

  showingModalBottomSheet(context, DocumentState documentState) {
    DateTime startDate = DateTime.now();
    DateTime endDate = DateTime.now();
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState /*You can rename this!*/) {
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
                                    fixedSize: Size(MediaQuery.of(context).size.width,
                                        MediaQuery.of(context).size.height * 0.08),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50))),
                                child: Text(
                                  'Apply',
                                ),
                                onPressed: () {
                                  documentState.resetFilterDetails(startDate, endDate);
                                  documentState.getMyPersonal();
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
