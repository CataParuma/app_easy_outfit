import 'package:easy_outfit/src/backend/controllers/cloth_controller.dart';
import 'package:easy_outfit/src/backend/models/product.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShirtScreen extends StatefulWidget {
  final ClothController clothController;
  const ShirtScreen({super.key, required this.clothController});

  @override
  _ShirtScreenState createState() =>
      _ShirtScreenState(clothController: clothController);
}

class _ShirtScreenState extends State<ShirtScreen> {
  final int currentCategory = 0;
  final ClothController clothController;
  _ShirtScreenState({required this.clothController});
  // Lista de Camisas
  final List<Product> shirts = [
    Product(
      id: ValueKey(1),
      tipo: 'Camisa',
      estilo: 'Estilo A',
      color: 'Blanco',
      image: 'assets/c_blanco.png',
    ),
    Product(
      id: ValueKey(2),
      tipo: 'Camisa',
      estilo: 'Estilo B',
      color: 'Negro',
      image: 'assets/c_negro.png',
    ),
    Product(
      id: ValueKey(3),
      tipo: 'Camisa',
      estilo: 'Estilo C',
      color: 'Azul',
      image: 'assets/c_azul.png',
    ),
    Product(
      id: ValueKey(4),
      tipo: 'Camisa',
      estilo: 'Estilo D',
      color: 'Rojo',
      image: 'assets/c_rojo.png',
    ),
    Product(
      id: ValueKey(5),
      tipo: 'Camisa',
      estilo: 'Estilo E',
      color: 'Verde',
      image: 'assets/c_verde.png',
    ),
    Product(
      id: ValueKey(6),
      tipo: 'Camisa',
      estilo: 'Estilo F',
      color: 'Mostaza',
      image: 'assets/c_mostaza.png',
    ),
  ];

  // Función para agregar una camisa al armario
  Future<void> _addToCloset(Product shirt) async {
    await clothController.createCloth(
        currentCategory, shirt.estilo, shirt.color, shirt.image);
    Navigator.pop(context);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF477372),
        title: Text(
          "Selecciona el Estilo de la Camisa:",
          style: GoogleFonts.poppins(
            fontSize: 20,
          ),
        ),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: shirts.length,
        itemBuilder: (context, index) {
          final shirt = shirts[index];
          return GestureDetector(
            // Accion de tocar el boton
            onTap: () async {
              await _addToCloset(shirt);
            },
            child: Card(
              child: Column(
                children: [
                  Image.asset(
                    shirt.image,
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 8.0),
                  Text('${shirt.color} - ${shirt.estilo}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
