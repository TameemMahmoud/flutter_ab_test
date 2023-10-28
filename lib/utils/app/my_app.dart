
import 'package:flutter/material.dart';

import '../../view/add_screen/add_screen.dart';
import '../../view/edit_screen/edit_screen.dart';
import '../../view/home_screen/home_screen.dart';
import '../../view/landing_screen/land_screen.dart';
import '../helper/hive_helper.dart';
import '../resources/theme_controller.dart';

var navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'AB',
      debugShowCheckedModeBanner: false,
      theme: Styles.themeData(HiveHelper.getMood(), context),
      // home: const LandScreen(),
      home: HiveHelper.getUserEmail() == '' ? const LandScreen() : const HomeScreen(),
      routes: {
        HomeScreen.routeName: (ctx) => const HomeScreen(),
        AddScreen.routeName: (ctx) => AddScreen(),
        EditScreen.routeName: (ctx) => EditScreen(),
      },
    );
  }
}
