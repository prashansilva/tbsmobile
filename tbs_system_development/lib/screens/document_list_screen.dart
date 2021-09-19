import 'package:flutter/material.dart';
import 'package:tbssystemdevelopment/models/document_model.dart';
import 'package:tbssystemdevelopment/providers/document_state.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DocumentListViewScreen extends StatelessWidget {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final documentState = Provider.of<DocumentState>(context);
    final ScrollController _scrollController = new ScrollController();
    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
            child: documentState.loading
                ? SizedBox(
                    height: height * 0.5,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : documentState.documentList.length > 0
                    ? SmartRefresher(
                        enablePullDown: false,
                        enablePullUp: true,
                        controller: _refreshController,
                        onLoading: () async {
                          await documentState.getDocumentList().then((value) => {

                            if(value != null && value.length > 0) {
                              _refreshController.loadComplete()
                            }
                            else {
                              _refreshController.loadNoData()
                            }
                          });
                        },
                        child: ListView.builder(
                            controller: _scrollController,
                            itemCount: documentState.documentList.length,
                            itemBuilder: (context, index) {
                              DocumentData document =
                                  documentState.documentList[index];
                              return Container(
                                height: width * 0.5,
                                child: Text(document.first_name),
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
              height: height*0.4,
                        child: Center(
                            child: Text(
                          "No Documents!",
                          style: TextStyle(fontSize: 18),
                        )),
                      )));
  }
}
