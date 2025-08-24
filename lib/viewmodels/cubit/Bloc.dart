import 'package:Tourism_app/viewmodels/cubit/states.dart';
import 'package:Tourism_app/views/Screens/FavoriteScreen.dart';
import 'package:Tourism_app/views/Screens/SettingScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/Item/Item.dart';
import '../../views/Screens/HomePage.dart';
import '../../views/Screens/MedicalScreen.dart';
import '../../views/Screens/dataUploadPage.dart';

class DalilyCubit extends Cubit<DalilyState> {
  DalilyCubit() : super(DalilyInitialState());

  static DalilyCubit get(context) => BlocProvider.of<DalilyCubit>(context);

  int currentIndex = 0;
  late PageController pageController;

  final List<Widget> bottomScreens = [
    AccountScreen(),
    AddCategoryPage(),
    FavoriteScreen(),
    HomePage(),
  ];

  final activeIcons = [
    'assets/icons/user1.svg',
    'assets/icons/shopping-bag-svgrepo-com (1).svg',
    'assets/icons/bookmark1.svg',
    'assets/icons/home1.svg',
  ];

  final inactiveIcons = [
    'assets/icons/user.svg',
    'assets/icons/shopping-bag-svgrepo-com.svg',
    'assets/icons/bookmark.svg',
    'assets/icons/home.svg',
  ];

  void changeTab(int index) {
    currentIndex = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    emit(AppChangeTabState());
  }

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(DalilyBottomnavBarState());
  }

  final List<String> imageUrls = [
    "assets/Image/images.jpg",
    "assets/Image/3d-illustration-togo-coffee-ads-600nw-1794918400.webp",
    "assets/Image/medical-healthcare-clinic-banner-square-flyer-social-media-post-template_680306-214.avif",
 ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(DalilyChangeIndexState());
  }

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
                  DalilyCubit()..fetchCategoryData('test'), // اسم الجدول
              child: const MedicalScreen(
                tableName: 'test',
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
                  DalilyCubit()..fetchCategoryData('Cafes'), // اسم الجدول
              child: const MedicalScreen(
                tableName: 'Cafes',
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

  Future<void> fetchCategoryData(String tableName, {String? query}) async {
    try {
      emit(CategoryLoadingState());

      var request = Supabase.instance.client.from(tableName).select(
        'name, description, imageUrl, facebookLink, youtypeLink, whatsAppLink, locationLink, phoneLink, location, number',
      );

      // فلترة بالـ query لو فيه قيمة
      if (query != null && query.isNotEmpty) {
        request = request.ilike('name', '%$query%');
      }

      final response = await request;

      if (response.isEmpty) {
        emit(CategoryError('No data found for table "$tableName".'));
        return;
      }

      final List<Category> categories = response.map<Category>((item) {
        return Category(
          id: 0, // لأنك مش جايب الـ id من الجدول
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
  Future<void> fetchAllCategoriesData(List<String> tableNames, {String? query}) async {
    try {
      emit(CategoryLoadingState());

      List<Category> allCategories = [];

      for (String tableName in tableNames) {
        var request = Supabase.instance.client.from(tableName).select(
          'name, description, imageUrl, facebookLink, youtypeLink, whatsAppLink, locationLink, phoneLink, location, number',
        );

        // فلترة بالـ query لو فيه قيمة
        if (query != null && query.isNotEmpty) {
          request = request.ilike('name', '%$query%');
        }

        final response = await request;

        if (response.isNotEmpty) {
          final List<Category> categories = response.map<Category>((item) {
            return Category(
              id: 0, // مفيش id هنا زي ما قولنا
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

          allCategories.addAll(categories);
        }
      }

      if (allCategories.isEmpty) {
        emit(CategoryError('No data found in any table.'));
        return;
      }

      emit(CategoryLoaded(allCategories));
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
}
