import 'package:asal/router/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Asal',
      routes: routes,
      debugShowCheckedModeBanner: false,
      initialRoute: '/homepage',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
