import 'dart:io' show File;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/constants/categoryStorageMap.dart';
import '../Wedget/contact/buildTextField.dart';
import '../Wedget/dropdowns/category_dropdown.dart';
import '../Wedget/image/image_picker_widget.dart';

class AddCategoryPage extends StatefulWidget {
  AddCategoryPage({super.key});

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
  String? selectedMainCategory;
  String? selectedSubCategory;

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final extension = path.extension(pickedFile.path).toLowerCase();
      if (!['.jpg', '.jpeg', '.png', '.webp'].contains(extension)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('صيغة الملف غير مدعومة')),
        );
        return;
      }
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadCategory() async {
    if (nameController.text.isEmpty ||
        _imageFile == null ||
        selectedSubCategory == null) {
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
      final tableName = categoryStorageMap[selectedSubCategory];
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
      await Supabase.instance.client.from(tableName).insert({
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
      selectedMainCategory = null;
      selectedSubCategory = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
        child: Text(
          'إضافة فئة جديدة',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      )),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CategoryDropdown(
              items: items.keys.toList(),
              selectedValue: selectedMainCategory,
              onChanged: (value) {
                setState(() {
                  selectedMainCategory = value;
                  selectedSubCategory = null; // تصفير الفرعي
                });
              },
            ),

            const SizedBox(height: 16),

            // اختيار الفئة الفرعية بناءً على الرئيسي
            if (selectedMainCategory != null)
              CategoryDropdown(
                items: items[selectedMainCategory]!,
                selectedValue: selectedSubCategory,
                onChanged: (value) {
                  setState(() {
                    selectedSubCategory = value;
                  });
                },
              ),
            const SizedBox(height: 70),
            ImagePickerWidget(
              imageFile: _imageFile,
              onTap: pickImage,
            ),

            const SizedBox(height: 16),

            // Text fields
            buildTextField(nameController, 'الاسم', icon: Icons.person),
            buildTextField(descriptionController, 'الوصف', icon: Icons.message),
            buildTextField(facebookLinkController, 'رابط فيسبوك',
                icon: Icons.facebook),
            buildTextField(youtubeLinkController, 'رابط يوتيوب',
                icon: Icons.video_library),
            buildTextField(whatsappLinkController, 'رابط واتساب',
                icon: Icons.message),
            buildTextField(locationLinkController, 'رابط الموقع',
                icon: Icons.link),
            buildTextField(phoneLinkController, 'رقم الهاتف',
                icon: Icons.phone),
            buildTextField(locationController, 'العنوان',
                icon: Icons.location_on),

            const SizedBox(height: 20),

            // Submit button
            buildElevatedButton(),
          ],
        ),
      ),
    );
  }

  Widget buildElevatedButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // الحواف الدائرية
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: Colors.blue,
        ),
        onPressed: isUploading
            ? null
            : () async {
                if (selectedSubCategory != null) {
                  try {
                    await _uploadCategory();
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          children: [
                            const Icon(Icons.error_outline,
                                color: Colors.white, size: 28),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'فشل في إضافة الفئة، حاول مرة أخرى',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        backgroundColor: Colors.red.shade600,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        margin: const EdgeInsets.all(16),
                        duration: const Duration(seconds: 3),
                      ),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Row(
                        children: [
                          const Icon(Icons.warning_amber_rounded,
                              color: Colors.white, size: 28),
                          const SizedBox(width: 12),
                          const Text('من فضلك اختر فئة أولاً'),
                        ],
                      ),
                      backgroundColor: Colors.orange.shade700,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.all(16),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
              },
        child: isUploading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text(
                'إضافة الفئة',
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}
