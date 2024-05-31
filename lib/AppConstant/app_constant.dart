import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/////////////////---------------Colors---------------/////////
const Color kColorWhite = Color.fromRGBO(255, 255, 255, 1);
const Color kColorWhite248 = Color.fromRGBO(248, 249, 253, 1);
const Color kColorWhite37 = Color.fromRGBO(237, 244, 254, 1);

const Color kColorBlack = Color.fromRGBO(0, 0, 0, 1);

const Color kColorPrimary = Color.fromRGBO(72, 144, 246, 1);
const Color kColorPrimary2 = Color.fromRGBO(72, 144, 246, 0.1);
const Color kColorPrimary3 = Color.fromRGBO(238, 239, 243, 1);
const Color kColorPrimary4 = Color.fromRGBO(69, 145, 247, 1);

const Color kColorLightYellow = Color.fromRGBO(255, 221, 134, 1);
const Color kColorGrey = Color.fromRGBO(59, 64, 84, 1);
const Color kColorGrey124 = Color.fromRGBO(124, 139, 160, 1);
const Color kColorGrey97 = Color.fromRGBO(97, 103, 125, 1);
const Color kColorGrey145 = Color.fromRGBO(145, 145, 145, 1);
const Color kColorRed = Color.fromRGBO(255, 87, 87, 1);

///////////////----------------Fonts----------------//////////
TextStyle kStyleBlack32600 = GoogleFonts.poppins(
  fontSize: 32.sp,
  color: kColorBlack,
  fontWeight: FontWeight.w600,
);
TextStyle kStyleBlack14400 = GoogleFonts.poppins(
  fontSize: 14.sp,
  color: kColorBlack,
  fontWeight: FontWeight.w400,
);
TextStyle kStyleBlack22600 = GoogleFonts.poppins(
  fontSize: 22.sp,
  color: kColorBlack,
  fontWeight: FontWeight.w600,
);
TextStyle kStyleBlack14700 = GoogleFonts.poppins(
  fontSize: 14.sp,
  color: kColorBlack,
  fontWeight: FontWeight.w700,
);
TextStyle kStyleBlack16400 = GoogleFonts.poppins(
  fontSize: 16.sp,
  color: kColorBlack,
  fontWeight: FontWeight.w400,
);
TextStyle kStyleBlack12600 = GoogleFonts.poppins(
  fontSize: 12.sp,
  color: kColorBlack,
  fontWeight: FontWeight.w600,
);
TextStyle kStyleBlack11500 = GoogleFonts.poppins(
  fontSize: 11.sp,
  color: kColorBlack,
  fontWeight: FontWeight.w500,
);
TextStyle kStyleBlack12500 = GoogleFonts.poppins(
  fontSize: 12.sp,
  color: kColorBlack,
  fontWeight: FontWeight.w500,
);
TextStyle kStyleBlack10500 = GoogleFonts.poppins(
  fontSize: 10.sp,
  color: kColorBlack,
  fontWeight: FontWeight.w500,
);

TextStyle kStyleBlack16500 = GoogleFonts.poppins(
  fontSize: 16.sp,
  color: kColorBlack,
  fontWeight: FontWeight.w500,
);
TextStyle kStyleBlack17500 = GoogleFonts.poppins(
  fontSize: 17.sp,
  color: kColorBlack,
  fontWeight: FontWeight.w500,
);
TextStyle kStyleBlack20600 = GoogleFonts.poppins(
  fontSize: 20.sp,
  color: kColorBlack,
  fontWeight: FontWeight.w600,
);
TextStyle kStyleBlack16700 = GoogleFonts.poppins(
  fontSize: 16.sp,
  color: kColorBlack,
  fontWeight: FontWeight.w700,
);
TextStyle kStyleBlack13400 = GoogleFonts.poppins(
  fontSize: 13.sp,
  color: kColorBlack,
  fontWeight: FontWeight.w400,
);
TextStyle kStyleBlack13500 = GoogleFonts.poppins(
  fontSize: 13.sp,
  color: kColorBlack,
  fontWeight: FontWeight.w500,
);
TextStyle kStyleBlack13700 = GoogleFonts.poppins(
  fontSize: 13.sp,
  color: kColorBlack,
  fontWeight: FontWeight.w700,
);
TextStyle kStyleWhite16600 = GoogleFonts.poppins(
  fontSize: 16.sp,
  color: kColorWhite248,
  fontWeight: FontWeight.w600,
);
TextStyle kStyleWhite16500 = GoogleFonts.poppins(
  fontSize: 16.sp,
  color: kColorWhite248,
  fontWeight: FontWeight.w500,
);
TextStyle kStyleWhite11500 = GoogleFonts.poppins(
  fontSize: 11.sp,
  color: kColorWhite,
  fontWeight: FontWeight.w500,
);
TextStyle kStyleWhite14700 = GoogleFonts.poppins(
  fontSize: 14.sp,
  color: kColorWhite,
  fontWeight: FontWeight.w700,
);
TextStyle kStyleWhite12500 = GoogleFonts.poppins(
  fontSize: 12.sp,
  color: kColorWhite,
  fontWeight: FontWeight.w500,
);
TextStyle kStyleWhite10500 = GoogleFonts.poppins(
  fontSize: 10.sp,
  color: kColorWhite,
  fontWeight: FontWeight.w500,
);
TextStyle kStyleWhite22600 = GoogleFonts.poppins(
  fontSize: 22.sp,
  color: kColorWhite,
  fontWeight: FontWeight.w600,
);
TextStyle kStyleWhite17500 = GoogleFonts.poppins(
  fontSize: 17.sp,
  color: kColorWhite,
  fontWeight: FontWeight.w500,
);
TextStyle kStyleGrey16400 = GoogleFonts.poppins(
  fontSize: 16.sp,
  color: kColorGrey124,
  fontWeight: FontWeight.w400,
);
TextStyle kStyleGrey14400 = GoogleFonts.poppins(
  fontSize: 14.sp,
  color: kColorGrey97,
  fontWeight: FontWeight.w400,
);
TextStyle kStyleGrey10500 = GoogleFonts.poppins(
  fontSize: 10.sp,
  color: kColorGrey145,
  fontWeight: FontWeight.w500,
);
TextStyle kStyleGrey9700 = GoogleFonts.mulish(
  fontSize: 9.3.sp,
  color: kColorGrey145,
  fontWeight: FontWeight.w700,
);
TextStyle kStyleGrey11400 = GoogleFonts.mulish(
  fontSize: 11.sp,
  color: kColorGrey145,
  fontWeight: FontWeight.w400,
);
TextStyle kStyleGrey12400 = GoogleFonts.mulish(
  fontSize: 12.sp,
  color: kColorGrey145,
  fontWeight: FontWeight.w400,
);
TextStyle kStyleGrey12400_2 = GoogleFonts.mulish(
  fontSize: 12.sp,
  color: kColorGrey124,
  fontWeight: FontWeight.w400,
);
TextStyle kStylePrimary10700 = GoogleFonts.poppins(
  fontSize: 10.sp,
  color: kColorPrimary,
  fontWeight: FontWeight.w700,
);
TextStyle kStylePrimary11500 = GoogleFonts.poppins(
  fontSize: 11.sp,
  color: kColorPrimary,
  fontWeight: FontWeight.w500,
);
TextStyle kStylePrimary37700 = GoogleFonts.poppins(
  fontSize: 37.6.sp,
  color: kColorPrimary,
  fontWeight: FontWeight.w700,
);
TextStyle kStylePrimary18700 = GoogleFonts.poppins(
  fontSize: 18.sp,
  color: kColorPrimary,
  fontWeight: FontWeight.w700,
);
TextStyle kStylePrimary41600 = GoogleFonts.poppins(
  fontSize: 41.75.sp,
  color: kColorPrimary,
  fontWeight: FontWeight.w600,
);
TextStyle kStyleRed12400 = GoogleFonts.poppins(
  fontSize: 12.sp,
  color: kColorRed,
  fontWeight: FontWeight.w400,
);
TextStyle kStyleLightYellow11500 = GoogleFonts.poppins(
  fontSize: 11.sp,
  color: kColorLightYellow,
  fontWeight: FontWeight.w500,
);
TextStyle kStyleRed11500 = GoogleFonts.poppins(
  fontSize: 11.sp,
  color: kColorRed,
  fontWeight: FontWeight.w500,
);

/////////////////-----------------AirBnbTextStyle-----------------////////////
TextStyle kStyleBlack14500 = TextStyle(
  fontFamily: 'AirbnbCereal',
  fontSize: 14.sp,
  color: kColorBlack,
  fontWeight: FontWeight.w500,
);
TextStyle kStyleWhite14500 = TextStyle(
  fontFamily: 'AirbnbCereal',
  fontSize: 14.sp,
  color: kColorWhite,
  fontWeight: FontWeight.w500,
);