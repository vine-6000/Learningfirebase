import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Center(
      child: Text('Welcome to the Homepage!',
      style: GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),),
    ),
    );
  }
}