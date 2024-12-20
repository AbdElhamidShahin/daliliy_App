import 'package:Tourism_app/models/cubit/states.dart';
import 'package:Tourism_app/viewmodels/%D9%8BWedget.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DalilyCubit extends Cubit<DalilyState> {
  DalilyCubit() : super(DalilyInitialState());

  static DalilyCubit get(context) => BlocProvider.of<DalilyCubit>(context);

  int currentIndex = 0;

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
  final List<Map<String, String>> items = [
    {
      'urlImage':
      'https://i.pinimg.com/736x/be/b0/0e/beb00e4a420438fc0cdfa3d280e4662a.jpg',
      'name': 'Item 1'
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
    },  {
      'urlImage':
      'https://i.pinimg.com/736x/be/b0/0e/beb00e4a420438fc0cdfa3d280e4662a.jpg',
      'name': 'Item 3'
    },  {
      'urlImage':
      'https://i.pinimg.com/736x/be/b0/0e/beb00e4a420438fc0cdfa3d280e4662a.jpg',
      'name': 'Item 3'
    },  {
      'urlImage':
      'https://i.pinimg.com/736x/be/b0/0e/beb00e4a420438fc0cdfa3d280e4662a.jpg',
      'name': 'Item 3'
    },  {
      'urlImage':
      'https://i.pinimg.com/736x/be/b0/0e/beb00e4a420438fc0cdfa3d280e4662a.jpg',
      'name': 'Item 3'
    },  {
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
    },  {
      'urlImage':
      'https://i.pinimg.com/736x/93/62/67/936267364e11eb8ced548fda3b62b31b.jpg',
      'name': 'Item 3'
    },  {
      'urlImage':
      'https://i.pinimg.com/736x/93/62/67/936267364e11eb8ced548fda3b62b31b.jpg',
      'name': 'Item 3'
    },  {
      'urlImage':
      'https://i.pinimg.com/736x/93/62/67/936267364e11eb8ced548fda3b62b31b.jpg',
      'name': 'Item 3'
    },  {
      'urlImage':
      'https://i.pinimg.com/736x/93/62/67/936267364e11eb8ced548fda3b62b31b.jpg',
      'name': 'Item 3'
    },  {
      'urlImage':
      'https://i.pinimg.com/736x/93/62/67/936267364e11eb8ced548fda3b62b31b.jpg',
      'name': 'Item 3'
    },
  ];


}
