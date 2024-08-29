import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phantomscanbliss/screens/cart_screen.dart';
import 'package:phantomscanbliss/screens/category_screen.dart';
import 'package:phantomscanbliss/screens/home_screen.dart';
import 'package:phantomscanbliss/screens/profile_screen.dart';
import 'package:phantomscanbliss/urils/colors.dart';

class BottomNavigationbarScreen extends StatefulWidget {
  const BottomNavigationbarScreen({super.key});

  @override
  State<BottomNavigationbarScreen> createState() =>
      _BottomNavigationbarScreenState();
}

class _BottomNavigationbarScreenState extends State<BottomNavigationbarScreen> {
  List bottomImagesList = [
    "assets/svg/home.svg",
    "assets/svg/category.svg",
    "assets/svg/cart.svg",
    "assets/svg/user.svg",
  ];
  int _currentIndex = 0;
  List screen = [
    const HomeScreen(),
    const CategoryScreen(),
    const CartScreen(),
    const ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[_currentIndex],
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (int i = 0; i < bottomImagesList.length; i++)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentIndex = i;
                    });
                  },
                  child: SvgPicture.asset(
                    bottomImagesList[i],
                    color: _currentIndex == i
                        ? colors.browncolor
                        : Colors.black.withOpacity(0.3),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
