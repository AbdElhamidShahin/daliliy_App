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
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.blue.shade100.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue.shade200, width: 1.5),
            ),
            child: imageFile != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      imageFile!,
                      fit: BoxFit.cover,
                    ),
                  )
                : Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Text(
                        'اضغط لإضافة صورة',
                        style: TextStyle(
                          color: Colors.blue.shade800,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
          ),
          if (imageFile == null)
            Positioned(
              top: -50,
              left: 0,
              right: 0,
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blue.withOpacity(0.8),
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 38,
                ),
              ),
            ),

        ],
      ),
    );
  }
}
