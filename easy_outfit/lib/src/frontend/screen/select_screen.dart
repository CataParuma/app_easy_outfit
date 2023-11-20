import 'package:easy_outfit/src/backend/controllers/cloth_controller.dart';
import 'package:easy_outfit/src/frontend/screen/pant_screen.dart';
import 'package:easy_outfit/src/frontend/screen/shirt_screen.dart';
import 'package:easy_outfit/src/frontend/screen/shoe_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectScreen extends StatelessWidget {
  final ClothController clothController;
  const SelectScreen({Key? key, required this.clothController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF477372),
        title: Text(
          "Selecciona el tipo de Prenda:",
          style: GoogleFonts.poppins(
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShirtScreen(
                        clothController: clothController,
                      ),
                    ),
                  );
                },
                child: Image.asset(
                  'assets/c_button.png',
                  height: 170,
                  width: 170,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PantScreen(
                        clothController: clothController,
                      ),
                    ),
                  );
                },
                child: Image.asset(
                  'assets/p_button.png',
                  height: 170,
                  width: 170,
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShoeScreen(
                    clothController: clothController,
                  ),
                ),
              );
            },
            child: Image.asset(
              'assets/z_button.png',
              height: 170,
              width: 170,
            ),
          ),
        ],
      ),
    );
  }
}