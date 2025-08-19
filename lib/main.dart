import 'package:Dalily_App_Owner/utils/app_colors.dart';
import 'package:Dalily_App_Owner/viewmodels/cubit/Bloc.dart' show DalilyCubit;
import 'package:Dalily_App_Owner/views/Screens/Home%20Veiw.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'viewmodels/ItemProvider.dart';

void main() async {
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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Cairo',

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
