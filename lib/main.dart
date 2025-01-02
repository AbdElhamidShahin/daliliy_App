import 'package:Tourism_app/core/constants/color.dart';
import 'package:Tourism_app/viewmodels/%D9%8BWedget.dart';
import 'package:Tourism_app/views/Home%20Veiw.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/services.dart';

import 'models/Item.dart';
import 'models/cubit/Bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://xbnwowviustkamjpcqkh.supabase.co',
    anonKey:
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inhibndvd3ZpdXN0a2FtanBjcWtoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzQ5NjQwNjIsImV4cCI6MjA1MDU0MDA2Mn0.zkE_4tRR8DXJ3y0sft21d3aHrbT-iQaXEklQTqxKrPw',
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ItemProvider()), // FavoriteProvider
      ],
      child: BlocProvider<DalilyCubit>(
        create: (_) => DalilyCubit(),
        child: MyApp(), // Main app widget
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // تخصيص شريط الحالة
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.red, // تغيير لون شريط الحالة
      statusBarIconBrightness: Brightness.light, // لون الأيقونات في الشريط
    ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: colorV,
        ),
        scaffoldBackgroundColor: colorV,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: HomeView(),
    );
  }
}
