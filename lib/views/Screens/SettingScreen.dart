import 'dart:io';
<<<<<<< HEAD
import 'package:Tourism_app/views/Screens/Login/frontPage.dart';
import 'package:Tourism_app/views/Screens/FavoriteScreen.dart';
=======
>>>>>>> origin/main
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/LocalStorageAccount.dart.dart';
import '../../utils/ThemeProvider.dart';
import '../../utils/app_colors.dart';
import 'EditAccountScreen.dart';
import '../Wedget/settings/CustomItemSettings.dart';
import 'FavoriteScreen.dart';
import 'frontPage.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String? name, phone, email, image;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    Map<String, String?> userData = await UserDataManager.loadUserData();
    setState(() {
      name = userData['name'];
      email = userData['email'];
      phone = userData['phone'];
      image = userData['imagePath'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final containerColor = isDarkMode ? Color(0xFF1E1E1E) : Colors.black.withOpacity(0.06);

    return Scaffold(
      backgroundColor: isDarkMode ? Color(0xFF121212) : Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: isDarkMode ? Color(0xFF1E1E1E) : Colors.white,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'حسابي',
              style: TextStyle(
                  color: textColor,
                  fontSize: 28,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
<<<<<<< HEAD
                  borderRadius: BorderRadius.circular(24),
                  color: containerColor,
                ),
=======
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.black.withOpacity(0.06)),
>>>>>>> origin/main
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: image != null && File(image!).existsSync()
                            ? Image.file(
                          File(image!),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        )
                            : Image.network(
                          'https://img.freepik.com/premium-vector/avatar-business-women-vector-illustration-flat-2_764382-57434.jpg',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${name ?? 'Abdo Shahin'}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: textColor,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "${email ?? 'abdoshahin@gmail.com'}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: isDarkMode ? Colors.grey[400] : Colors.black45,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: IconButton(
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => EditAccountScreen()),
                          );
                          if (result == true) {
                            await loadUserData();
                          }
                        },
                        icon: Icon(
                          Icons.edit,
                          color: isDarkMode ? Colors.white : Colors.black87,
                          size: 32,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
<<<<<<< HEAD
            Padding(
              padding: const EdgeInsets.only(right: 24, left: 24, bottom: 16),
=======
            const Padding(
              padding: EdgeInsets.only(
                right: 24,
                left: 24,
                bottom: 16,
              ),
>>>>>>> origin/main
              child: Text(
                'الاعدادات',
                style: TextStyle(
                    color: textColor,
                    fontSize: 28,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
<<<<<<< HEAD
                  borderRadius: BorderRadius.circular(24),
                  color: containerColor,
                ),
=======
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.black.withOpacity(0.06)),
>>>>>>> origin/main
                child: Column(
                  children: [
                    CustomItemSetteings(
                      'المفضله',
<<<<<<< HEAD
                          () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FavoriteScreen()),
                        );
                      },
                      Icons.favorite_border_outlined,
                      isDarkMode,
                    ),
                    CustomItemSetteings(
                      'الاشعارات',
                          () {},
                      Icons.notifications_none_outlined,
                      isDarkMode,
                    ),
                    CustomItemSetteings(
                      'اللغات',
                          () {},
                      Icons.language,
                      isDarkMode,
                    ),
                    CustomItemSetteings(
                      'تغيير كلمه المرور',
                          () {},
                      Icons.lock_reset,
                      isDarkMode
                    ,
                    ),
                    CustomItemSetteings(
                      'تسجيل الخروج',
                          () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FrontScreen()),
                        );
                      },
                      Icons.logout_rounded,
                      isDarkMode,
                    ),
                    // Card(
                    //   color: isDarkMode ? Color(0xFF1E1E1E) : Colors.white,
                    //   margin: const EdgeInsets.symmetric(vertical: 12),
                    //   elevation: 0,
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(16),
                    //   ),
                    //   child: ListTile(
                    //     contentPadding: const EdgeInsets.symmetric(
                    //       horizontal: 8,
                    //       vertical: 12,
                    //     ),
                    //     leading: Container(
                    //       height: 34,
                    //       width: 34,
                    //       decoration: BoxDecoration(
                    //         color: colorV.withOpacity(0.1),
                    //         borderRadius: BorderRadius.circular(20),
                    //       ),
                    //       child: Icon(
                    //         isDarkMode ? Icons.nightlight_round : Icons.wb_sunny,
                    //         color: colorV,
                    //         size: 22,
                    //       ),
                    //     ),
                    //     title: Text(
                    //       isDarkMode ? 'الوضع الليلي' : 'الوضع النهاري',
                    //       style: TextStyle(
                    //         fontFamily: 'Cairo',
                    //         fontSize: 20,
                    //         fontWeight: FontWeight.w600,
                    //         color: textColor,
                    //       ),
                    //     ),
                    //     trailing: Switch(
                    //       value: isDarkMode,
                    //       onChanged: (value) {
                    //         themeProvider.toggleTheme();
                    //       },
                    //       activeColor: colorV,
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(height: 24),
=======
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FavoriteScreen()),
                        );
                      },
                      Icons.favorite_border_outlined,
                    ),
                    CustomItemSetteings(
                      'الاشعارات',
                      () {},
                      Icons.notifications_none_outlined,
                    ),
                    CustomItemSetteings(
                      'اللغات',
                      () {},
                      Icons.language,
                    ),
                    CustomItemSetteings(
                      'تغيير كلمه المرور', () {},
                      Icons.lock_reset, // هنا حددت اللون
                      // لون يتكيف مع السمة
                    ),
                    CustomItemSetteings(
                      'تسجيل الخروج',
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FrontScreen()),
                        );
                      },
                      Icons.logout_rounded,
                    ),
                    SizedBox(
                      height: 24,
                    )
>>>>>>> origin/main
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}