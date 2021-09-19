import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tbssystemdevelopment/providers/document_state.dart';
import 'package:tbssystemdevelopment/screens/document_screens/discussion_form_list.dart';
import 'package:tbssystemdevelopment/utils/constants.dart';

class DiscussionFormScreen extends StatefulWidget {
  @override
  _DiscussionFormScreenState createState() => _DiscussionFormScreenState();
}

class _DiscussionFormScreenState extends State<DiscussionFormScreen> {
  final _discussor = TextEditingController();
  final _prospector = TextEditingController();
  final _mobile = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _discussor.dispose();
    _prospector.dispose();
    _mobile.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final documentState = Provider.of<DocumentState>(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Discussion Form'),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(width*0.05),
                  child: Container(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text('Discussor'),
                          ),
                          SizedBox(
                            height: width*0.05,
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 54,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 4),
                                      blurRadius: 5,
                                      color: Colors.black
                                          .withOpacity(0.23))
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  return null;
                                },
                                controller: _discussor,
                                decoration: InputDecoration(
                                    hintText: "Discussor",
                                    hintStyle:
                                    TextStyle(color: Colors.black),
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    prefixIcon: Icon(
                                        Icons.account_circle,
                                        color: Colors.black)),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: width*0.05,
                          ),
                          Container(
                            child: Text('Prospector'),
                          ),
                          SizedBox(
                            height: width*0.05,
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 54,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 4),
                                      blurRadius: 5,
                                      color: Colors.black
                                          .withOpacity(0.23))
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  return null;
                                },
                                controller: _prospector,
                                decoration: InputDecoration(
                                  hintText: "Prospector",
                                  hintStyle:
                                  TextStyle(color: Colors.black),
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                    prefixIcon: Icon(
                                        Icons.account_circle,
                                        color: Colors.black)
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: width*0.05,
                          ),
                          Container(
                            child: Text('Contact Number'),
                          ),
                          SizedBox(
                            height: width*0.05,
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 54,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 4),
                                      blurRadius: 5,
                                      color: Colors.black
                                          .withOpacity(0.23))
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  return null;
                                },
                                controller: _mobile,
                                decoration: InputDecoration(
                                    hintText: "Contact Number",
                                    hintStyle:
                                    TextStyle(color: Colors.black),
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    prefixIcon: Icon(
                                        Icons.phone,
                                        color: Colors.black)),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: width*0.05,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Color(appThemeColor),
                                fixedSize: Size(width, height * 0.08),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(50))),
                            child: Text(
                              'Submit',
                            ),
                            onPressed: () {
                              checkFormValidation(
                                  _formKey, documentState, context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ),
    );
  }

  checkFormValidation(GlobalKey<FormState> _formKey, DocumentState documentState, context) {
    if (_formKey.currentState!.validate()) {
      documentState.createDiscussionForm(_discussor.text, _prospector.text, _mobile.text).then((value) {
        if (value.status) {
          final snackBar = SnackBar(content: Text(value.message));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          documentState.getMyPersonal();
          Navigator.of(context).pop();
        }
        else {
          final snackBar = SnackBar(content: Text(value.message), backgroundColor: Colors.red,);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }).catchError((onError) {
        final snackBar = SnackBar(content: Text('Something went wrong'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    } else {
      final snackBar = SnackBar(content: Text('Need to fill all the values'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
