import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snackly/snackly.dart';
import '../../services/LocalStorageAccount.dart.dart';
import '../../utils/app_colors.dart';

class EditAccountScreen extends StatefulWidget {
  @override
  _EditAccountScreenState createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      Snackly.error(
        context: context,
        title: "حدث خطأ أثناء اختيار الصورة",
        style: SnackbarStyle.filled,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFD),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: const Center(
          child: Text(
            "        تعديل الملف الشخصي",
            style: TextStyle(
              color: Color(0xFF2D3748),
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                icon: Icon(Icons.arrow_forward_ios_rounded, color: colorA),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                      boxShadow:const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 12,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: _imageFile != null
                          ? Image.file(_imageFile!, fit: BoxFit.cover)
                          : Image.asset(
                              "assets/Image/AfatarMan.jpg",
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.cyan,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: colorA.withOpacity(0.4),
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child:const Icon(Icons.camera_alt,
                            color: Colors.white, size: 28),
                      ),
                    ),
                  ),
                ],
              ),
             const SizedBox(height: 8),
              const  Text(
                "تغيير الصورة",
                style: TextStyle(
                  color: colorA,
                  fontWeight: FontWeight.w500,
                  fontSize: 18
                ),
              ),
              const   SizedBox(height: 32),

              // Form section
              Container(
                padding:const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow:const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildTextField(
                        controller: _nameController,
                        label: "الاسم الكامل",
                        icon: Icons.person_outline,
                        validatorMsg: "يرجى إدخال الاسم",
                      ),
                      const  SizedBox(height: 20),
                      _buildTextField(
                        controller: _emailController,
                        label: "البريد الإلكتروني",
                        icon: Icons.email_outlined,
                        validatorMsg: "يرجى إدخال البريد الإلكتروني",
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 20),
                      _buildTextField(
                        controller: _phoneController,
                        label: "رقم الهاتف",
                        icon: Icons.phone_iphone_outlined,
                        validatorMsg: "يرجى إدخال رقم الهاتف",
                        keyboardType: TextInputType.phone,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 50),

              // Save button
              Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  gradient:const LinearGradient(
                    colors: [Color(0xFF4E54C8), Color(0xFF8F94FB)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF4E54C8).withOpacity(0.4),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await UserDataManager.saveUserData(
                        name: _nameController.text,
                        phone: _phoneController.text,
                        email: _emailController.text,
                        imagePath: _imageFile?.path,
                      );
                      Navigator.pop  (context, true);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child:const Text(
                    "حفظ التغييرات",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String validatorMsg,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: (value) =>
          value == null || value.isEmpty ? validatorMsg : null,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey[600]),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        prefixIcon: Icon(icon, color: colorA),
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:const  BorderSide(color: Colors.blue, width: 1.5),
        ),
      ),
    );
  }
}
