import 'package:flutter/material.dart';
import 'package:mvvm_demo/app_store/app_store.dart';
import 'package:mvvm_demo/routes/routes_name.dart';
import 'package:mvvm_demo/utils/app_color.dart';
import 'package:mvvm_demo/view/gst/gst_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mvvm_demo/view/gst_section/section_screen.dart';
import 'package:mvvm_demo/view/news/news_screen.dart';
import 'package:mvvm_demo/view/gst_item/gst_item_screen.dart';
import 'package:mvvm_demo/view_modal/user_list_provider.dart';
import 'package:provider/provider.dart';

import '../../common_widgets/custom_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserListProvider userListProvider = UserListProvider();
  int myIndex = 0;
  bool isAppBar = true;

  String? _currentAddress;
  Position? _currentPosition;


  List<Widget> widgetList = [
    const GstScreen(),
    const SectionScreen(),
    const NewsScreen(),
    const ItemScreen(), // Add your fourth screen here
  ];

  @override
  void initState() {
    userListProvider.fetchUserList();
    _getCurrentPosition();
    super.initState();
  }

  Future<bool> _onWillPop() async {
    if (myIndex != 0) {
      setState(() {
        myIndex = 0;
      });
      return false;
    } else {
      return true;
    }
  }
Future<void> _getCurrentPosition() async {
  final hasPermission = await _handleLocationPermission();
  if (!hasPermission) return;
  await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high)
      .then((Position position) {
        print(position.latitude);
        print(position.longitude);
    setState(() => _currentPosition = position);
  }).catchError((e) {
    debugPrint(e);
  });
}
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, //_onWillPop,
      child: Scaffold(
        appBar: isAppBar
            ? CustomAppBar(title: _getTitle(myIndex))
            : null, // Use the CustomAppBar widget
        body: IndexedStack(children: widgetList, index: myIndex),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: AppColor.primary, // Set the background color
          selectedItemColor: AppColor.primary, // Set the selected item color
          unselectedItemColor: Colors.grey, // Set the unselected item color
          showUnselectedLabels: false,
          onTap: (index) {
            setState(() {
              myIndex = index;
              _getTitle(index);
            });
          },
          currentIndex: myIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Gst'),
            BottomNavigationBarItem(icon: Icon(Icons.percent), label: 'Section'),
            BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: 'News'),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Code'), // Add your fourth tab here
          ],
        ),
      ),
    );
  }

  String _getTitle(int index) {
    switch (index) {
      case 0:
        setState(() {
          isAppBar = false;
        });
        return 'GST Calculator';
      case 1:
        setState(() {
          isAppBar = false;
        });
        return 'GST Section';
      case 2:
        setState(() {
          isAppBar = false;
        });
        return 'News';
      case 3:
        setState(() {
          isAppBar = false;
        });
        return 'Code';
      default:
        setState(() {
          isAppBar = false;
        });
        return 'Home';
    }
  }

  Future<bool> _handleLocationPermission() async {
  bool serviceEnabled;
  LocationPermission permission;
  
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Location services are disabled. Please enable the services')));
    return false;
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {   
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permissions are denied')));
      return false;
    }
  }
  if (permission == LocationPermission.deniedForever) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Location permissions are permanently denied, we cannot request permissions.')));
    return false;
  }
  return true;
}
}