import 'package:Tourism_app/models/cubit/states.dart';
import 'package:Tourism_app/viewmodels/%D9%8BWedget.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../views/Screens/..dart';
import '../../views/Screens/MedicalScreen.dart';
import '../Item.dart';

class DalilyCubit extends Cubit<DalilyState> {
  DalilyCubit() : super(DalilyInitialState());

  static DalilyCubit get(context) => BlocProvider.of<DalilyCubit>(context);

  int currentIndex = 0;
  double rating = 3.5;

  List<Widget> screens = [
    Wedget(),
    Wedget(),
    Wedget(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(DalilyBottomnavBarState());
  }

  final List<String> imageUrls = [
    'https://dfstudio-d420.kxcdn.com/wordpress/wp-content/uploads/2019/06/digital_camera_photo-1080x675.jpg',
    'https://dfstudio-d420.kxcdn.com/wordpress/wp-content/uploads/2019/06/digital_camera_photo-1080x675.jpg',
    'https://dfstudio-d420.kxcdn.com/wordpress/wp-content/uploads/2019/06/digital_camera_photo-1080x675.jpg',
  ];
  final List<Map<String, dynamic>> items = [
    {
      'urlImage':
          'https://i.pinimg.com/736x/be/b0/0e/beb00e4a420438fc0cdfa3d280e4662a.jpg',
      'name': 'Medical',
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (_) =>
                  DalilyCubit()..fetchCategoryData('task'), // اسم الجدول
              child: MedicalScreen(tableName: 'task'), // اسم الجدول
            ),
          ),
        );
      },
    },
    {
      'urlImage':
      'https://i.pinimg.com/736x/be/b0/0e/beb00e4a420438fc0cdfa3d280e4662a.jpg',
      'name': 'Item 2',
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (_) =>
              DalilyCubit()..fetchCategoryData('a'), // اسم الجدول
              child: MedicalScreen(tableName: 'a'), // اسم الجدول
            ),
          ),
        );
      },
    },
    {
      'urlImage':
          'https://i.pinimg.com/736x/be/b0/0e/beb00e4a420438fc0cdfa3d280e4662a.jpg',
      'name': 'Item 3'
    },
    {
      'urlImage':
          'https://i.pinimg.com/736x/be/b0/0e/beb00e4a420438fc0cdfa3d280e4662a.jpg',
      'name': 'Item 3'
    },
    {
      'urlImage':
          'https://i.pinimg.com/736x/be/b0/0e/beb00e4a420438fc0cdfa3d280e4662a.jpg',
      'name': 'Item 3'
    },
    {
      'urlImage':
          'https://i.pinimg.com/736x/be/b0/0e/beb00e4a420438fc0cdfa3d280e4662a.jpg',
      'name': 'Item 3'
    },
    {
      'urlImage':
          'https://i.pinimg.com/736x/be/b0/0e/beb00e4a420438fc0cdfa3d280e4662a.jpg',
      'name': 'Item 3'
    },
    {
      'urlImage':
          'https://i.pinimg.com/736x/be/b0/0e/beb00e4a420438fc0cdfa3d280e4662a.jpg',
      'name': 'Item 3'
    },
  ];
  final List<Map<String, String>> items2 = [
    {
      'urlImage':
          'https://i.pinimg.com/736x/93/62/67/936267364e11eb8ced548fda3b62b31b.jpg',
      'name': 'Item 1'
    },
    {
      'urlImage':
          'https://i.pinimg.com/736x/93/62/67/936267364e11eb8ced548fda3b62b31b.jpg',
      'name': 'Item 2'
    },
    {
      'urlImage':
          'https://i.pinimg.com/736x/93/62/67/936267364e11eb8ced548fda3b62b31b.jpg',
      'name': 'Item 3'
    },
    {
      'urlImage':
          'https://i.pinimg.com/736x/93/62/67/936267364e11eb8ced548fda3b62b31b.jpg',
      'name': 'Item 3'
    },
    {
      'urlImage':
          'https://i.pinimg.com/736x/93/62/67/936267364e11eb8ced548fda3b62b31b.jpg',
      'name': 'Item 3'
    },
    {
      'urlImage':
          'https://i.pinimg.com/736x/93/62/67/936267364e11eb8ced548fda3b62b31b.jpg',
      'name': 'Item 3'
    },
    {
      'urlImage':
          'https://i.pinimg.com/736x/93/62/67/936267364e11eb8ced548fda3b62b31b.jpg',
      'name': 'Item 3'
    },
    {
      'urlImage':
          'https://i.pinimg.com/736x/93/62/67/936267364e11eb8ced548fda3b62b31b.jpg',
      'name': 'Item 3'
    },
  ];
  void updateRating(double newRating) {
    print("تم تحديث التقييم إلى: $newRating");
    rating = newRating;
    emit(UpdateRatingState(rating));
  }

  Future<void> fetchCategoryData(String tableName) async {
    try {
      emit(CategoryLoadingState());

      final response = await Supabase.instance.client
          .from(tableName)
          .select('name, description, image_url')
          .execute();

      if (response.data == null || (response.data as List).isEmpty) {
        emit(CategoryError('No data found for table "$tableName".'));
        return;
      }

      final List<Category> categories = (response.data as List).map((item) {
        return Category(
          name: item['name'] ?? 'No Name',
          description: item['description'] ?? 'No Description',
          imageUrl: item['image_url'] ?? '',
        );
      }).toList();

      emit(CategoryLoaded(categories));
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }
}
