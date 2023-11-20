import 'package:easy_outfit/src/backend/controllers/cloth_controller.dart';
import 'package:easy_outfit/src/backend/models/product.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShoeScreen extends StatefulWidget {
  final ClothController clothController;
  const ShoeScreen({Key? key, required this.clothController}) : super(key: key);

  @override
  _ShoeScreenState createState() => _ShoeScreenState(clothController: clothController);
}

class _ShoeScreenState extends State<ShoeScreen> {
  final int currentCategory = 2; // Cambiar a la categoría correcta para zapatos
  final ClothController clothController;
  _ShoeScreenState({required this.clothController});

  // Lista de Zapatos
  final List<Product> shoes = [
    Product(
      id: ValueKey(13),
      tipo: 'Zapato',
      estilo: 'Estilo A',
      color: 'Blanco',
      image: 'assets/z_blanco.png',
    ),
    Product(
      id: ValueKey(14),
      tipo: 'Zapato',
      estilo: 'Estilo B',
      color: 'Negro',
      image: 'assets/z_negro.png',
    ),
    Product(
      id: ValueKey(15),
      tipo: 'Zapato',
      estilo: 'Estilo C',
      color: 'Azul',
      image: 'assets/z_azul.png',
    ),
    Product(
      id: ValueKey(16),
      tipo: 'Zapato',
      estilo: 'Estilo D',
      color: 'Rojo',
      image: 'assets/z_rojo.png',
    ),
     Product(
      id: ValueKey(17),
      tipo: 'Zapato',
      estilo: 'Estilo E',
      color: 'Verde',
      image: 'assets/z_verde.png',
    ),
     Product(
      id: ValueKey(18),
      tipo: 'Zapato',
      estilo: 'Estilo F',
      color: 'Mostaza',
      image: 'assets/z_mostaza.png',
    ),
  ];

  // Función para agregar un zapato al armario
  Future<void> _addToCloset(Product shoe) async {
    await clothController.createCloth(currentCategory, shoe.estilo, shoe.color, shoe.image);
    Navigator.pop(context);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF477372),
        title: Text(
          "Selecciona el Estilo del Zapato:",
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
        itemCount: shoes.length,
        itemBuilder: (context, index) {
          final shoe = shoes[index];
          return GestureDetector(
            onTap: () async {
              await _addToCloset(shoe);
            },
            child: Card(
              child: Column(
                children: [
                  Image.asset(
                    shoe.image,
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 8.0),
                  Text('${shoe.color} - ${shoe.estilo}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}