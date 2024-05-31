import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../AppConstant/app_constant.dart';

class CustomContainer extends StatelessWidget {
  final String imagePath;
  const CustomContainer({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 90.w,
        height: 90.h,
        decoration: BoxDecoration(
          color: kColorWhite37,
          borderRadius: BorderRadius.circular(25.r),
        ),
        child: Center(
          child: Image.asset(imagePath, width: 70.w, height: 70.h),
        ));
  }
}