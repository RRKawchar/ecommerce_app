import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget MyTextFormField(keyboradType,controller) {
  return Container(
    height: 50.h,
    width: ScreenUtil().screenWidth,
    decoration: const BoxDecoration(
        color: Colors.white
    ),
    child: TextFormField(
      controller: controller,
      decoration: const InputDecoration(

      ),
      keyboardType: keyboradType,
    ),
  );
}