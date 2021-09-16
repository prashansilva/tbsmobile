
import 'package:flutter/material.dart';
import 'package:tbssystemdevelopment/providers/app_state.dart';
import 'package:tbssystemdevelopment/providers/user_state.dart';
import 'package:tbssystemdevelopment/screens/home_screen.dart';
import 'package:tbssystemdevelopment/utils/constants.dart';
import 'package:provider/provider.dart';

class UserLoginScreen extends StatefulWidget {
  @override
  _UserLoginScreenState createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  final _usercode = TextEditingController();
  final _password = TextEditingController();
  bool _passwordVisible = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usercode.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final userState = Provider.of<UserState>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          child: Stack(
            children: [
              Positioned(
                top: 0,
                child: Container(
                  width: width,
                  height: height * 0.5,
                  child: Image.asset(
                    "assets/images/login_image.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: height * 0.38,
                left: width * 0.1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.circular(25.0),
                        topEnd: Radius.circular(25.0)),
                    color: Colors.white.withOpacity(0.5),
                  ),
                  width: width * 0.8,
                  height: height * 0.2,
                ),
              ),
              Positioned(
                top: height * 0.39,
                left: width * 0.05,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.circular(25.0),
                        topEnd: Radius.circular(25.0)),
                    color: Colors.white.withOpacity(0.5),
                  ),
                  width: width * 0.9,
                  height: height * 0.2,
                ),
              ),
              Positioned(
                  top: height * 0.4,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.only(
                            topStart: Radius.circular(25.0),
                            topEnd: Radius.circular(25.0)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            offset: Offset(0.0, 0.0),
                          )
                        ]),
                    width: width,
                    height: height * 0.6,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30.0, right: 30.0, top: 30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
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
                                        controller: _usercode,
                                        decoration: InputDecoration(
                                            hintText: "User Code",
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
                                    child: Row(
                                      children: [
                                        Spacer(),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pushNamed(
                                                  '/forgetpassword');
                                            },
                                            child: Text(
                                              'Forgot Your Password?',
                                              style: TextStyle(
                                                  color: Color(appThemeColor)),
                                            )),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
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
                                    'Sign In',
                                  ),
                                  onPressed: () {
                                    checkFormValidation(
                                        _formKey, userState, appState, context);
                                  },
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Dont you have an account? '),
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed('/registerPage');
                                    },
                                    child: Text(
                                      'Signup here',
                                      style: TextStyle(
                                          color: Color(appThemeColor)),
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        ));
  }

  checkFormValidation(GlobalKey<FormState> _formKey, UserState userSate,
      AppState appState, context) {
    if (_formKey.currentState!.validate()) {
      userSate.userLogin(_usercode.text, _password.text).then((value) {
        if (value.status) {
          final snackBar = SnackBar(content: Text(value.message));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
//          Navigator.of(context).pushNamed('/homePage');
          Navigator.pushAndRemoveUntil(
              context,
              PageRouteBuilder(pageBuilder: (BuildContext context,
                  Animation animation, Animation secondaryAnimation) {
                return HomeScreen();
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
