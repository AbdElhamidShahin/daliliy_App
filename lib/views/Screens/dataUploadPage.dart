import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:supabase_flutter/supabase_flutter.dart';

class AddCategoryPage extends StatefulWidget {
  const AddCategoryPage({super.key});

  @override
  State<AddCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController facebookLinkController = TextEditingController();
  final TextEditingController youtubeLinkController = TextEditingController();
  final TextEditingController whatsappLinkController = TextEditingController();
  final TextEditingController locationLinkController = TextEditingController();
  final TextEditingController phoneLinkController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  final picker = ImagePicker();
  File? _imageFile;
  bool isUploading = false;

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadCategory() async {
    if (nameController.text.isEmpty || _imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('الاسم والصورة مطلوبان')),
      );
      return;
    }

    setState(() => isUploading = true);

    try {
      final fileName =
          '${DateTime.now().toIso8601String()}${path.extension(_imageFile!.path)}';
      final fileBytes = await _imageFile!.readAsBytes();

      await Supabase.instance.client.storage
          .from('category')
          .upload(fileName, _imageFile!);

      final imageUrl = Supabase.instance.client.storage
          .from('category')
          .getPublicUrl(fileName);

      await Supabase.instance.client.from('category').insert({
        'name': nameController.text,
        'description': descriptionController.text,
        'imageUrl': imageUrl,
        'facebookLink': facebookLinkController.text,
        'youtypeLink': youtubeLinkController.text,
        'whatsAppLink': whatsappLinkController.text,
        'locationLink': locationLinkController.text,
        'phoneLink': phoneLinkController.text,
        'location': locationController.text,
        'number': numberController.text
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تمت الإضافة بنجاح!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطأ: ${e.toString()}')),
      );
    } finally {
      setState(() => isUploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Category')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: _imageFile != null
                  ? Image.file(_imageFile!, height: 150)
                  : Container(
                      height: 150,
                      width: double.infinity,
                      color: Colors.grey[300],
                      child: Icon(Icons.image, size: 50),
                    ),
            ),
            SizedBox(height: 16),
            TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name')),
            TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description')),
            TextField(
                controller: facebookLinkController,
                decoration: InputDecoration(labelText: 'Facebook Link')),
            TextField(
                controller: youtubeLinkController,
                decoration: InputDecoration(labelText: 'YouTube Link')),
            TextField(
                controller: whatsappLinkController,
                decoration: InputDecoration(labelText: 'WhatsApp Link')),
            TextField(
                controller: locationLinkController,
                decoration: InputDecoration(labelText: 'Location Link')),
            TextField(
                controller: phoneLinkController,
                decoration: InputDecoration(labelText: 'Phone Link')),
            TextField(
                controller: locationController,
                decoration: InputDecoration(labelText: 'Location')),
            TextField(
                controller: numberController,
                decoration: InputDecoration(labelText: 'Number')),
            SizedBox(height: 20),
            isUploading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _uploadCategory,
                    child: Text('Upload Category'),
                  ),
          ],
        ),
      ),
    );
  }
}
