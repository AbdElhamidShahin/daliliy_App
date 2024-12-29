import 'dart:ui';

import 'package:Tourism_app/models/cubit/Bloc.dart';
import 'package:Tourism_app/models/cubit/states.dart';
import 'package:Tourism_app/views/Wedget/CarouseSlider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/helpers/StarRating.dart';
import '../../models/Item.dart';
import '../Wedget/buildSocialIcon.dart';

class CustomDetailsScreen extends StatelessWidget {
  final Category category;

  const CustomDetailsScreen({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Container(
            height: 450,
            width: double.infinity,
            child: Image.network(
              category.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 10, top: 0),
            child: Container(
              height: 120,
              constraints: BoxConstraints(
                minHeight: 120,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
              ),
              child: Row(
                children: [
                  // 1/5 for Icon
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.favorite_border, size: 32)),
                  ),
                  // 2/5 for text (title, subtitle, and rating)
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 12.0),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 12,
                            ),
                            Text(
                              category.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // 1/5 for Image (using FractionallySizedBox to scale image)
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FractionallySizedBox(
                        alignment: Alignment.center,
                        heightFactor: 0.99,
                        widthFactor:
                            1.2, // Ensures the image takes the full height
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            category.imageUrl, // Use the passed imageUrl here
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // 1/5 Empty Space (Adjustable if needed)
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
            ),
            child: Text(
              "الوصف",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              category.description,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black54,
                fontSize: 20,
              ),
              // Your other widget content
            ),
          ),
          CustomCarouseSlider(),
          Container(
            color: Colors.grey,
            height: 150,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                children: [
                  const Text(
                    'تابعونا علي ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildSocialIcon(
                        icon: Icons.facebook,
                        color: Colors.blue,
                        label: 'FaceBook',
                        url: 'https://www.facebook.com',
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
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomIcon(Icons.location_on),
              CustomIcon(Icons.location_on),
              CustomIcon(Icons.call),
            ],
          )
        ]),
      ),
    );
  }
}

void _launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Widget CustomIcon(IconData icon) {
  return Padding(
    padding: const EdgeInsets.only(top: 50, right: 10, bottom: 20),
    child: Container(
      width: 120,
      height: 45,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          color: Color.fromARGB(255, 69, 187, 205)),
      child: Icon(
        icon,
        color: Colors.white,
      ),
    ),
  );
}
