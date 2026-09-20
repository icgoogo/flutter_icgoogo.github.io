import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icgoogo/ui/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'icgoogo',
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.fuchsia: CupertinoPageTransitionsBuilder(),
          },
        ),
        primarySwatch: Colors.blue,
        fontFamily: "PressStart2P",
      ),
      home: const MainScreen(),
    );
  }
}
