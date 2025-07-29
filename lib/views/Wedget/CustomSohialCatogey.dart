import 'package:Tourism_app/views/Wedget/buildSocialIcon.dart';
import 'package:flutter/material.dart';

import '../../models/Item/Item.dart';

class Customsohialcatogey extends StatelessWidget {
  const Customsohialcatogey({super.key, required this.category});
  final Category category;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildSocialIcon(
          icon: Icons.facebook,
          color: Colors.blue,
          label: 'FaceBook',
          url: '${category.facebookLink}',
        ),
        buildSocialIcon(
          icon: Icons.phone,
          color: Colors.green,
          label: 'YouTube',
          url: '${category.whatsAppLink}',
        ),
        buildSocialIcon(
          icon: Icons.camera_alt,
          color: Colors.purple,
          label: 'Instagram',
          url: '${category.youtypeLink}',
        ),

      ],
    );
  }
}
