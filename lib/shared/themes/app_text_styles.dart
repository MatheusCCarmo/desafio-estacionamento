import 'package:estacionamento/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static final titleRegular = GoogleFonts.sourceSansPro(
    fontSize: 26,
    fontWeight: FontWeight.w600,
    color: AppColors.heading,
  );
  static final titleRegularWhite = GoogleFonts.sourceSansPro(
    fontSize: 26,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );
  static final bodyRegular = GoogleFonts.sourceSansPro(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.heading,
  );
  static final bodyRegularWhite = GoogleFonts.sourceSansPro(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );
  static final buttonRegular = GoogleFonts.sourceSansPro(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.heading,
  );
  static final buttonRegularWhite = GoogleFonts.sourceSansPro(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );
}
