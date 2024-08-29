import 'dart:async';

import 'package:flutter/material.dart';
import 'package:phantomscanbliss/screens/bottom_bar/bottom_navigationbar_screen.dart';
import 'package:phantomscanbliss/screens/login_screen.dart';
import 'package:phantomscanbliss/shared_prefs/shared_prefs.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      // Check if the widget is still mounted before navigating
      if (mounted) {
        SpUtil.getInt(SpConstUtil.userID) == 0
            ? Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              )
            : Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const BottomNavigationbarScreen(),
              ));
        // Navigator.of(context).pushReplacement(
        //   MaterialPageRoute(
        //     builder: (context) => const BottomNavigationbarScreen(),
        //   ),
        // );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/png/app_icon.png"),
      ),
    );
  }
}
