import 'dart:io';
import 'package:Tourism_app/views/Screens/frontPage.dart';
import 'package:Tourism_app/views/Screens/FavoriteScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/LocalStorageAccount.dart.dart';
import '../../utils/app_colors.dart';
import 'EditAccountScreen.dart';
import '../Wedget/settings/CustomItemSettings.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({
    super.key,
  });

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
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'حسابي',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.black.withOpacity(0.1)),
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
                          Text("${name ?? 'Abdo Shahin'}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black)),
                          const SizedBox(
                            height: 6,
                          ),
                          Text("${email ?? 'abdoshahin@gmail.com'}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black45)),
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
                              MaterialPageRoute(
                                  builder: (context) => EditAccountScreen()),
                            );
                            if (result == true) {
                              await loadUserData();
                            }
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.black87,
                            size: 32,
                          )),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.black12),
                child: Column(
                  children: [

                    CustomItemSetteings('المفضله', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FavoriteScreen()),
                      );
                    }, Icons.favorite, Colors.red),
                    CustomItemSetteings('الاشعارات', () {},
                        Icons.notifications, Colors.yellowAccent),
                    CustomItemSetteings('اللغات', () {},
                        Icons.language, Colors.blue),
                    CustomItemSetteings('تغيير كلمه المرور', () {},
                        Icons.lock_reset,  Colors.blue, // هنا حددت اللون
                      // لون يتكيف مع السمة
                    ),
                    CustomItemSetteings('تسجيل الخروج', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FrontScreen()),
                      );
                    }, Icons.login, Colors.black),
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
