import 'dart:io';
import 'package:flutter/material.dart';
import '../../services/LocalStorageAccount.dart.dart';
import 'EditAccountScreen.dart';
import '../Wedget/settings/CustomItemSettings.dart';
import 'FavoriteScreen.dart';
import 'frontPage.dart';

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
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
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
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.black.withOpacity(0.06)),
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
            const Padding(
              padding: EdgeInsets.only(
                right: 24,
                left: 24,
                bottom: 16,
              ),
              child: Text(
                'الاعدادات',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.black.withOpacity(0.06)),
                child: Column(
                  children: [
                    CustomItemSetteings(
                      'المفضله',
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
