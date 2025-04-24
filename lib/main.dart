import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:liver_app/firebase_options.dart';
import 'package:liver_app/view_model/entry_view_model.dart';
import 'package:provider/provider.dart';
import 'view/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => EntryViewModel())],
      child: MaterialApp(
        title: 'Liver App',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal)),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
