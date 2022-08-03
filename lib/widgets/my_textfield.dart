import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget MyTextField(String hintext,keyboardType,controller,Color color){
  return Container(
    height: 50.h,
    width: ScreenUtil().screenWidth,
    decoration: BoxDecoration(
      color: Colors.white
    ),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
          hintText: hintext,hintStyle: TextStyle(color: color)

      ),
      keyboardType: keyboardType,
    ),
  );
}