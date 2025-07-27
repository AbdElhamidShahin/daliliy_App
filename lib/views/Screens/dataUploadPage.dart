import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddCategoryPage extends StatefulWidget {
  const AddCategoryPage({super.key});

  @override
  State<AddCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();
  final TextEditingController facebookLinkController = TextEditingController();
  final TextEditingController youtubeLinkController = TextEditingController();
  final TextEditingController whatsappLinkController = TextEditingController();
  final TextEditingController locationLinkController = TextEditingController();
  final TextEditingController phoneLinkController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  bool isUploading = false;

  Future<void> _uploadCategory() async {
    if (nameController.text.isEmpty || descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }

    setState(() => isUploading = true);

    try {
      await Supabase.instance.client.from('category').insert({
        'name': nameController.text,
        'description': descriptionController.text,
        'imageUrl': imageUrlController.text,
        'facebookLink': facebookLinkController.text,
        'youtypeLink': youtubeLinkController.text,
        'whatsAppLink': whatsappLinkController.text,
        'locationLink': locationLinkController.text,
        'phoneLink': phoneLinkController.text,
        'location': locationController.text,
        'number': int.tryParse(numberController.text) ?? 0,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Category added successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }

    setState(() => isUploading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Category')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: imageUrlController,
              decoration: InputDecoration(labelText: 'Image URL'),
            ),
            TextField(
              controller: facebookLinkController,
              decoration: InputDecoration(labelText: 'Facebook Link'),
            ),
            TextField(
              controller: youtubeLinkController,
              decoration: InputDecoration(labelText: 'YouTube Link'),
            ),
            TextField(
              controller: whatsappLinkController,
              decoration: InputDecoration(labelText: 'WhatsApp Link'),
            ),
            TextField(
              controller: locationLinkController,
              decoration: InputDecoration(labelText: 'Location Link'),
            ),
            TextField(
              controller: phoneLinkController,
              decoration: InputDecoration(labelText: 'Phone Link'),
            ),
            TextField(
              controller: locationController,
              decoration: InputDecoration(labelText: 'Location'),
            ),
            TextField(
              controller: numberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Number'),
            ),
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
