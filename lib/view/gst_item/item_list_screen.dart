import 'package:flutter/material.dart';
import 'package:mvvm_demo/app_store/app_store.dart';
import 'package:mvvm_demo/routes/routes_name.dart';
import 'package:mvvm_demo/service/api_response.dart';
import 'package:mvvm_demo/utils/app_color.dart';
import 'package:mvvm_demo/view/gst/gst_screen.dart';
import 'package:mvvm_demo/view/login_screen.dart';
import 'package:mvvm_demo/view/splash_screen.dart';
import 'package:mvvm_demo/view_modal/user_list_provider.dart';
import 'package:provider/provider.dart';

import '../../common_widgets/custom_app_bar.dart';
import '../../utils/strings.dart';

class ItemListScreen extends StatelessWidget {
  const ItemListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'GST Item Code',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // Align children to stretch horizontally
          children: [
            ElevatedButton(
              onPressed: () {
                _navigateToDetails(context, 'Goods');
              },
              child: const Text('Goods'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50), // Set the width to full and height to 50
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _navigateToDetails(context, 'Service');
              },
              child: const Text('Service'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50), // Set the width to full and height to 50
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToDetails(BuildContext context, String type) {
    Navigator.pushNamed(
      context,
      RoutesName.itemDetailScreen,
      arguments: {'type': type},
    );
  }
}