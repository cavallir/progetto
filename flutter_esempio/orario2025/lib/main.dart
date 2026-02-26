import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'pages/login.dart';
import 'utilities/globals.dart';

void main() => runApp(const MyApp(),);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent)
    );
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green).copyWith(secondary: Colors.green),
      ),
      title: Globals.appTitle,
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}