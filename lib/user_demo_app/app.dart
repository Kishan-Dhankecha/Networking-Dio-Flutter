import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

class UserDemoApp extends StatelessWidget {
  const UserDemoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Networking with Dio - Flutter',
      theme: ThemeData(primarySwatch: Colors.teal),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
