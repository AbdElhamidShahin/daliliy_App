import 'package:flutter/material.dart';

Widget buildErrorWidget(String error, {VoidCallback? onRetry}) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.error_outline, size: 48, color: Colors.red),
        const SizedBox(height: 16),
        Text('حدث خطأ أثناء تحميل البيانات',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[700],
            )),
        const SizedBox(height: 8),
        Text(error,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            )),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: onRetry,
          child: const Text('حاول مرة أخرى'),
        ),
      ],
    ),
  );
}