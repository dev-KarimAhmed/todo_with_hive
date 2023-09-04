import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key, required this.data, this.onTap,
  });
  final String data;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: 120,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: kPrimaryColor,
        ),
        child: Text(data, style: GoogleFonts.lato()),
      ),
    );
  }
}
