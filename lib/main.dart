import 'package:flutter/material.dart';
import 'package:icgoogo/ui/main_screen.dart';
import 'package:icgoogo/ui/middle_screen/projects_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'icgoogo',
      initialRoute: '/',
      routes: {
        //  '/': (context) => const MainScreen(),
        '/projects': (context) => const ProjectsScreen(),
      },
      theme: ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.fuchsia: CupertinoPageTransitionsBuilder(),
        }),
        primarySwatch: Colors.blue,
        fontFamily: "PressStart2P",
      ),
      home: const MainScreen(),
    );
  }
}
