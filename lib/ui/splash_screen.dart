import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/const/animated_colors.dart';
import 'package:flutter_ecommerce/const/app_colors.dart';
import 'package:flutter_ecommerce/ui/login_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {



  static const colorizeColors = [
    Colors.white,
    Colors.blue,
    Colors.purple,
    Colors.red,
  ];

  static const colorizeTextStyle = TextStyle(
    fontSize: 44.0,
    fontWeight: FontWeight.bold,
    fontFamily: 'Horizon',
  );
  @override
  void initState() {
    Timer(const Duration(seconds: 5), () { Navigator.push(context, CupertinoPageRoute(builder: (_)=>const LoginScreen()));});
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: AppColors.screen_color,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedColors(),
              SizedBox(height: 12.h,),
             const CircularProgressIndicator()
            ],
          ),
        ),
      ),
    );
  }
}
