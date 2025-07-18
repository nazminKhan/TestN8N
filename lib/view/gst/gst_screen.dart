import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvvm_demo/app_store/app_store.dart';
import 'package:mvvm_demo/routes/routes_name.dart';
import 'package:mvvm_demo/utils/app_color.dart';
import 'package:mvvm_demo/utils/strings.dart';
import 'package:mvvm_demo/view/gst/style.dart';
import 'package:mvvm_demo/view/login_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:io';

import '../../common_widgets/custom_app_bar.dart';
import '../../common_widgets/custom_label.dart';
import '../../common_widgets/custom_text_field.dart';
import '../../utils/custom_button.dart';
import '../history/saved_calculations_screen.dart';
import 'gst_provider.dart';

class GstScreen extends StatefulWidget {
  const GstScreen({super.key});

  @override
  State<GstScreen> createState() => _GstScreenState();
}

class _GstScreenState extends State<GstScreen> {
  final TextEditingController _initialAmountController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _netController = TextEditingController();
  final TextEditingController _gstController = TextEditingController();
  final TextEditingController _totalController = TextEditingController();
  
  String _selectedOption = 'Option1';
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  @override
  void dispose() {
    _initialAmountController.dispose();
    _rateController.dispose();
    _netController.dispose();
    _gstController.dispose();
    _totalController.dispose();
    super.dispose();
  }

  void _loadInitialData() {
    final gstProvider = Provider.of<GstProvider>(context, listen: false);
    _initialAmountController.text = gstProvider.amount.toStringAsFixed(2);
    _rateController.text = gstProvider.gstRate.toStringAsFixed(2);
    _netController.text = gstProvider.amount.toStringAsFixed(2);
    _gstController.text = gstProvider.rateAmount.toStringAsFixed(2);
    _totalController.text = gstProvider.originalCost.toStringAsFixed(2);
    _selectedOption = gstProvider.isAddGst ? 'Option1' : 'Option2';
  }

  void _calculateGst() {
    FocusScope.of(context).unfocus();
    double amount = double.tryParse(_initialAmountController.text) ?? 0;
    double gstRate = double.tryParse(_rateController.text) ?? 0;

    if (amount == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please Enter Amount')),
      );
      return;
    }

    if (gstRate == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please Select rate of GST')),
      );
      return;
    }

    final gstProvider = Provider.of<GstProvider>(context, listen: false);
    gstProvider.calculateGst(amount, gstRate, _selectedOption == 'Option1');

    setState(() {
      _netController.text = gstProvider.amount.toStringAsFixed(2);
      _gstController.text = gstProvider.rateAmount.toStringAsFixed(2);
      _totalController.text = gstProvider.originalCost.toStringAsFixed(2);
    });
  }

  Future<void> _takeScreenshot() async {
    try {
      final directory = (await getApplicationDocumentsDirectory()).path;
      final fileName = 'screenshot.png';
      final path = '$directory/$fileName';

      final imagePath = await screenshotController.captureAndSave(directory, fileName: fileName);
      if (imagePath != null && imagePath.isNotEmpty) {
        Share.shareXFiles([XFile(imagePath)], text: 'Here is the screenshot of the GST calculation.');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error taking screenshot: Image path is null or empty')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error taking screenshot: $error')),
      );
    }
  }

  void _saveCalculation() {
    double amount = double.tryParse(_initialAmountController.text) ?? 0;
    double gstRate = double.tryParse(_rateController.text) ?? 0;

    if (amount == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please Enter Amount')),
      );
      return;
    }

    if (gstRate == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please Select rate of GST')),
      );
      return;
    }

    final gstProvider = Provider.of<GstProvider>(context, listen: false);
    gstProvider.saveCalculation();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Calculation saved successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GST Calculator'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SavedCalculationsScreen()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Screenshot(
            controller: screenshotController,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: CustomLabel(
                          text: Initial_Amount,
                          style: Style.initial_Amount,
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: CustomTextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          controller: _initialAmountController,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: CustomLabel(
                          text: Rate_of_GST,
                          style: Style.initial_Amount,
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: CustomTextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          controller: _rateController,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Radio<String>(
                              value: 'Option1',
                              activeColor: AppColor.primary,
                              groupValue: _selectedOption,
                              onChanged: (value) {
                                setState(() {
                                  _selectedOption = value!;
                                });
                              },
                            ),
                            Text(
                              Add_GST,
                              style: Style.initial_Amount,
                            ),
                            const SizedBox(width: 20),
                            Radio<String>(
                              value: 'Option2',
                              activeColor: AppColor.primary,
                              groupValue: _selectedOption,
                              onChanged: (value) {
                                setState(() {
                                  _selectedOption = value!;
                                });
                              },
                            ),
                            Text(
                              Remove_GST,
                              style: Style.initial_Amount,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: Calculate_GST,
                    textStyle: Style.buttonText,
                    buttonStyle: Style.buttonStyle,
                    onPressed: _calculateGst,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: CustomLabel(
                          text: Net_Amount,
                          style: Style.initial_Amount,
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: CustomTextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          controller: _netController,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: CustomLabel(
                          text: GST_Amount,
                          style: Style.initial_Amount,
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: CustomTextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          controller: _gstController,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: CustomLabel(
                          text: Total_Amount,
                          style: Style.initial_Amount,
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: CustomTextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          controller: _totalController,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: Share_Screenshot,
                    textStyle: Style.buttonText,
                    buttonStyle: Style.buttonStyle,
                    onPressed: _takeScreenshot,
                  ),
                  const SizedBox(height: 10),
                  CustomButton(
                    text: Save_Calculation,
                    textStyle: Style.buttonText,
                    buttonStyle: Style.buttonStyle,
                    onPressed: _saveCalculation,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}