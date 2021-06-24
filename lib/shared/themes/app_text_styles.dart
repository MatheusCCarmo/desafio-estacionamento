import 'package:estacionamento/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static final titleRegular = GoogleFonts.sourceSansPro(
    fontWeight: FontWeight.w600,
    color: AppColors.heading,
  );
  static final titleRegularWhite = GoogleFonts.sourceSansPro(
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );
}
