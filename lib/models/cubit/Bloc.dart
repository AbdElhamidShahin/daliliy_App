import 'package:Tourism_app/models/cubit/states.dart';
import 'package:Tourism_app/viewmodels/%D9%8BWedget.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../views/Screens/..dart';
import '../../views/Screens/MedicalScreen.dart';

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
              builder: (context) => MedicalScreen(),
            ));
      },
    },
    {
      'urlImage':
          'https://i.pinimg.com/736x/be/b0/0e/beb00e4a420438fc0cdfa3d280e4662a.jpg',
      'name': 'Item 2'
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

  List<String> images = [];


  final supabaseClient = Supabase.instance.client;

  Future<void> fetchData() async {
    try {
      emit(DalilyLoading()); // Indicate loading state

      final response = await supabaseClient
          .from('task')
          .select('image_url, name, description')
          .execute();

      print('Response status: ${response.status}');
      print('Response data: ${response.data}');

      if (response.status != 200 || response.data == null) {
        emit(DalilyError("Error fetching data: ${response.status}"));
        return;
      }

      if (response.data is List && response.data.isEmpty) {
        emit(DalilyError("No data available"));
        return;
      }

      List<Map<String, String>> result = List<Map<String, String>>.from(
        response.data.map((item) => {
          'image_url': item['image_url'] as String,
          'name': item['name'] as String,
          'description': item['description'] as String,
        }),
      );

      print('Fetched data: $result'); // Check the data structure

      emit(DalilyLoaded(result)); // Emit the data as a single state
    } catch (e) {
      emit(DalilyError("Failed to load data: $e"));
    }
  }

}
