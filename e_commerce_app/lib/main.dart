import 'package:e_commerce_app/stateprovider.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/homescreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xffe6f1f1),
        useMaterial3: true,
      ),
      home: ChangeNotifierProvider(
          create: (_) => stateProvider(), child: MyHomePage(title: 'TecnoBiz')),
    );
  }
}
