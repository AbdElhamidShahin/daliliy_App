import 'dart:io';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path/path.dart' as path;

class CategoryUploader {
  final BuildContext context;
  CategoryUploader(this.context);

  final Map<String, String> categoryStorageMap = {
    'الصيداليات': 'pharmacies',
    'المعامل': 'pediatrics',
    'اطفال': 'pediatrics',
    'اسنان': 'dentists',
    'عظام': 'orthopedics',
    'اشعه': 'radiology',
    'جلديه': 'dermatology',
    'قلب': 'cardiology',
    'سكر': 'diabetes',
    'علاج_طبيعي': 'physiotherapy',
  };

  Future<void> uploadCategory(
      String category,
      String name,
      String description,
      String facebook,
      String youtube,
      String whatsapp,
      String locationLink,
      String phone,
      String location,
      String number,
      File? imageFile, {
        required VoidCallback onSuccess,
      }) async {
    if (name.isEmpty || imageFile == null || category.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الاسم، الصورة والفئة مطلوبان')),
      );
      return;
    }

    try {
      final extension = path.extension(imageFile.path).toLowerCase();
      final fileName = 'img_\${DateTime.now().millisecondsSinceEpoch}$extension';
      final tableName = categoryStorageMap[category]!;
      final storagePath = '$tableName/$fileName';

      await Supabase.instance.client.storage
          .from('category')
          .upload(storagePath, imageFile);

      final imageUrl = Supabase.instance.client.storage
          .from('category')
          .getPublicUrl(storagePath);

      final response = await Supabase.instance.client
          .from(tableName)
          .insert({
        'name': name.trim(),
        'description': description.trim(),
        'facebookLink': facebook.trim(),
        'youtypeLink': youtube.trim(),
        'whatsAppLink': whatsapp.trim(),
        'locationLink': locationLink.trim(),
        'phoneLink': phone.trim(),
        'location': location.trim(),
        'number': number.trim(),
        'imageUrl': imageUrl,
      });

      if (response.error != null) {
        throw Exception(response.error!.message);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تمت الإضافة بنجاح')),
      );

      onSuccess();
    } catch (e) {
      debugPrint('خطأ أثناء رفع الفئة: \$e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ: \$e')),
      );
    }
  }
}