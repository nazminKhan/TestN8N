import 'package:flutter/material.dart';
import 'package:mvvm_demo/app_store/app_store.dart';
import 'package:mvvm_demo/routes/routes_name.dart';
import 'package:mvvm_demo/service/api_response.dart';
import 'package:mvvm_demo/utils/app_color.dart';
import 'package:mvvm_demo/view/gst/gst_screen.dart';
import 'package:mvvm_demo/view/login_screen.dart';
import 'package:mvvm_demo/view/news/news_screen.dart';
import 'package:mvvm_demo/view/splash_screen.dart';
import 'package:mvvm_demo/view_modal/user_list_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

UserListProvider userListProvider=UserListProvider();
int myIndex=0;
List<Widget> widgetList=[
  const GstScreen(),
  const GstScreen(),
  const NewsScreen(),
];
@override
  void initState() {
    userListProvider.fetchUserList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
    //   appBar: AppBar(
    //   title: const Text("Home"),
    // ),
    body: IndexedStack(children: widgetList,index: myIndex,),
    bottomNavigationBar: BottomNavigationBar(

      showUnselectedLabels: false,
      onTap: (index){
        setState(() {
           myIndex=index;
        });
       
      },
      currentIndex: myIndex,
      items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.percent),label: 'Gst'),
      BottomNavigationBarItem(icon: Icon(Icons.newspaper),label: 'News'),
    ]),
    );

    // return Scaffold(appBar: AppBar(centerTitle: true,automaticallyImplyLeading: false,backgroundColor: primary,actions: [IconButton(onPressed: (){
    //   AppStore().removeToken();
    //   Navigator.pushReplacementNamed(context, RoutesName.loginScreen,
    //           arguments: {
    //             'name':'Login'
    //           });
    // }, icon: const Icon(Icons.logout,color: Colors.white,))],title: Text("Home Screen"),),
    // body: ChangeNotifierProvider(create: (BuildContext context)=>userListProvider,child: Consumer<UserListProvider>(builder: (context,value,_){
    //   switch(value.userList.status)
    //   {
    //     case Status.loading:
    //     return Center(child: CircularProgressIndicator(color: primary,),);

    //     case Status.error:
    //     return Center(child: Text(value.userList.message.toString(),),);

    //     case Status.complete:
    //     return ListView.builder(
    //       itemCount: value.userList.data?.data?.length,
    //       itemBuilder: (context,index){

    //       final data=value.userList.data?.data?[index];

    //         return Card(
    //           margin:const EdgeInsets.all( 5),
    //           child: ListTile(
    //           leading: CircleAvatar(
    //             backgroundImage: NetworkImage(data!.avatar.toString()),
    //           ),
    //           title: Text(data.firstName.toString()),
    //           subtitle: Text(data.email.toString()),
    //         ),);
    //       });

    //     default:

    //   }
    //   return const SizedBox();
    // }),),);

  }
}
