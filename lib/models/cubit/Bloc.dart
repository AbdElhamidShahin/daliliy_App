import 'package:Tourism_app/models/cubit/states.dart';
import 'package:Tourism_app/views/FavoriteScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../viewmodels/HomePage.dart';
import '../../views/Screens/MedicalScreen.dart';
import '../../views/Screens/dataUploadPage.dart';
import '../Item/Item.dart';

class DalilyCubit extends Cubit<DalilyState> {
  DalilyCubit() : super(DalilyInitialState());

  static DalilyCubit get(context) => BlocProvider.of<DalilyCubit>(context);

  int currentIndex = 0;

  List<Widget> screens = [
    HomePage(),
    FavoriteScreen(),
    AddCategoryPage(),
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
      'urlImage': 'assets/New folder/1.png',
      'name': 'الصيداليات',
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (_) =>
                  DalilyCubit()..fetchCategoryData('pharmacies'), // اسم الجدول
              child: const MedicalScreen(
                tableName: 'pharmacies',
                screenTitle: 'الصيداليات',
              ), // اسم الجدول
            ),
          ),
        );
      },
    },
    {
      'urlImage': 'assets/New folder/2.jpg',
      'name': 'المعامل',
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (_) =>
                  DalilyCubit()..fetchCategoryData('المعامل'), // اسم الجدول
              child: const MedicalScreen(
                tableName: 'المعامل',
                screenTitle: 'المعامل',
              ), // اسم الجدول
            ),
          ),
        );
      },
    },
    {
      'urlImage': 'assets/New folder/3.png',
      'name': 'أطفال',
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (_) =>
                  DalilyCubit()..fetchCategoryData('أطفال'), // اسم الجدول
              child: const MedicalScreen(
                tableName: 'أطفال',
                screenTitle: 'أطفال',
              ), // اسم الجدول
            ),
          ),
        );
      },
    },
    {
      'urlImage': 'assets/New folder/4.png',
      'name': 'أسنان ',
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (_) =>
                  DalilyCubit()..fetchCategoryData('test'), // اسم الجدول
              child: const MedicalScreen(
                tableName: 'category',
                screenTitle: 'أسنان',
              ), // اسم الجدول
            ),
          ),
        );
      },
    },
    {
      'urlImage': 'assets/New folder/5.png',
      'name': 'عظام ',
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (_) =>
                  DalilyCubit()..fetchCategoryData('test'), // اسم الجدول
              child: const MedicalScreen(
                tableName: 'category',
                screenTitle: 'عظام',
              ), // اسم الجدول
            ),
          ),
        );
      },
    },
    {
      'urlImage': 'assets/New folder/6.jpg',
      'name': 'أشعه ',
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (_) =>
                  DalilyCubit()..fetchCategoryData('test'), // اسم الجدول
              child: const MedicalScreen(
                tableName: 'category',
                screenTitle: 'أشعه',
              ), // اسم الجدول
            ),
          ),
        );
      },
    },
    {
      'urlImage': 'assets/New folder/7.jpg',
      'name': 'جلديه ',
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (_) =>
                  DalilyCubit()..fetchCategoryData('test'), // اسم الجدول
              child: const MedicalScreen(
                tableName: 'category',
                screenTitle: 'جلديه',
              ), // اسم الجدول
            ),
          ),
        );
      },
    },
    {
      'urlImage': 'assets/New folder/8.jpg',
      'name': 'قلب  ',
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (_) =>
                  DalilyCubit()..fetchCategoryData('test'), // اسم الجدول
              child: const MedicalScreen(
                tableName: 'category',
                screenTitle: 'قلب',
              ), // اسم الجدول
            ),
          ),
        );
      },
    },
    {
      'urlImage': 'assets/New folder/9.jpg',
      'name': 'سكر ',
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (_) =>
                  DalilyCubit()..fetchCategoryData('test'), // اسم الجدول
              child: const MedicalScreen(
                tableName: 'category',
                screenTitle: 'سكر',
              ), // اسم الجدول
            ),
          ),
        );
      },
    },
    {
      'urlImage': 'assets/New folder/10.avif',
      'name': 'علاج طبيعي ',
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (_) =>
                  DalilyCubit()..fetchCategoryData('test'), // اسم الجدول
              child: const MedicalScreen(
                tableName: 'category',
                screenTitle: 'علاج طبيعي ',
              ), // اسم الجدول
            ),
          ),
        );
      },
    },
  ];
  final List<Map<String, dynamic>> items2 = [
    {
      'urlImage': 'assets/New folder (2)/1.png',
      'name': ' مطاعم ',
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (_) =>
                  DalilyCubit()..fetchCategoryData('test'), // اسم الجدول
              child: const MedicalScreen(
                tableName: 'category',
                screenTitle: 'مطاعم',
              ), // اسم الجدول
            ),
          ),
        );
      },
    },
    {
      'urlImage': 'assets/New folder (2)/2.png',
      'name': 'كافيهات',
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (_) =>
                  DalilyCubit()..fetchCategoryData('test'), // اسم الجدول
              child: const MedicalScreen(
                tableName: 'category',
                screenTitle: 'كافيهات',
              ), // اسم الجدول
            ),
          ),
        );
      },
    },
    {
      'urlImage': 'assets/New folder (2)/3.jpg',
      'name': 'بقاله',
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (_) =>
                  DalilyCubit()..fetchCategoryData('test'), // اسم الجدول
              child: const MedicalScreen(
                tableName: 'category',
                screenTitle: 'بقاله',
              ), // اسم الجدول
            ),
          ),
        );
      },
    },
    {
      'urlImage': 'assets/New folder (2)/4.png',
      'name': 'عطاره',
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (_) =>
                  DalilyCubit()..fetchCategoryData('test'), // اسم الجدول
              child: const MedicalScreen(
                tableName: 'category',
                screenTitle: 'عطاره',
              ), // اسم الجدول
            ),
          ),
        );
      },
    },
    {
      'urlImage': 'assets/New folder (2)/5.jpg',
      'name': 'خضار وفاكه',
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (_) =>
                  DalilyCubit()..fetchCategoryData('test'), // اسم الجدول
              child: const MedicalScreen(
                tableName: 'category',
                screenTitle: 'خضار وفاكه',
              ), // اسم الجدول
            ),
          ),
        );
      },
    },
    {
      'urlImage': 'assets/New folder (2)/6.jpg',
      'name': 'حلويات ومخابز',
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (_) =>
                  DalilyCubit()..fetchCategoryData('test'), // اسم الجدول
              child: const MedicalScreen(
                tableName: 'category',
                screenTitle: 'حلويات ومخابز',
              ), // اسم الجدول
            ),
          ),
        );
      },
    },
    {
      'urlImage': 'assets/New folder (2)/7.jpg',
      'name': 'مقالي وتسالي',
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (_) =>
                  DalilyCubit()..fetchCategoryData('test'), // اسم الجدول
              child: const MedicalScreen(
                tableName: 'category',
                screenTitle: 'مقالي وتسالي',
              ), // اسم الجدول
            ),
          ),
        );
      },
    },
  ];
  final List<Map<String, dynamic>> items3 = [
    {
      'urlImage': 'assets/New folder (3)/1.png',
      'name': 'اجهزه الكترونيه',
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (_) =>
                  DalilyCubit()..fetchCategoryData('test'), // اسم الجدول
              child: const MedicalScreen(
                tableName: 'category',
                screenTitle: 'اجهزه الكترونيه',
              ), // اسم الجدول
            ),
          ),
        );
      },
    },
    {
      'urlImage': 'assets/New folder (3)/2.png',
      'name': 'أجهزه منزليه',
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (_) =>
                  DalilyCubit()..fetchCategoryData('test'), // اسم الجدول
              child: const MedicalScreen(
                tableName: 'category',
                screenTitle: 'أجهزه منزليه',
              ), // اسم الجدول
            ),
          ),
        );
      },
    },
    {
      'urlImage': 'assets/New folder (3)/3.jpg',
      'name': ' مؤن و بويات',
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (_) =>
                  DalilyCubit()..fetchCategoryData('test'), // اسم الجدول
              child: const MedicalScreen(
                tableName: 'category',
                screenTitle: ' مؤن و بويات',
              ), // اسم الجدول
            ),
          ),
        );
      },
    },
    {
      'urlImage': 'assets/New folder (3)/4.png',
      'name': 'محلات حلاقه',
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (_) =>
                  DalilyCubit()..fetchCategoryData('test'), // اسم الجدول
              child: const MedicalScreen(
                tableName: 'category',
                screenTitle: 'محلات حلاقه',
              ), // اسم الجدول
            ),
          ),
        );
      },
    },
  ];

  Future<void> fetchCategoryData(String tableName) async {
    try {
      emit(CategoryLoadingState());

      final response = await Supabase.instance.client.from(tableName).select(
          'name, description, imageUrl,facebookLink,youtypeLink,whatsAppLink,locationLink,phoneLink,location,number');

      if (response.isEmpty) {
        emit(CategoryError('No data found for table "$tableName".'));
        return;
      }

      final List<Category> categories = response.map((item) {
        return Category(
          id: (item['id'] ?? 1) as int, // استخدم 0 أو أي قيمة افتراضية رقمية
          name: item['name'] ?? 'No Name',
          description: item['description'] ?? 'No Description',
          imageUrl: item['imageUrl'] ?? '',
          facebookLink: item['facebookLink'] ?? '',
          youtypeLink: item['youtypeLink'] ?? '',
          whatsAppLink: item['whatsAppLink'] ?? '',
          locationLink: item['locationLink'] ?? '',
          phoneLink: item['phoneLink'] ?? '',
          location: item['location'] ?? '',
          number: item['number'] ?? '',
        );
      }).toList();

      emit(CategoryLoaded(categories));
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }
  double _currentUserRating = 2.0;
  List<double> _allRatings = [];
  bool isFavorite = false;

  double get currentRating => _currentUserRating;

  double get averageRating => _allRatings.isNotEmpty
      ? _allRatings.reduce((a, b) => a + b) / _allRatings.length
      : 0.0;

  int get ratingCount => _allRatings.length;

  Future<void> updateRating(double newRating) async {
    _currentUserRating = newRating;
    _allRatings.add(newRating);
    await saveRatings();
    emit(UpdateRatingState(averageRating, ratingCount));
  }

  Future<void> saveRatings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      'user_ratings',
      _allRatings.map((r) => r.toString()).toList(),
    );
  }

  Future<void> loadInitialData() async {
    final prefs = await SharedPreferences.getInstance();
    final savedRatings = prefs.getStringList('user_ratings') ?? [];
    _allRatings = savedRatings.map((r) => double.tryParse(r) ?? 0.0).toList();
    emit(UpdateRatingState(averageRating, ratingCount));
  }

  void toggleFavorite() {
    isFavorite = !isFavorite;
    emit(UpdateFavoriteState(isFavorite));
  }


  void updateFavoriteState(bool newState) {
    isFavorite = newState;
    emit(UpdateFavoriteState(isFavorite));
    print(isFavorite);
  }
}
