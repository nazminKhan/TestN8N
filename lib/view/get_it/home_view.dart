import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_info.dart';

class HomeView extends StatelessWidget{
  HomeView({required Key key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: MyList(key: Key('myListKey'),),);
  }
}
class MyList extends StatelessWidget {
  const MyList({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PostItem(key: key!);
  }
}
class PostItem extends StatelessWidget {
  const PostItem({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PostMenu(key: key!);
  }
}

class PostMenu extends StatelessWidget {
  const PostMenu({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PostAction(key: key!);
  }
}

class PostAction extends StatelessWidget {
  const PostAction({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LikeButton(key: key!);
  }
}

class LikeButton extends StatelessWidget {
  const LikeButton({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // We have access to it anywhere in the app with this simple call
    var appInfo = Provider.of<AppInfo>(context);
    return Container(
      child: Text(appInfo.welcomeMessage),
    );
  }
}