import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tbssystemdevelopment/models/user_model.dart';
import 'package:tbssystemdevelopment/providers/dashboard_state.dart';
import 'package:tbssystemdevelopment/utils/constants.dart';

class LeaderRegisterScreen extends StatefulWidget {
  @override
  _LeaderRegisterScreenState createState() => _LeaderRegisterScreenState();
}

class _LeaderRegisterScreenState extends State<LeaderRegisterScreen> {

  final _usercode = TextEditingController();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _mobile = TextEditingController();
  final _location = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usercode.dispose();
    _firstName.dispose();
    _lastName.dispose();
    _mobile.dispose();
    _location.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dashboardState = Provider.of<DashboardState>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Leader'),
      ),
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.bottomCenter,
                          height: 54,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.circular(20),
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
                              autovalidateMode: AutovalidateMode
                                  .onUserInteraction,
                              validator: (value) {
                                if (value == null || value == '') {
                                  return '';
                                }
                                return null;
                              },
                              controller: _usercode,
                              decoration: InputDecoration(
                                  hintText: "Leader Code",
                                  hintStyle: TextStyle(
                                      color: Colors.black),
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  focusedErrorBorder:
                                  InputBorder.none,
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            borderRadius * 3)),
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                      width: 1.0,
                                    ),
                                  ),
                                  errorStyle: TextStyle(height: 0),
                                  prefixIcon: Icon(
                                      Icons.account_circle,
                                      color: Colors.black)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 54,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.circular(20),
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
                              autovalidateMode: AutovalidateMode
                                  .onUserInteraction,
                              validator: (value) {
                                if (value == null || value == '') {
                                  return '';
                                }
                                return null;
                              },
                              controller: _firstName,
                              decoration: InputDecoration(
                                  hintText: "First Name",
                                  hintStyle: TextStyle(
                                      color: Colors.black),
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  errorStyle: TextStyle(height: 0),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            borderRadius * 3)),
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                      width: 1.0,
                                    ),
                                  ),
                                  prefixIcon: Icon(
                                      Icons.account_circle,
                                      color: Colors.black)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 54,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.circular(20),
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
                              autovalidateMode: AutovalidateMode
                                  .onUserInteraction,
                              validator: (value) {
                                if (value == null || value == '') {
                                  return '';
                                }
                                return null;
                              },
                              controller: _lastName,
                              decoration: InputDecoration(
                                  hintText: "Last name",
                                  hintStyle: TextStyle(
                                      color: Colors.black),
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  errorStyle: TextStyle(height: 0),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            borderRadius * 3)),
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                      width: 1.0,
                                    ),
                                  ),
                                  prefixIcon: Icon(
                                      Icons.account_circle,
                                      color: Colors.black)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 54,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.circular(20),
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
                              autovalidateMode: AutovalidateMode
                                  .onUserInteraction,
                              validator: (value) {
                                if (value == null || value == '') {
                                  return '';
                                }
                                return null;
                              },
                              controller: _mobile,
                              decoration: InputDecoration(
                                  hintText: "Mobile Number",
                                  hintStyle: TextStyle(
                                      color: Colors.black),
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  errorStyle: TextStyle(height: 0),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            borderRadius * 3)),
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                      width: 1.0,
                                    ),
                                  ),
                                  prefixIcon: Icon(
                                      Icons.account_circle,
                                      color: Colors.black)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 54,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.circular(20),
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
                              autovalidateMode: AutovalidateMode
                                  .onUserInteraction,
                              validator: (value) {
                                if (value == null || value == '') {
                                  return '';
                                }
                                return null;
                              },
                              controller: _location,
                              decoration: InputDecoration(
                                  hintText: "Location",
                                  hintStyle: TextStyle(
                                      color: Colors.black),
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  errorStyle: TextStyle(height: 0),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            borderRadius * 3)),
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                      width: 1.0,
                                    ),
                                  ),
                                  prefixIcon: Icon(
                                      Icons.account_circle,
                                      color: Colors.black)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  child: Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Color(appThemeColor),
                            fixedSize: Size(width, height * 0.08),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(50))),
                        child: Text(
                          'Add',
                        ),
                        onPressed: () {
                          checkFormValidation(
                              _formKey, dashboardState, context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  checkFormValidation(
      GlobalKey<FormState> _formKey, DashboardState dashboardState, context) {
    if (_formKey.currentState!.validate()) {
      UserData user = new UserData(
          id: '',
          first_name: _firstName.text,
          last_name: _lastName.text,
          mobile_number: _mobile.text,
          location: _location.text,
          code: _usercode.text,
          manager_id: '',
          line_leader_id: '',
          role_code: '');
      dashboardState.userRegisterLeader(user).then((value) {
        if (value.status) {
          dashboardState.getLeadersByManger();
          final snackBar = SnackBar(content: Text(value.message));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigator.pop(context);
        } else {
          final snackBar = SnackBar(
            content: Text(value.message),
            backgroundColor: Colors.red,
          );
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
