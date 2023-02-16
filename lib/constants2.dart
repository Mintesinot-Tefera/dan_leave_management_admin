import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle kLoginTitleStyle(Size size) => GoogleFonts.ubuntu(
      fontSize: size.height * 0.050,
      fontWeight: FontWeight.bold,
    );
TextStyle kAddEmployeeTitleStyle(Size size) => GoogleFonts.ubuntu(
    fontSize: size.height * 0.050,
    fontWeight: FontWeight.bold,
    color: Colors.black);

TextStyle kLoginSubtitleStyle(Size size) => GoogleFonts.ubuntu(
      fontSize: size.height * 0.030,
    );
TextStyle kAddEmployeeSubtitleStyle(Size size) =>
    GoogleFonts.ubuntu(fontSize: size.height * 0.030, color: Colors.black);

TextStyle kLoginTermsAndPrivacyStyle(Size size) =>
    GoogleFonts.ubuntu(fontSize: 15, color: Colors.grey, height: 1.5);

TextStyle kHaveAnAccountStyle(Size size) =>
    GoogleFonts.ubuntu(fontSize: size.height * 0.022, color: Colors.black);

TextStyle kLoginOrSignUpTextStyle(
  Size size,
) =>
    GoogleFonts.ubuntu(
      fontSize: size.height * 0.022,
      fontWeight: FontWeight.w500,
      color: Colors.deepPurpleAccent,
    );

TextStyle kTextFormFieldStyle() => const TextStyle(color: Colors.white);
TextStyle kTextFormFieldStyle2() => const TextStyle(color: Colors.black);
