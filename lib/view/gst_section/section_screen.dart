import 'package:flutter/material.dart';
import 'package:mvvm_demo/routes/routes_name.dart';
import 'package:mvvm_demo/view/gst_section/section_detail_screen.dart';

import 'gst_section_list_screen.dart';

class SectionScreen extends StatelessWidget {
  const SectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (context) => const SectionListScreen());
          case RoutesName.sectionDetailScreen:
            final args = settings.arguments as Map;
            return MaterialPageRoute(builder: (context) => SectionDetailScreen(
              title: args['title'],
              details: args['details'],
            ));
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