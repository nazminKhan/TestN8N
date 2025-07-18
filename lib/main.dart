import 'package:flutter/material.dart';
import 'package:mvvm_demo/routes/routes.dart';
import 'package:mvvm_demo/routes/routes_name.dart';
import 'package:mvvm_demo/utils/app_color.dart';
import 'package:mvvm_demo/view/splash_screen.dart';
import 'package:provider/provider.dart';

import 'view/gst/gst_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
       providers: [
        ChangeNotifierProvider(create: (_) => GstProvider()),
      ],
      child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      
        colorScheme: ColorScheme.fromSeed(seedColor: primary),
        useMaterial3: true,
      ),
      //home: const SplashScreen(),
      initialRoute: RoutesName.splashScreen,
      onGenerateRoute: Routes.generateRoute,
    ));
  }
}

