import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:provider/provider.dart';
import 'package:tbssystemdevelopment/providers/app_state.dart';
import 'package:tbssystemdevelopment/providers/user_state.dart';
import 'package:tbssystemdevelopment/screens/user_screens/user_login_screen.dart';
import 'package:tbssystemdevelopment/utils/colors.dart';
import 'package:tbssystemdevelopment/utils/constants.dart';

class SecurityVerificationScreen extends StatelessWidget {
  final _securityCode = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final appState = Provider.of<AppState>(context);
    final userState = Provider.of<UserState>(context);
    final BoxDecoration pinPutDecoration = BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: primaryAppColor));
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Verification !',
                  style: TextStyle(fontSize: 14 * width * 0.003),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'There is beauty when something works \n \t               and works intuitively.',
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
                      child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PinPut(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        fieldsAlignment: MainAxisAlignment.spaceAround,
                        withCursor: true,
                        fieldsCount: 6,
                        textStyle: const TextStyle(
                            fontSize: 12, color: Colors.black),
                        eachFieldWidth: 20.0,
                        eachFieldHeight: 50.0,
                        controller: _securityCode,
                        submittedFieldDecoration: pinPutDecoration,
                        selectedFieldDecoration: pinPutDecoration,
                        followingFieldDecoration: pinPutDecoration,
                        pinAnimationType: PinAnimationType.scale,
                        validator: (value) {
                          if(value != null && value.length < 6) {
                            return '';
                          }
                          return null;
                        },
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
      userSate.otpValidate(_securityCode.text).then((value) {
        if (value.status) {
          final snackBar = SnackBar(content: Text(value.message));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigator.of(context).pushNamed('/resetpassword');
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
