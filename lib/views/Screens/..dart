import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DataEntryPage extends StatefulWidget {
  @override
  _DataEntryPageState createState() => _DataEntryPageState();
}

class _DataEntryPageState extends State<DataEntryPage> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageUrlController = TextEditingController();

  // متغير لتخزين حالة التحميل
  bool _isLoading = false;

  // الدالة لإرسال البيانات إلى Supabase
  Future<void> _submitData() async {
    final name = _nameController.text;
    final description = _descriptionController.text;
    final imageUrl = _imageUrlController.text;

    if (name.isEmpty || description.isEmpty || imageUrl.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('يرجى ملء جميع الحقول بشكل صحيح')));
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await Supabase.instance.client
          .from('items') // استبدل بـاسم الجدول الخاص بك في Supabase
          .insert([
        {
          'name': name,
          'description': description,
          'imageUrl': imageUrl,
        }
      ]).execute();

      // التحقق من حالة الاستجابة
      if (response.status == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('تم إرسال البيانات بنجاح')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('حدث خطأ: ${response.error?.message}')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('حدث خطأ')));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('إدخال البيانات')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'الاسم'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'الوصف'),
            ),
            TextField(
              controller: _imageUrlController,
              decoration: InputDecoration(labelText: 'رابط الصورة'),
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
              onPressed: _submitData,
              child: Text('إرسال البيانات'),
            ),
          ],
        ),
      ),
    );
  }
}
