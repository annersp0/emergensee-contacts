import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart'; 
import 'login.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyCgK2lZHSOvwNqjCGBcJOqC2CdRYbPqGrM",
      projectId: "emergensee-66a54",
      messagingSenderId: "1006748418",
      appId: "1:1006748418:android:2f5ad89397fae5e2c1381b",
    ),
  );

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      theme: Provider.of<ThemeProvider>(context).currentTheme, 
      builder: (context, child) {
        return child!;
      },
    );
  }
}
