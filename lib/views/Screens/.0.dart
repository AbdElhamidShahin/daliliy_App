import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DataEntryPage extends StatefulWidget {
  @override
  _DataEntryPageState createState() => _DataEntryPageState();
}

class _DataEntryPageState extends State<DataEntryPage> {
  File? _image;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // Initialize Supabase client
  final supabase = Supabase.instance.client;

  // Pick an image from gallery
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Upload image to Supabase Storage and insert data into database
  Future<void> _submitData() async {
    final name = _nameController.text.trim();
    final description = _descriptionController.text.trim();

    // Ensure all fields are filled
    if (name.isEmpty || description.isEmpty || _image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('من فضلك قم بملء جميع الحقول')),
      );
      return;
    }

    try {
      // Extract the file name and bucket name
      final fileName = _image!.path.split('/').last;
      const bucketName = 'a';

      // Upload the image to Supabase Storage
      final uploadResponse = await supabase.storage.from(bucketName).upload(fileName, _image!);

      // Check if the uploadResponse contains error
      if (uploadResponse.error != null) {
        print("Error while uploading image: ${uploadResponse.error?.message}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('حدث خطأ أثناء رفع الصورة: ${uploadResponse.error?.message}')),
        );
        return;
      }

      // Get the public URL of the uploaded image
      final imageUrlResponse = supabase.storage.from(bucketName).getPublicUrl(fileName);
      if (imageUrlResponse.error != null) {
        print("Error while fetching image URL: ${imageUrlResponse.error?.message}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('خطأ في جلب رابط الصورة: ${imageUrlResponse.error?.message}')),
        );
        return;
      }
      final imageUrl = imageUrlResponse.data['publicURL'];

      // Insert data into the database
      await insertDataToDatabase(name, description, imageUrl);
    } catch (e) {
      // Print the error to the console in case of an exception
      print("Error during image upload or data insertion: $e");

      // Handle any error during the process
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطأ: $e')),
      );
    }
  }

  // Insert data into Supabase Database
  Future<void> insertDataToDatabase(String name, String description, String imageUrl) async {
    final response = await supabase.from('a').insert([
      {'name': name, 'description': description, 'image_url': imageUrl}
    ]).execute();

    // Check for errors in the response
    if (response.error != null) {
      print("Error while inserting data into database: ${response.error?.message}");
      print("Error details: ${response.error?.details}");
      print("Error hint: ${response.error?.hint}");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطأ أثناء إدخال البيانات: ${response.error?.message}')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تم إضافة البيانات بنجاح!')),
      );

      // Clear the form after successful insertion
      setState(() {
        _nameController.clear();
        _descriptionController.clear();
        _image = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Entry'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Task Name'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Task Description'),
            ),
            GestureDetector(
              onTap: _pickImage,
              child: _image == null
                  ? Icon(Icons.add_a_photo, size: 100)
                  : Image.file(_image!),
            ),
            ElevatedButton(
              onPressed: _submitData,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
