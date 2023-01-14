import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hotelbooking/UI/B1_Home/B1_Home_Screen/B1_Home_Screen.dart';
import 'package:hotelbooking/UI/B2_Message/B2_MessageScreen.dart';
import 'package:hotelbooking/UI/B3_Trips/B3_TripScreen.dart';
import 'package:hotelbooking/UI/B4_Favorite/B4_FavoriteScreen.dart';
import 'package:hotelbooking/UI/B5_Profile/B5_ProfileScreen.dart';
import 'custom_nav_bar.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;
  bool _color = true;
  Widget callPage(int current) {
    switch (current) {
      case 0:
        return new Home();
        break;
      case 1:
        return new noMessage();
        break;
      case 3:
        return const FavoriteScreen();
        break;
      case 4:
        return new profile();
        break;
      default:
        return new Home();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: callPage(currentIndex),
      bottomNavigationBar: BottomNavigationDotBar(
          color: Colors.black26,
          items: <BottomNavigationDotBarItem>[
            BottomNavigationDotBarItem(
                icon: const IconData(0xe900, fontFamily: 'home'),
                onTap: () {
                  setState(() {
                    currentIndex = 0;
                  });
                }),
            BottomNavigationDotBarItem(
                icon: const IconData(0xe900, fontFamily: 'message'),
                onTap: () {
                  setState(() {
                    currentIndex = 1;
                  });
                }),
            BottomNavigationDotBarItem(
                icon: const IconData(
                  0xe900,
                  fontFamily: 'hearth',
                ),
                onTap: () {
                  setState(() {
                    currentIndex = 3;
                  });
                }),
            BottomNavigationDotBarItem(
                icon: const IconData(0xe900, fontFamily: 'profile'),
                onTap: () {
                  setState(() {
                    currentIndex = 4;
                  });
                }),
          ]),
    );
  }
}
