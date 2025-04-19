import 'package:flutter/material.dart';

Future<void> showPriceAlertDialog({
  required BuildContext context,
  required String productId,
  required String productName,
  required double currentPrice,
  required Function(double targetPrice) onSave,
}) async {
  final TextEditingController _priceController = TextEditingController();

  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Set alert price'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(productName, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(' current price: \$${currentPrice.toStringAsFixed(2)}'),
            const SizedBox(height: 12),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'Target Price ', hintText: 'like: 500.00', border: OutlineInputBorder()),
            ),
          ],
        ),
        actions: [
          TextButton(child: const Text('Cancel'), onPressed: () => Navigator.of(context).pop()),
          ElevatedButton(
            child: const Text('Save'),
            onPressed: () {
              final input = _priceController.text;
              final price = double.tryParse(input);
              if (price != null) {
                onSave(price);
                Navigator.of(context).pop();
              } else {
                // تنبيه إذا كان الإدخال غير صالح
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('يرجى إدخال سعر صالح')));
              }
            },
          ),
        ],
      );
    },
  );
}
