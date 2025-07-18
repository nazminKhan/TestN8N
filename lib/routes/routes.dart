import 'package:flutter/material.dart';
import 'package:mvvm_demo/routes/routes_name.dart';
import 'package:mvvm_demo/view/home_screen.dart';
import 'package:mvvm_demo/view/login_screen.dart';
import 'package:mvvm_demo/view/splash_screen.dart';
import 'package:mvvm_demo/view_modal/login_provider.dart';
import 'package:provider/provider.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashScreen());

      case RoutesName.loginScreen:
        final args = settings.arguments as Map;
        return MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (BuildContext context) => LoginProvider(),
                child: LoginScreen(args: args)));

      case RoutesName.homeScreen:
        return MaterialPageRoute(builder: (context) => const HomeScreen());

      default:
        return MaterialPageRoute(builder: (context) {
          return const Scaffold(
            body: Center(
              child: Text("Something went wrong"),
            ),
          );
        });
    }
  }
}