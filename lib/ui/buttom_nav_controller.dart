import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/const/app_colors.dart';
import 'package:flutter_ecommerce/ui/bottom_nav_pages/add_to_cart.dart';
import 'package:flutter_ecommerce/ui/bottom_nav_pages/favorite_page.dart';
import 'package:flutter_ecommerce/ui/bottom_nav_pages/home_page.dart';
import 'package:flutter_ecommerce/ui/bottom_nav_pages/profile_page.dart';
import 'package:flutter_ecommerce/widgets/reuseable_text.dart';

class ButtomNavController extends StatefulWidget {
  const ButtomNavController({Key? key}) : super(key: key);

  @override
  State<ButtomNavController> createState() => _ButtomNavControllerState();
}

class _ButtomNavControllerState extends State<ButtomNavController> {

  late int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final _pages=[const HomePage(),const FavoritePage(),const AddToCart(),ProfilePage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screen_color,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title:ReuseableText("E-Commerce", 25, Colors.white, FontWeight.normal) ,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add),
            label: 'Profile',
            backgroundColor: Colors.red,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
      body: _pages[_selectedIndex],
    );
  }
}
