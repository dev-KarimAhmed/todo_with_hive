import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    this.suffixIcon,
    required this.data,
    this.isReadOnly,
  });
  final TextEditingController controller;
  final Widget? suffixIcon;
  final String data;
  final bool? isReadOnly;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data,
          style: GoogleFonts.lato(),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'This field is required';
            }
            return null;
          },
          readOnly: isReadOnly ?? true,
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
            suffixIcon: suffixIcon,
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
