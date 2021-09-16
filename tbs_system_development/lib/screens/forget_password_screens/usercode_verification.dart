import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tbssystemdevelopment/providers/app_state.dart';
import 'package:tbssystemdevelopment/providers/user_state.dart';
import 'package:tbssystemdevelopment/utils/constants.dart';

class UserCodeVerificationScreen extends StatelessWidget {
  final _userCode = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
                  'Forgot Your Password?',
                  style: TextStyle(fontSize: 14 * width * 0.003),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Dont worry, It happens to the best of us.',
                  style: TextStyle(fontSize: 14 * width * 0.003),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    child: Form(
                      key: _formKey,
                      child: Container(
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
                            controller: _userCode,
                            decoration: InputDecoration(
                                hintText: "User Code",
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
      userSate.userCodeValidate(_userCode.text).then((value) {
        if (value.status) {
          final snackBar = SnackBar(content: Text(value.message));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigator.of(context).pushNamed('/securityverification');
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
