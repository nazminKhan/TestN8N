import 'package:flutter/material.dart';

import '../../routes/routes_name.dart';
import 'item_detail_screen.dart';
import 'item_list_screen.dart';

class ItemScreen extends StatelessWidget {
  const ItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (context) => const ItemListScreen());
          case RoutesName.itemDetailScreen:
            final args = settings.arguments as Map;
            return MaterialPageRoute(builder: (context) => ItemDetailScreen(type: args['type'], ));
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