import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> uploadImage(File imageFile) async {
  final supabase = Supabase.instance.client;

  try {
    final fileName = 'image_${DateTime.now().millisecondsSinceEpoch}.jpg';

    // رفع الصورة إلى التخزين
    final storageResponse = await supabase.storage
        .from('task') // اسم المجلد في Supabase
        .upload(fileName, imageFile);

    if (storageResponse.error != null) {
      print('Error uploading image: ${storageResponse.error!.message}');
      return;
    }

    // الحصول على الرابط العام للصورة
    final imageUrl = supabase.storage.from('task').getPublicUrl(fileName);

    // إدخال رابط الصورة في قاعدة البيانات
    await insertImageToDatabase(imageUrl);
  } catch (e) {
    print('Error uploading image: $e');
  }
}

Future<void> insertImageToDatabase(String imageUrl) async {
  final supabase = Supabase.instance.client;

  try {
    // إدخال البيانات إلى الجدول
    final response = await supabase.from('task').insert([
      {
        'name': 'Sample Image',
        'description': 'This is a sample description',
        'image_url': imageUrl, // رابط الصورة
      }
    ]);

    if (response.error != null) {
      print('Error inserting image: ${response.error!.message}');
    } else {
      print('Image inserted successfully!');
    }
  } catch (e) {
    print('Error: $e');
  }
}
