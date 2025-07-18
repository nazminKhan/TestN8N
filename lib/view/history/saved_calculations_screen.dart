import 'package:flutter/material.dart';
import 'package:mvvm_demo/view/gst/gst_provider.dart';
import 'package:provider/provider.dart';

class SavedCalculationsScreen extends StatelessWidget {
  const SavedCalculationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gstProvider = Provider.of<GstProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Calculations'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: gstProvider.savedCalculations.length,
          itemBuilder: (context, index) {
            final calculation = gstProvider.savedCalculations[index];
            return Card(
              child: ListTile(
                title: Text('Amount: ${calculation['amount']}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('GST Rate: ${calculation['gstRate']}'),
                    Text('Original Cost: ${calculation['originalCost']}'),
                    Text('Rate Amount: ${calculation['rateAmount']}'),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}