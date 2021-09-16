import 'package:flutter/material.dart';
import 'package:tbssystemdevelopment/screens/coordinators_list_screen.dart';
import 'package:tbssystemdevelopment/screens/document_filter_screen.dart';
import 'package:tbssystemdevelopment/screens/document_list_screen.dart';
import 'package:tbssystemdevelopment/screens/document_screens/discussion_form.dart';
import 'package:tbssystemdevelopment/screens/document_screens/discussion_form_list.dart';
import 'package:tbssystemdevelopment/screens/forget_password_screens/reset_password.dart';
import 'package:tbssystemdevelopment/screens/forget_password_screens/security_verification.dart';
import 'package:tbssystemdevelopment/screens/forget_password_screens/usercode_verification.dart';
import 'package:tbssystemdevelopment/screens/home_screen.dart';
import 'package:tbssystemdevelopment/screens/leader_list_screen.dart';
import 'package:tbssystemdevelopment/screens/management_screens/coordinator_list_screen.dart';
import 'package:tbssystemdevelopment/screens/management_screens/user_list_screen.dart';
import 'package:tbssystemdevelopment/screens/user_screens/leader_add_screen.dart';
import 'package:tbssystemdevelopment/screens/user_screens/user_register_screen.dart';
import '../screens/document_view_screen.dart';
import 'package:tbssystemdevelopment/screens/user_screens/user_login_screen.dart';

class RoutesGenerator {
  static Route<dynamic>? routeProvider(RouteSettings settings) {
    switch (settings.name) {
      case '/loginPage':
        return MaterialPageRoute(builder: (_) => UserLoginScreen());
      case '/registerPage':
        return MaterialPageRoute(builder: (_) => UserRegsiterScreen());
      case '/homePage':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/discussion_form':
        return MaterialPageRoute(builder: (_) => DiscussionFormScreen());
      case '/documentView':
        return MaterialPageRoute(builder: (_) => DocumentViewScreen());
      case '/documentList':
        return MaterialPageRoute(builder: (_) => DocumentListViewScreen());
      case '/documentFilterScreen':
        return MaterialPageRoute(builder: (_) => DocumentFilterScreen());
      case '/discussionList':
        return MaterialPageRoute(builder: (_) => DiscussionFormList());
      case '/userList':
        return MaterialPageRoute(builder: (_) => UserListScreen());
      case '/leaderList':
        return MaterialPageRoute(builder: (_) => LeaderListScreen());
      case '/coordinatorListByManager':
        return MaterialPageRoute(builder: (_) => CoordinatorsListScreen());
      case '/leaderRegister':
        return MaterialPageRoute(builder: (_) => LeaderRegisterScreen());
      case '/coordinatorList':
        return MaterialPageRoute(builder: (_) => CoordinatorListScreen());
      case '/forgetpassword':
        return MaterialPageRoute(builder: (_) => UserCodeVerificationScreen());
      case '/securityverification':
        return MaterialPageRoute(builder: (_) => SecurityVerificationScreen());
      case '/resetpassword':
        return MaterialPageRoute(builder: (_) => ResetPasswordScreen());
    }
    return null;
  }
}
