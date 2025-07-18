import 'package:flutter/material.dart';
import 'package:mvvm_demo/routes/routes_name.dart';
import 'package:mvvm_demo/utils/app_color.dart';
import 'package:mvvm_demo/view_modal/login_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget{
  final Map args;
  const LoginScreen({super.key, required this.args});

@override
  State<LoginScreen> createState()=> _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen>{
TextEditingController email=TextEditingController();
TextEditingController password=TextEditingController();


String? name='';
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.args.containsKey('name'))
    {
      name=widget.args['name'];
    }
  }

   @override
  Widget build(BuildContext context)
  {
    final loginProvider=Provider.of<LoginProvider>(context);
    return Scaffold(
        appBar: AppBar(centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: primary,
        title: Text(name!,style: TextStyle(color: white),),),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
            TextFormField(decoration: InputDecoration(hintText:"Enter email" ),controller: email,),
            SizedBox(height: 10,),
            TextFormField(decoration: InputDecoration(hintText:"Enter password" ),controller: password,),
            SizedBox(height: 20),
            SizedBox(height: 50,width: double.infinity,
            child: ElevatedButton(onPressed: (){
             // Navigator.pushReplacementNamed(context, RoutesName.homeScreen);
             //      "eve.holt@reqres.in",
             //      cityslicka
                  // Map data = {"email": email.text.toString(),
                  //            "password":password.text.toString()};

                  Map data = {"email": "eve.holt@reqres.in",
                             "password":"password.text.toString()"};
              loginProvider.useLogin(data,context);

            },style: ElevatedButton.styleFrom(backgroundColor: primary,foregroundColor: white),child: loginProvider.isLoading?CircularProgressIndicator(color: white,): const Text("Login")),),
          ]),
        ));
  }
}