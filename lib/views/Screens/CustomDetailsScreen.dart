import 'package:Tourism_app/core/constants/color.dart';
import 'package:Tourism_app/models/cubit/Bloc.dart';
import 'package:Tourism_app/models/cubit/states.dart';
import 'package:Tourism_app/views/Wedget/CarouseSlider.dart';
import 'package:Tourism_app/views/Wedget/CustomIconDown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/helpers/StarRating.dart';
import '../../models/Item.dart';
import '../Wedget/CustomSohialCatogey.dart';
import '../Wedget/IconFavorite.dart';

class CustomDetailsScreen extends StatelessWidget {
  final Category category;
   final bool? isFavorite;
   CustomDetailsScreen({super.key, required this.category,  this.isFavorite});

  @override
  Widget build(BuildContext context) {
    bool isFavoriteValue = isFavorite ?? false;

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


                  Iconfavorite(isFavorite: isFavoriteValue, category: category),

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
            color: colorD,
            height: 210,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 30),
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
                  rating: cubit.rating,
                  onRatingChanged: (newRating) {
                    cubit.RatingState(newRating); // Update rating
                  },
                );
              },
            ),
          ),
          SizedBox(height: 20,),
          Center(
            child: Container(
              width: 160,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32), color: colorA),
              child: Center(
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
              CustomIconDown(Icons.location_on,Colors.cyan ),
              CustomIconDown(Icons.location_on,Colors.grey),
              CustomIconDown(Icons.call,colorA),
            ],
          )
        ]),
      ),
    );
  }
}
