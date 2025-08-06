import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:supabase_flutter/supabase_flutter.dart';

import '../Wedget/category_dropdown.dart';
import '../Wedget/image_picker_widget.dart';

class AddCategoryPage extends StatefulWidget {
  const AddCategoryPage({super.key});

  @override
  State<AddCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  // Controllers
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
  String? selectedValue;

  final Map<String, String> categoryStorageMap = {
    'الصيداليات': 'pharmacies',
    'المعامل': 'pediatrics', // تأكد من وجود جدول labs في قاعدة البيانات
    'اطفال': 'pediatrics',
    'اسنان': 'dentists',
    'عظام': 'orthopedics',
    'اشعه': 'radiology',
    'جلديه': 'dermatology',
    'قلب': 'cardiology',
    'سكر': 'diabetes',
    'علاج_طبيعي': 'physiotherapy',
  };
  final List<String> items = [
    'الصيداليات',
    'المعامل',
    'اطفال',
    'اسنان',
    'عظام',
    'اشعه',
    'جلديه',
    'قلب',
    'سكر',
    'علاج_طبيعي', // استبدلت المسافة بشرطة سفلية لتجنب المشاكل
  ];
  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final extension = path.extension(pickedFile.path).toLowerCase();
      if (!['.jpg', '.jpeg', '.png', '.webp'].contains(extension)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('صيغة الملف غير مدعومة')),
        );
        return;
      }
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadCategory(String category) async {
    if (nameController.text.isEmpty ||
        _imageFile == null ||
        selectedValue == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الاسم، الصورة والفئة مطلوبان')),
      );
      return;
    }

    setState(() => isUploading = true);

    try {
      // التحقق من ملف الصورة
      if (!await _imageFile!.exists()) {
        throw Exception('ملف الصورة غير موجود');
      }

      // إنشاء اسم ملف فريد
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final extension = path.extension(_imageFile!.path).toLowerCase();
      final fileName = 'img_$timestamp${[
        '.jpg',
        '.jpeg',
        '.png',
        '.webp'
      ].contains(extension) ? extension : '.jpg'}';

      // تحديد اسم مجلد التخزين حسب الفئة
      final tableName = categoryStorageMap[selectedValue];
      if (tableName == null) {
        throw Exception('الفئة المحددة غير موجودة في الخريطة');
      }

      // رفع الصورة إلى التخزين
      final storagePath = '$tableName/$fileName';
      await Supabase.instance.client.storage
          .from('category')
          .upload(storagePath, _imageFile!);

      // الحصول على رابط الصورة
      final imageUrl = Supabase.instance.client.storage
          .from('category')
          .getPublicUrl(storagePath);

      // إدخال البيانات في جدول Supabase
      final response = await Supabase.instance.client.from(tableName).insert({
        'name': nameController.text.trim(),
        'description': descriptionController.text.trim(),
        'facebookLink': facebookLinkController.text.trim(),
        'youtypeLink': youtubeLinkController.text.trim(),
        'whatsAppLink': whatsappLinkController.text.trim(),
        'locationLink': locationLinkController.text.trim(),
        'phoneLink': phoneLinkController.text.trim(),
        'location': locationController.text.trim(),
        'number': numberController.text.trim(),
        'imageUrl': imageUrl,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تمت الإضافة بنجاح')),
      );
      if (response.error != null) {
        throw Exception('فشل في الإضافة: ${response.error!.message}');
      }

      _clearFields();
    } catch (e) {
      debugPrint('Error details: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ: ${e.toString()}')),
      );
    } finally {
      setState(() => isUploading = false);
    }
  }

  void _clearFields() {
    nameController.clear();
    descriptionController.clear();
    facebookLinkController.clear();
    youtubeLinkController.clear();
    whatsappLinkController.clear();
    locationLinkController.clear();
    phoneLinkController.clear();
    locationController.clear();
    numberController.clear();
    setState(() {
      _imageFile = null;
      selectedValue = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إضافة فئة جديدة')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CategoryDropdown(
              items: items,
              selectedValue: selectedValue,
              onChanged: (value) => setState(() => selectedValue = value),
            ),
            const SizedBox(height: 16),
            ImagePickerWidget(
              imageFile: _imageFile,
              onTap: _pickImage,
            ),

            const SizedBox(height: 16),

            // Text fields
            _buildTextField(nameController, 'الاسم'),
            _buildTextField(descriptionController, 'الوصف'),
            _buildTextField(facebookLinkController, 'رابط فيسبوك'),
            _buildTextField(youtubeLinkController, 'رابط يوتيوب'),
            _buildTextField(whatsappLinkController, 'رابط واتساب'),
            _buildTextField(locationLinkController, 'رابط الموقع'),
            _buildTextField(phoneLinkController, 'رقم الهاتف'),
            _buildTextField(locationController, 'العنوان'),
            const SizedBox(height: 20),

            // Submit button
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {bool isRequired = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: '$label${isRequired ? ' *' : ''}',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: Colors.redAccent,
        ),
        onPressed: isUploading
            ? null
            : () {
                if (selectedValue != null) {
                  _uploadCategory(selectedValue!);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('من فضلك اختر فئة أولاً')),
                  );
                }
              },
        child: isUploading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text(
                'إضافة الفئة',
                style: TextStyle(fontSize: 18),
              ),
      ),
    );
  }
}
