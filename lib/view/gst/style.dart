import 'dart:ui';

import 'package:flutter/material.dart';

import '../../utils/app_color.dart';

class Style{
  static TextStyle headline1=const TextStyle(fontSize: 20,fontWeight: FontWeight.w300);
  static TextStyle initial_Amount=const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 18);

   static TextStyle buttonText=const TextStyle(fontSize: 18, color: Colors.white,fontWeight: FontWeight.w600);
   static ButtonStyle buttonStyle=ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(45),
                maximumSize: const Size.fromHeight(45),
                backgroundColor: primary, // Background color
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10), // Button padding
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(1), // Rounded corners
                ),
              );
}