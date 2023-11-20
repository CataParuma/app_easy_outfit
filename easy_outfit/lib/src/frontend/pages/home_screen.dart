import 'package:easy_outfit/src/frontend/pages/login.dart';
import 'package:easy_outfit/src/frontend/pages/signup.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/inicio.png',
              height: 300,
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyAppForm()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF2F3E44),
                fixedSize: Size(300, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                "Iniciar Sesión",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUp()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFC7D8D9),
                fixedSize: Size(300, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                "Crear Cuenta",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  color: Color(0xFF2F3E44),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
