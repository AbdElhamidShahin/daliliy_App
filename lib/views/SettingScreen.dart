import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ImageAndDataUploadPage extends StatefulWidget {
  @override
  _ImageAndDataUploadPageState createState() => _ImageAndDataUploadPageState();
}

class _ImageAndDataUploadPageState extends State<ImageAndDataUploadPage> {
  XFile? _imageFile;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final _supabase = Supabase.instance.client;
  Future pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);//لاختيار الصور من الجهاز

    if (image != null) {
      setState(() {
        _imageFile = image;
      });
    }
  }

  Future<void> uploadImage() async {
    if (_imageFile == null) return;

    final fileName = DateTime.now().microsecondsSinceEpoch.toString(); //ارفع الصور لقاعده البيانات storage
    final path = 'uploads/$fileName';

    try {
      await _supabase.storage.from('images').upload(path, File(_imageFile!.path));
      ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text('تم رفع الصورة بنجاح')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('فشل في رفع الصورة')));
    }
  }

  Future<void> uploadData() async { // لرفع الوصف والاسم الي قاعده البيانات
    if (titleController.text.isEmpty || descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Title and description cannot be empty')),
      );
      return;
    }

    try {
      await _supabase.from('task').insert({
        'name': titleController.text,
        'description': descriptionController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data uploaded successfully!')),
      );

      titleController.clear();
      descriptionController.clear();

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload data: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('رفع صورة وبيانات إلى Supabase')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Image picker
            ElevatedButton(
              onPressed: pickImage,
              child: Text('اختيار صورة'),
            ),
            _imageFile != null
                ? Image.file(File(_imageFile!.path))
                : const Text("لا توجد صورة مختارة"),

            SizedBox(height: 20),

            // Title and description input fields
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),

            SizedBox(height: 20),

            // Buttons for uploading image and data
            ElevatedButton(
              onPressed: () {
                uploadImage();
                uploadData();
              },
              child: Text('رفع الصورة والبيانات'),
            ),
          ],
        ),
      ),
    );
  }
}
