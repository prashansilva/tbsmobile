import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tbssystemdevelopment/models/user_model.dart';
import 'package:tbssystemdevelopment/providers/app_state.dart';
import 'package:tbssystemdevelopment/providers/user_state.dart';
import 'package:tbssystemdevelopment/screens/user_screens/user_login_screen.dart';
import 'package:tbssystemdevelopment/utils/constants.dart';

class UserRegsiterScreen extends StatefulWidget {
  @override
  _UserRegsiterScreenState createState() => _UserRegsiterScreenState();
}

class _UserRegsiterScreenState extends State<UserRegsiterScreen> {
  final _usercode = TextEditingController();
  final _password = TextEditingController();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _mobile = TextEditingController();
  final _location = TextEditingController();
  final _managerCode = TextEditingController();
  final _leaderCode = TextEditingController();
  bool _passwordVisible = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usercode.dispose();
    _password.dispose();
    _firstName.dispose();
    _lastName.dispose();
    _mobile.dispose();
    _location.dispose();
    _managerCode.dispose();
    _leaderCode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final userState = Provider.of<UserState>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: width,
                height: height * 0.3,
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
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.3,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(10.0), bottomLeft: Radius.circular(10.0)),
                        child: Image.asset(
                          "assets/images/login_image.jpg",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
                                if(value == null || value == '') {
                                  return '';
                                }
                                return null;
                              },
                              controller: _usercode,
                              decoration: InputDecoration(
                                  hintText: "Coordinator Code",
                                  hintStyle:
                                  TextStyle(color: Colors.black),
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  focusedErrorBorder: InputBorder.none,
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(borderRadius * 3)
                                    ),
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
                                if(value == null || value == '')
                                  {
                                    return '';
                                  }
                                return null;
                              },
                              controller: _password,
                              obscureText: !_passwordVisible,
                              decoration: InputDecoration(
                                hintText: "Password",
                                hintStyle:
                                TextStyle(color: Colors.black),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                errorStyle: TextStyle(height: 0),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(borderRadius * 3)
                                  ),
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 1.0,
                                  ),
                                ),
                                prefixIcon: Icon(Icons.lock,
                                    color: Colors.black),
                                suffixIcon: IconButton(
                                  color: Colors.black,
                                  icon: Icon(
                                    _passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible =
                                      !_passwordVisible;
                                    });
                                  },
                                ),
                              ),
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
                                if(value == null || value == '') {
                                  return '';
                                }
                                return null;
                              },
                              controller: _firstName,
                              decoration: InputDecoration(
                                  hintText: "First Name",
                                  hintStyle:
                                  TextStyle(color: Colors.black),
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  errorStyle: TextStyle(height: 0),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(borderRadius * 3)
                                    ),
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
                                if(value == null || value == '') {
                                  return '';
                                }
                                return null;
                              },
                              controller: _lastName,
                              decoration: InputDecoration(
                                  hintText: "Last name",
                                  hintStyle:
                                  TextStyle(color: Colors.black),
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  errorStyle: TextStyle(height: 0),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(borderRadius * 3)
                                    ),
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
                                if(value == null || value == '') {
                                  return '';
                                }
                                return null;
                              },
                              controller: _mobile,
                              decoration: InputDecoration(
                                  hintText: "Mobile Number",
                                  hintStyle:
                                  TextStyle(color: Colors.black),
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  errorStyle: TextStyle(height: 0),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(borderRadius * 3)
                                    ),
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
                                if(value == null || value == '') {
                                  return '';
                                }
                                return null;
                              },
                              controller: _location,
                              decoration: InputDecoration(
                                  hintText: "Location",
                                  hintStyle:
                                  TextStyle(color: Colors.black),
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  errorStyle: TextStyle(height: 0),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(borderRadius * 3)
                                    ),
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
                                if(value == null || value == '') {
                                  return '';
                                }
                                return null;
                              },
                              controller: _managerCode,
                              decoration: InputDecoration(
                                  hintText: "Manager Code",
                                  hintStyle:
                                  TextStyle(color: Colors.black),
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  errorStyle: TextStyle(height: 0),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(borderRadius * 3)
                                    ),
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
                                if(value == null || value == '') {
                                  return '';
                                }
                                return null;
                              },
                              controller: _leaderCode,
                              decoration: InputDecoration(
                                  hintText: "Line Leader Code",
                                  hintStyle:
                                  TextStyle(color: Colors.black),
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  errorStyle: TextStyle(height: 0),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(borderRadius * 3)
                                    ),
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
                  ),
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
                          'Sign Up',
                        ),
                        onPressed: () {
                          checkFormValidation(
                              _formKey, userState, appState, context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('You already have an account? '),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed('/loginPage');
                        },
                        child: Text(
                          'SignIn here',
                          style: TextStyle(
                              color: Color(appThemeColor)),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  checkFormValidation(GlobalKey<FormState> _formKey, UserState userSate,
      AppState appState, context) {
    if (_formKey.currentState!.validate()) {
      UserData user = new UserData(id: '',first_name: _firstName.text,last_name: _lastName.text,mobile_number: _mobile.text,location: _location.text,code: _usercode.text,manager_id: _managerCode.text,line_leader_id: _leaderCode.text,role_code: '');
      userSate.userRegister(user, _password.text).then((value) {
        if (value.status) {
          final snackBar = SnackBar(content: Text(value.message));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
