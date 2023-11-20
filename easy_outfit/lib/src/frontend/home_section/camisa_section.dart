import 'package:flutter/material.dart';

class CamisaSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecciona una camisa:'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildImage('assets/clima.png', 150),
              buildImage('assets/clima.png', 150),
            ],
          ),

          SizedBox(height: 16),
 
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildImage('assets/clima.png', 150),
              buildImage('assets/clima.png', 150),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildImage(String imagePath, double size) {
    return Container(
      margin: EdgeInsets.all(30),
      child: Image.asset(
        imagePath,
        width: size,
        height: size,
      ),
    );
  }
}