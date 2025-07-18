import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvvm_demo/utils/app_color.dart';

class CustomTextField extends StatelessWidget {
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final double height;
  final TextEditingController controller;

  const CustomTextField({
    super.key,
    required this.keyboardType,
    required this.inputFormatters,
    required this.controller,
    this.height = 40.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height, // Set the desired height
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          border: const OutlineInputBorder(), // Adds a border
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.primary), // Change this color
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.primary), // Change this color
          ),
          contentPadding: const EdgeInsets.symmetric(
              vertical: 5, horizontal: 15), // Adjust padding
        ),
      ),
    );
  }
}