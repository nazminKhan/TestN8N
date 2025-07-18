import 'package:flutter/material.dart';
import 'package:mvvm_demo/view/get_it/app_info.dart';

class InheritedInjection extends InheritedWidget {
  final AppInfo _appInfo = AppInfo();
  final Widget child;

  InheritedInjection({required Key key, required this.child}) : super(key: key, child: child);

  AppInfo get appInfo => _appInfo;

  static InheritedInjection of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<InheritedInjection>()!);
  }

  @override
  bool updateShouldNotify(InheritedInjection oldWidget) {
    return true;
  }
}