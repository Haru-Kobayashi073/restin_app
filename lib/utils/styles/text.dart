import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:search_roof_top_app/utils/utils.dart';

class AppTextStyle {
  AppTextStyle._();

  static const authPageTitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const mapTypeModalTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static const mapTypeModalOption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );

  static const createMarkerTextFieldLabel = TextStyle(
    fontSize: 16,
    color: ColorName.deepGrey,
  );

  static const saveMarkerText = TextStyle(
    fontSize: 16,
  );

  static const commonButtonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: ColorName.white,
  );

  static const commonButtonYellow = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: ColorName.amber,
  );

  static const profilePageUserName = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );

  static const profilePageUserValue = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static const profilePageUserKey = TextStyle(
    fontSize: 16,
  );

  static const markerListTiltle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );

  static const markerListDescription = TextStyle(
    fontSize: 12,
  );

  static const commentUserName = TextStyle(
    fontSize: 16,
  );

  static const commentCreatedAt = TextStyle(
    fontSize: 12,
  );

  static const greyText = TextStyle(
    color: ColorName.darkGrey,
  );

  static const bold = TextStyle(
    fontWeight: FontWeight.bold,
  );

  static const underline = TextStyle(
    color: ColorName.black,
    decoration: TextDecoration.underline,
  );

  static const largeGrey = TextStyle(
    fontSize: 24,
    color: ColorName.darkGrey,
  );

  static TextStyle mPlusFont = TextStyle(
    fontSize: 16,
    fontFamily: GoogleFonts.mPlusRounded1c().fontFamily,
  );

  static TextStyle largePoppinFont = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    fontFamily: GoogleFonts.poppins().fontFamily,
  );
}
