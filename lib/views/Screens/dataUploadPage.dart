import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
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

  // قائمة الفئات - يجب أن تطابق أسماء الجداول في Supabase تماماً
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
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadCategory(String category) async {
    // التحقق من البيانات المطلوبة
    if (nameController.text.isEmpty || _imageFile == null || selectedValue == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الاسم، الصورة والفئة مطلوبان')),
      );
      return;
    }

    setState(() => isUploading = true);

    try {
      // 1. رفع الصورة إلى Storage
      final fileName = '${DateTime.now().toIso8601String()}${path.extension(_imageFile!.path)}';
      final uploadResponse = await Supabase.instance.client.storage
          .from('category') // يمكنك استخدام bucket واحد لجميع الصور
          .upload('$category/$fileName', _imageFile!);

      if (uploadResponse != null) {
        throw uploadResponse!;
      }

      // 2. الحصول على رابط الصورة
      final imageUrl = Supabase.instance.client.storage
          .from('category')
          .getPublicUrl('$category/$fileName');

      // 3. إدراج البيانات في الجدول المناسب
      final response = await Supabase.instance.client.from(category).insert({
        'name': nameController.text,
        'description': descriptionController.text,
        'image_url': imageUrl,
        'facebook_link': facebookLinkController.text,
        'youtube_link': youtubeLinkController.text,
        'whatsapp_link': whatsappLinkController.text,
        'location_link': locationLinkController.text,
        'phone': phoneLinkController.text,
        'location': locationController.text,
        'number': numberController.text,
        'created_at': DateTime.now().toIso8601String(),
      });

      if (response.error != null) {
        throw response.error!;
      }

      // إظهار رسالة نجاح
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تمت الإضافة بنجاح!')),
      );

      // مسح الحقول بعد الإضافة
      _clearFields();

    } catch (e) {
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
            // Dropdown for category selection
            _buildCategoryDropdown(),
            const SizedBox(height: 16),

            // Image picker
            _buildImagePicker(),
            const SizedBox(height: 16),

            // Text fields
            _buildTextField(nameController, 'الاسم', isRequired: true),
            _buildTextField(descriptionController, 'الوصف'),
            _buildTextField(facebookLinkController, 'رابط فيسبوك'),
            _buildTextField(youtubeLinkController, 'رابط يوتيوب'),
            _buildTextField(whatsappLinkController, 'رابط واتساب'),
            _buildTextField(locationLinkController, 'رابط الموقع'),
            _buildTextField(phoneLinkController, 'رقم الهاتف'),
            _buildTextField(locationController, 'العنوان'),
            _buildTextField(numberController, 'الرقم التعريفي'),
            const SizedBox(height: 20),

            // Submit button
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryDropdown() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: const Row(
          children: [
            Icon(Icons.list, size: 16, color: Colors.yellow),
            SizedBox(width: 4),
            Expanded(
              child: Text(
                'اختر الفئة',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.yellow,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: items
            .map((String item) => DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ))
            .toList(),
        value: selectedValue,
        onChanged: (String? value) {
          setState(() {
            selectedValue = value;
          });
        },
        buttonStyleData: ButtonStyleData(
          height: 50,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.black26),
            color: Colors.redAccent,
          ),
          elevation: 2,
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(Icons.arrow_forward_ios_outlined),
          iconSize: 14,
          iconEnabledColor: Colors.yellow,
          iconDisabledColor: Colors.grey,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.redAccent,
          ),
          offset: const Offset(-20, 0),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: MaterialStateProperty.all<double>(6),
            thumbVisibility: MaterialStateProperty.all<bool>(true),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
          padding: EdgeInsets.only(left: 14, right: 14),
        ),
      ),
    );
  }

  Widget _buildImagePicker() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey[300],
          border: Border.all(color: Colors.grey),
        ),
        child: _imageFile != null
            ? ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.file(_imageFile!, fit: BoxFit.cover),
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.image, size: 50, color: Colors.grey),
            SizedBox(height: 8),
            Text('اضغط لإضافة صورة'),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {bool isRequired = false}) {
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