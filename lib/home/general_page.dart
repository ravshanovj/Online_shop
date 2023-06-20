import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grow_fast_app/home/profile_page.dart';
import 'package:grow_fast_app/style/style.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';
import 'package:proste_indexed_stack/proste_indexed_stack.dart';

import 'card_page.dart';
import 'favorite_page.dart';
import 'product_page.dart';

Route generatePage(child) {
  return MaterialPageRoute(builder: (context) => child);
}

class GeneralPage extends StatefulWidget {
  const GeneralPage({super.key});

  @override
  State<GeneralPage> createState() => _GeneralPageState();
}

class _GeneralPageState extends State<GeneralPage> {
  int selectedIndex = 0;
  List<IndexedStackChild> Pages = [
    IndexedStackChild(child: const ProductPage()),
    IndexedStackChild(child: const CartPage()),
    // IndexedStackChild(child: const PersonsPage()),
    IndexedStackChild(child: const FavoritesPage()),
    IndexedStackChild(child: const ProfilePage()),
  ];
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: Color(0xffF1F4F3),
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
          body: ProsteIndexedStack(
            index: selectedIndex,
            children: Pages,
          ),
          bottomNavigationBar: WaterDropNavBar(
            waterDropColor: Style.colorOfPrice,
            inactiveIconColor: Colors.grey,
            backgroundColor: const Color(0xffF1F4F3),
            onItemSelected: (value) {
              selectedIndex = value;
              setState(() {});
            },
            selectedIndex: selectedIndex,
            barItems: [
              BarItem(
                  filledIcon: Icons.home, outlinedIcon: Icons.home_outlined),
              BarItem(
                  filledIcon: Icons.shopping_cart_checkout_outlined,
                  outlinedIcon: Icons.shopping_cart_checkout),
              // BarItem(
              //     filledIcon: Icons.group, outlinedIcon: Icons.group_outlined),
              BarItem(
                  filledIcon: Icons.favorite,
                  outlinedIcon: Icons.favorite_outline),
              BarItem(
                  filledIcon: Icons.person, outlinedIcon: Icons.person_outline),
            ],
          )),
    );
  }
}
