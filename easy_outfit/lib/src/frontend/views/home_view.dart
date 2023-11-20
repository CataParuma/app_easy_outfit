import 'package:easy_outfit/src/frontend/home_section/clima_section.dart';
import 'package:easy_outfit/src/frontend/home_section/crono_section.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {

  String user;
  HomeView({super.key, required this.user});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF578382),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 20,
              child: Icon(
                Icons.person,
                color: Color(0xFF578382),
                size: 30,
              ),
            ),
            SizedBox(width: 20),
            Text(
              'Bienvenido a Easy Outfit',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ), // Texto
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        color: Color(0xFFC6D8D8), 
        child: Column(
          children: [
            SizedBox(height: 30),
            ClimaSection(),
            SizedBox(height: 30),
            CronoSection(user: user,),
          ],
        ),
      ),
    );
  }
}