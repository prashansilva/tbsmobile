import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tbssystemdevelopment/config/app_config.dart';
import 'package:tbssystemdevelopment/providers/app_state.dart';
import 'package:tbssystemdevelopment/providers/dashboard_fliter_state.dart';
import 'package:tbssystemdevelopment/providers/dashboard_state.dart';
import 'package:tbssystemdevelopment/providers/document_state.dart';
import 'package:tbssystemdevelopment/providers/user_state.dart';
import 'package:tbssystemdevelopment/routes/routes.dart';
import 'package:tbssystemdevelopment/screens/home_screen.dart';
import 'package:tbssystemdevelopment/screens/user_screens/user_login_screen.dart';
import '../locator.dart';

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var config = AppConfig.of(context);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return new MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => DashboardState()),
          ChangeNotifierProvider(create: (context) => AppState()),
          ChangeNotifierProvider(create: (context) => UserState()),
          ChangeNotifierProvider(create: (context) => DocumentState()),
          ChangeNotifierProvider(create: (context) => DashboardFilterState()),
        ],
        builder: (context, child) {
          return Consumer<AppState>(
            builder: (context,appState,child) {
             return RefreshConfiguration(
               headerBuilder: () => WaterDropHeader(),        // Configure the default header indicator. If you have the same header indicator for each page, you need to set this
               footerBuilder:  () => ClassicFooter(),        // Configure default bottom indicator
               headerTriggerDistance: 80.0,        // header trigger refresh trigger distance
               springDescription:SpringDescription(stiffness: 170, damping: 16, mass: 1.9),         // custom spring back animate,the props meaning see the flutter api
               maxOverScrollExtent :100, //The maximum dragging range of the head. Set this property if a rush out of the view area occurs
               maxUnderScrollExtent:0, // Maximum dragging range at the bottom
               enableScrollWhenRefreshCompleted: true, //This property is incompatible with PageView and TabBarView. If you need TabBarView to slide left and right, you need to set it to true.
               enableLoadingWhenFailed : true, //In the case of load failure, users can still trigger more loads by gesture pull-up.
               hideFooterWhenNotFull: false, // Disable pull-up to load more functionality when Viewport is less than one screen
               enableBallisticLoad: true,
               child: MaterialApp(
                 title: config!.appName,
                 debugShowCheckedModeBanner: false,
                 onGenerateRoute: RoutesGenerator.routeProvider,
                 initialRoute: '/',
                 theme: ThemeData(fontFamily: 'Roboto',
                   textTheme: const TextTheme(
                     headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
                     headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
                     bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
                   ),),
                 home: FutureBuilder(
                     future: appState.checkAuth(),
                     builder: (context, snapshot) {
                       switch (snapshot.connectionState) {
                         case ConnectionState.done:
                           if (snapshot.data == null || snapshot.data == false) {
                             return UserLoginScreen();
                           }
                           else {
                             return HomeScreen();
                           }
                         default:
                           return Container();
                       }
                     }
                 ),
               ),
             );
            }
          );
        },
    );
  }
}
