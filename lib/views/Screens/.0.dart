// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
//
// class ImageUploadPage extends StatefulWidget {
//   @override
//   _ImageUploadPageState createState() => _ImageUploadPageState();
// }
//
// class _ImageUploadPageState extends State<ImageUploadPage> {
//   final ImagePicker _picker = ImagePicker();
//   XFile? _imageFile;
//
//   Future<void> pickImage() async {
// final ImagePiker piker =  ImagePicker();
//     final XFile? image =await  piker.pickImage(source: ImageSource.gallery);
//
//     if(image !=null){
//       setState(() {
//         _imageFile =File(image.path);
//       });
//     }
//   }
//
//   Future<void> uploadImage() async {
//     if (_imageFile == null) return;
//
//     final fileName = DateTime.now().microsecondsSinceEpoch.toString();
//
//     final path = 'uploads/$fileName';
//
//
//
//     final response = await Supabase.instance.client.storage.from('imagesz').upload(path, _imageFile!).then(value)=>       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('تم رفع الصورة بنجاح')));
//     ;
//
//
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('رفع صورة إلى Supabase')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: _pickImage,
//               child: Text('اختيار صورة'),
//             ),
//             _imageFile != null
//               ? Image.file(File(_imageFile),
//
//             :const Text("No image selected"),
//
//
//             ],
//             ElevatedButton(
//               onPressed: uploadImage,
//               child: Text('رفع الصورة'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
