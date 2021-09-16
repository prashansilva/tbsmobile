import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tbssystemdevelopment/providers/app_state.dart';
import 'package:tbssystemdevelopment/providers/user_state.dart';
import 'package:tbssystemdevelopment/screens/user_screens/user_login_screen.dart';
import 'package:tbssystemdevelopment/utils/constants.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final appState = Provider.of<AppState>(context);
    final userState = Provider.of<UserState>(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Confirm !',
                  style: TextStyle(fontSize: 14),
                ),

                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'A brilliant solution to the wrong problem \n \t   can be worse than no solution at all: \n \t          solve the correct problem.',
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
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
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
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
                            'Proceed',
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
              ],
            ),
          ),
        ),
      ),
    );

  }

  checkFormValidation(GlobalKey<FormState> _formKey, UserState userSate,
      AppState appState, context) {
    if (_formKey.currentState!.validate()) {
      userSate.passwordReset(_password.text).then((value) {
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

