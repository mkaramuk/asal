import 'dart:io';

import 'package:asal/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  EasyLoading.instance.userInteractions = false;

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    windowManager.setTitle("Asal");
    windowManager.setMaximumSize(const Size(300, 700));
  }

  runApp(const AsalApp());
}

class AsalApp extends StatelessWidget {
  const AsalApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Asal',
      routes: routes,
      debugShowCheckedModeBanner: false,
      initialRoute: '/homepage',
      builder: EasyLoading.init(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
