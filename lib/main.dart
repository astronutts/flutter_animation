import 'package:flutter/material.dart';

import 'menu_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutte Animation Master Class',
        theme: ThemeData(
          colorScheme: const ColorScheme.light(
            primary: Colors.red,
          ),
          useMaterial3: true,
        ),
        home: const MenuScreen());
  }
}
