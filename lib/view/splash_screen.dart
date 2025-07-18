import 'package:flutter/material.dart';
import 'package:mvvm_demo/app_store/app_store.dart';
import 'package:mvvm_demo/routes/routes_name.dart';
import 'package:mvvm_demo/utils/app_color.dart';
import 'package:mvvm_demo/view/login_screen.dart';

class SplashScreen extends  StatefulWidget{
  const SplashScreen({super.key});


  @override
  State<SplashScreen> createState()=> _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{
  String token="";
  @override
  void initState() {
    super.initState();
    _getToken();

    Future.delayed(const Duration(seconds: 5),(){
      print(token);
      if(token=='')
        {
          Navigator.pushReplacementNamed(context, RoutesName.loginScreen,
              arguments: {
                'name':'Login'
              });
        }
      else
        {
          Navigator.pushReplacementNamed(context, RoutesName.homeScreen);

        }


    });

  }

  _getToken()async
  {
   await AppStore().getUserToken().then((value){
    print(value);
    token=value;
      setState(() {
        
      });
    });

  }


  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: primary,
      body:Center(child: SizedBox(
        height: 100,
        width: 100,
      child: Image.asset("asset/gst_splash.png"),
    ),)
    );
    
  }
}