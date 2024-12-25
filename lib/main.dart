import 'package:Tourism_app/viewmodels/%D9%8BWedget.dart';
import 'package:Tourism_app/views/Home%20Veiw.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'models/cubit/Bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://xbnwowviustkamjpcqkh.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inhibndvd3ZpdXN0a2FtanBjcWtoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzQ5NjQwNjIsImV4cCI6MjA1MDU0MDA2Mn0.zkE_4tRR8DXJ3y0sft21d3aHrbT-iQaXEklQTqxKrPw',
  );
  runApp(
    BlocProvider<DalilyCubit>(
      create: (_) => DalilyCubit(),
      child: MyApp(),  // هذا هو التطبيق الرئيسي
    ),
  );}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: HomeView(),
    );
  }
}
