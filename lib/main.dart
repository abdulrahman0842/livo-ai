import 'package:flutter/material.dart';
import 'package:livoai/view/splash_screen.dart';
import 'package:livoai/view/maunal_entry/entry_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => EntryViewModel())],
      child: MaterialApp(
          title: 'Livo AI',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            appBarTheme: AppBarTheme(
                backgroundColor: Colors.teal, foregroundColor: Colors.white),
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
            useMaterial3: true,
          ),
          home: SplashScreen()),
    );
  }
}
