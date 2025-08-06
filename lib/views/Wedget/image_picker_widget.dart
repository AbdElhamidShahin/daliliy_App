import 'dart:io';
import 'package:flutter/material.dart';

class ImagePickerWidget extends StatelessWidget {
  final File? imageFile;
  final VoidCallback onTap;

  const ImagePickerWidget({
    super.key,
    required this.imageFile,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey[300],
          border: Border.all(color: Colors.grey),
        ),
        child: imageFile != null
            ? ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.file(imageFile!, fit: BoxFit.cover),
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.image, size: 50, color: Colors.grey),
            SizedBox(height: 8),
            Text('اضغط لإضافة صورة'),
          ],
        ),
      ),
    );
  }
}
