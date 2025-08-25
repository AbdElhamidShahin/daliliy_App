import 'package:Tourism_app/utils/ThemeProvider.dart';
import 'package:Tourism_app/utils/app_colors.dart';
import 'package:Tourism_app/viewmodels/cubit/Bloc.dart';
import 'package:Tourism_app/views/Screens/Home%20Veiw.dart';
import 'package:Tourism_app/views/Screens/Login/frontPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'viewmodels/ItemProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://svguqpavelimqbxmzgpl.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InN2Z3VxcGF2ZWxpbXFieG16Z3BsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDcwNjg1MzgsImV4cCI6MjA2MjY0NDUzOH0.nN-SS7I47cdHmlJFpsyolJmceSWgXZQHLZM4tlBRMAQ',
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ItemProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: BlocProvider<DalilyCubit>(
        create: (_) => DalilyCubit()..loadInitialData(),
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      darkTheme: ThemeData(
        fontFamily: 'Cairo',
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121B22),
      ),
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Cairo',
        brightness: Brightness.light,
        scaffoldBackgroundColor: backgroundColor(context),
        appBarTheme: const AppBarTheme(
          color: colorV,
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,

      // ✅ هنا التغيير
      home: FirebaseAuth.instance.currentUser == null
          ? const FrontScreen() // لو مفيش مستخدم -> روح لتسجيل الدخول
          : HomeView(), // لو فيه مستخدم -> روح عالهوم
    );
  }
}
