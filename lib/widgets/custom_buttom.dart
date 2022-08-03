import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/const/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget CustomButton(String text,onPressed){
  return SizedBox(
    width: 1.sw,
    height: 56.h,
    child: ElevatedButton(
      onPressed:onPressed,
      style: ElevatedButton.styleFrom(
        primary: AppColors.screen_color,
        elevation: 3,
      ),
      child:Text(text,
        style:TextStyle(
            color: Colors.white, fontSize: 18.sp),
      ),
    ),

  );
}