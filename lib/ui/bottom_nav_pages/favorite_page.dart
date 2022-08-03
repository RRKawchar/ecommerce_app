import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/const/app_colors.dart';
import 'package:flutter_ecommerce/widgets/fetchProducts.dart';



class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screen_color,
      body:SafeArea(
        child: fetchData("users-favorite-items")
      )
    );
  }
}
