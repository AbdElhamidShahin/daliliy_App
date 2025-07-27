import 'dart:io';

import 'package:Tourism_app/core/constants/color.dart';
import 'package:Tourism_app/models/cubit/Bloc.dart';
import 'package:Tourism_app/models/cubit/states.dart';
import 'package:Tourism_app/views/Wedget/CarouseSlider.dart';
import 'package:Tourism_app/views/Wedget/CustomIconDown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/helpers/StarRating.dart';
import '../../models/Item/Item.dart';
import '../Wedget/CustomSohialCatogey.dart';
import '../Wedget/IconFavorite.dart';

class CustomDetailsScreen extends StatelessWidget {
  final Category category;
  String text = '';
  CustomDetailsScreen({super.key, required this.category});

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
              constraints: const BoxConstraints(
                minHeight: 120,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
              ),
              child: Row(
                children: [
                  Iconfavorite(category: category),

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
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              category.name,
                              style: const TextStyle(
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
          const Padding(
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
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black54,
                fontSize: 20,
              ),
              // Your other widget content
            ),
          ),
          CustomCarouseSlider(),
          Container(
            color: colorD,
            height: 210,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 30),
              child: Column(
                children: [
                  Text(
                    'تابعونا علي ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 18),
                  Customsohialcatogey(),
                ],
              ),
            ),
          ),
          Center(
            child: BlocBuilder<DalilyCubit, DalilyState>(
              builder: (BuildContext context, state) {
                var cubit = DalilyCubit.get(context);
                return StarRating(
                  size: 50,
                  rating: cubit.rating,
                  onRatingChanged: (newRating) {
                    cubit.RatingState(newRating); // Update rating
                  },
                );
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              width: 160,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32), color: colorA),
              child: const Center(
                  child: Text(
                'تقييم',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              )),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomIconDown(
                icon: Icons.location_on,
                onTap: () {},
                color: Colors.cyan,
              ),
              CustomIconDown(
                icon: Icons.location_on,
                color: Colors.grey,
                onTap: () {
                  launchWhatsApp(phone: "201205687372");

                },
              ),
              CustomIconDown(
                icon: Icons.call,
                color: colorA,
                onTap: () {
                  launch('tel://${category.number}');
                },
              )
            ],
          )
        ]),
      ),
    );
  }
}
void launchWhatsApp({required String phone}) async {
  final url = "https://wa.me/$phone";

  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
