import 'package:Tourism_app/views/Wedget/buildSocialIcon.dart';
import 'package:flutter/material.dart';

class Customsohialcatogey extends StatelessWidget {
  const Customsohialcatogey({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildSocialIcon(
          icon: Icons.facebook,
          color: Colors.blue,
          label: 'FaceBook',
          url: 'https://www.facebook.com/profile.php?id=100027808480129',
        ),
        buildSocialIcon(
          icon: Icons.video_library,
          color: Colors.red,
          label: 'YouTube',
          url: 'https://www.youtube.com',
        ),
        buildSocialIcon(
          icon: Icons.camera_alt,
          color: Colors.purple,
          label: 'Instagram',
          url: 'https://www.instagram.com',
        ),
        buildSocialIcon(
          icon: Icons.web,
          color: Colors.green,
          label: 'Website',
          url: 'https://www.example.com',
        ),
      ],
    );
  }
}
