import 'package:Tourism_app/models/cubit/states.dart';
import 'package:Tourism_app/viewmodels/%D9%8BWedget.dart';
import 'package:Tourism_app/views/FavoriteScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../views/Screens/.0.dart';
import '../../views/Screens/MedicalScreen.dart';
import '../../views/SettingScreen.dart';
import '../Item.dart';

class DalilyCubit extends Cubit<DalilyState> {
  DalilyCubit() : super(DalilyInitialState());

  static DalilyCubit get(context) => BlocProvider.of<DalilyCubit>(context);

  int currentIndex = 0;

  List<Widget> screens = [
    Wedget(),
    FavoriteScreen(),
    ImageAndDataUploadPage(),
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
      'urlImage': 'assets/Catogry1/9233795_4116139.jpg',
      'name': 'الصيداليات',
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (_) =>
                  DalilyCubit()..fetchCategoryData('task'), // اسم الجدول
              child:const MedicalScreen(tableName: 'task'), // اسم الجدول
            ),
          ),
        );
      },
    },
    {
      'urlImage': 'assets/Catogry1/rb_51672.png',
      'name': 'المعامل ',
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (_) =>
                  DalilyCubit()..fetchCategoryData('test'), // اسم الجدول
              child:const MedicalScreen(tableName: 'test'), // اسم الجدول
            ),
          ),
        );
      },
    },
    {
      'urlImage': 'assets/Catogry1/24237740_6911014.jpg',
      'name': 'أطفال ',
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (_) =>
                  DalilyCubit()..fetchCategoryData('test'), // اسم الجدول
              child:const MedicalScreen(tableName: 'test'), // اسم الجدول
            ),
          ),
        );
      },
    },
    {
      'urlImage': 'assets/Catogry1/rb_103308.png',
      'name': 'أسنان ',
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (_) =>
                  DalilyCubit()..fetchCategoryData('test'), // اسم الجدول
              child:const MedicalScreen(tableName: 'test'), // اسم الجدول
            ),
          ),
        );
      },
    },
    {
      'urlImage': 'assets/Catogry1/18329494_5964859.jpg',
      'name': 'عظام ',
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (_) =>
                  DalilyCubit()..fetchCategoryData('test'), // اسم الجدول
              child:const MedicalScreen(tableName: 'test'), // اسم الجدول
            ),
          ),
        );
      },
    },
    {
      'urlImage': 'assets/Catogry1/26232793_7206784.jpg',
      'name': 'أشعه ',
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (_) =>
                  DalilyCubit()..fetchCategoryData('test'), // اسم الجدول
              child:const MedicalScreen(tableName: 'test'), // اسم الجدول
            ),
          ),
        );
      },
    },
    {
      'urlImage':
          'assets/Catogry1/flat-style-character-design_839035-1824362.jpg',
      'name': 'جلديه ',
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (_) =>
                  DalilyCubit()..fetchCategoryData('test'), // اسم الجدول
              child:const MedicalScreen(tableName: 'test'), // اسم الجدول
            ),
          ),
        );
      },
    },
    {
      'urlImage': 'assets/Catogry1/rb_6987.png',
      'name': 'قلب  ',
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (_) =>
                  DalilyCubit()..fetchCategoryData('test'), // اسم الجدول
              child:const MedicalScreen(tableName: 'test'), // اسم الجدول
            ),
          ),
        );
      },
    },
    {
      'urlImage': 'assets/Catogry1/rb_2150836985.png',
      'name': 'سكر ',
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (_) =>
                  DalilyCubit()..fetchCategoryData('test'), // اسم الجدول
              child:const MedicalScreen(tableName: 'test'), // اسم الجدول
            ),
          ),
        );
      },
    },
    {
      'urlImage':
          'assets/Catogry1/caucasian-white-physiotherapist-doctor-checking-260nw-1054540445.webp',
      'name': 'علاج طبيعي ',
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (_) =>
                  DalilyCubit()..fetchCategoryData('test'), // اسم الجدول
              child:const MedicalScreen(tableName: 'test'), // اسم الجدول
            ),
          ),
        );
      },
    },
  ];
  final List<Map<String, dynamic>> items2 = [
    {
      'urlImage': 'assets/Catogry2/3967199_2053509.jpg',
      'name': ' المطاعم ',
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (_) =>
                  DalilyCubit()..fetchCategoryData('test'), // اسم الجدول
              child:const MedicalScreen(tableName: 'test'), // اسم الجدول
            ),
          ),
        );
      },
    },
    {
      'urlImage': 'assets/Catogry2/22730235_6688503.jpg',
      'name': 'الكافيهات',
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (_) =>
                  DalilyCubit()..fetchCategoryData('test'), // اسم الجدول
              child:const MedicalScreen(tableName: 'test'), // اسم الجدول
            ),
          ),
        );
      },
    },
    {
      'urlImage': 'assets/Catogry2/3797919_9984.jpg',
      'name': 'محلات البقاله',
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (_) =>
                  DalilyCubit()..fetchCategoryData('test'), // اسم الجدول
              child: const MedicalScreen(tableName: 'test'), // اسم الجدول
            ),
          ),
        );
      },
    },
    {
      'urlImage': 'assets/Catogry2/download.jpeg',
      'name': 'محلات العطاره',
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (_) =>
                  DalilyCubit()..fetchCategoryData('test'), // اسم الجدول
              child:const MedicalScreen(tableName: 'test'), // اسم الجدول
            ),
          ),
        );
      },
    },
    {
      'urlImage':
          'assets/Catogry2/cartoon-color-supermarket-vegetables-and-fruits-vector-30335720.jpg',
      'name': '  محلات الخضار والفاكه',
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (_) =>
                  DalilyCubit()..fetchCategoryData('test'), // اسم الجدول
              child: const MedicalScreen(tableName: 'test'), // اسم الجدول
            ),
          ),
        );
      },
    },
    {
      'urlImage': 'assets/Catogry2/images (1).jpeg',
      'name': 'محلات الحلويات والمخابز',
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (_) =>
                  DalilyCubit()..fetchCategoryData('test'), // اسم الجدول
              child:const MedicalScreen(tableName: 'test'), // اسم الجدول
            ),
          ),
        );
      },
    },
    {
      'urlImage': 'assets/Catogry2/لب-و-سوداني.png',
      'name': 'مقالي وتسالي',
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (_) =>
                  DalilyCubit()..fetchCategoryData('test'), // اسم الجدول
              child: const MedicalScreen(tableName: 'test'), // اسم الجدول
            ),
          ),
        );
      },
    },
  ];
  final List<Map<String, dynamic>> items3 = [
    {
      'urlImage': 'assets/Catogry3/settings.png',
      'name': 'الاجهزه الالكترونيه',
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (_) =>
                  DalilyCubit()..fetchCategoryData('test'), // اسم الجدول
              child:const MedicalScreen(tableName: 'test'), // اسم الجدول
            ),
          ),
        );
      },
    },
    {
      'urlImage': 'assets/Catogry3/home-appliance.png',
      'name': 'الأجهزه المنزليه',
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (_) =>
                  DalilyCubit()..fetchCategoryData('test'), // اسم الجدول
              child:const MedicalScreen(tableName: 'test'), // اسم الجدول
            ),
          ),
        );
      },
    },
    {
      'urlImage':
          'assets/Catogry3/construction-worker-holding-drill-hammer-hand-professional-builder-with-work-tool-character-figure-cartoon-illustration-white-background_201904-310.avif',
      'name': ' المؤن البويات',
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (_) =>
                  DalilyCubit()..fetchCategoryData('test'), // اسم الجدول
              child:const MedicalScreen(tableName: 'test'), // اسم الجدول
            ),
          ),
        );
      },
    },
    {
      'urlImage': 'assets/Catogry3/barbershop.png',
      'name': 'محلات الحلاقه',
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (_) =>
                  DalilyCubit()..fetchCategoryData('test'), // اسم الجدول
              child:const MedicalScreen(tableName: 'test'), // اسم الجدول
            ),
          ),
        );
      },
    },
  ];

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

  double rating = 2;
  void  RatingState(double newRating) {
    rating = newRating;

    emit(UpdateRatingState(rating));
  }

  bool isFavorite = false;

  void updateFavoriteState(bool newState) {
    isFavorite = newState;
    emit(UpdateFavoriteState(isFavorite));
    print(isFavorite);
  }


}
