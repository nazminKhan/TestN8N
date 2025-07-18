import 'package:flutter/material.dart';
import 'package:mvvm_demo/routes/routes_name.dart';
import 'package:mvvm_demo/view/news/news_detail_screen.dart';
import 'package:mvvm_demo/view/news/news_list_screen.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (context) => const NewsListScreen());
          case RoutesName.newsDetailScreen:
            final args = settings.arguments as Map;
            return MaterialPageRoute(builder: (context) => NewsDetailScreen(url: args['url']));
          default:
            return MaterialPageRoute(builder: (context) {
              return const Scaffold(
                body: Center(
                  child: Text("Something went wrong"),
                ),
              );
            });
        }
      },
    );
  }
}