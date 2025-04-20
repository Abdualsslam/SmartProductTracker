import 'package:flutter/material.dart';
import 'package:flutter_notie/flutter_notie.dart';

Future<double?> showPriceAlertDialog(BuildContext context, String productId) {
  final priceController = TextEditingController();

  return showDialog<double>(
    context: context,
    builder:
        (context) => AlertDialog(
          title: const Text('set price alert'),
          content: TextField(
            controller: priceController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(hintText: 'enter price'),
          ),
          actions: [
            TextButton(child: const Text('Cancel'), onPressed: () => Navigator.of(context).pop()),
            ElevatedButton(
              child: const Text('save'),
              onPressed: () {
                final input = priceController.text;
                final price = double.tryParse(input);

                if (price != null) {
                  Navigator.of(context).pop(price); // ✅ رجع السعر فقط
                } else {
                  FlutterNotie.error(context, message: 'plz enter a valid price');
                }
              },
            ),
          ],
        ),
  );
}
