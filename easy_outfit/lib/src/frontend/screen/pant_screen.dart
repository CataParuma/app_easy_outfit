import 'package:easy_outfit/src/backend/controllers/cloth_controller.dart';
import 'package:easy_outfit/src/backend/models/product.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PantScreen extends StatefulWidget {
  final ClothController clothController;
  const PantScreen({Key? key, required this.clothController}) : super(key: key);

  @override
  _PantScreenState createState() => _PantScreenState(clothController: clothController);
}

class _PantScreenState extends State<PantScreen> {
  final int currentCategory = 1;
  final ClothController clothController;
  _PantScreenState({required this.clothController});

  // Lista de Pantalones
  final List<Product> pants = [
    Product(
      id: ValueKey(7),
      tipo: 'Pantalón',
      estilo: 'Estilo A',
      color: 'Blanco',
      image: 'assets/p_blanco.png',
    ),
    Product(
      id: ValueKey(8),
      tipo: 'Pantalón',
      estilo: 'Estilo B',
      color: 'Negro',
      image: 'assets/p_negro.png',
    ),
    Product(
      id: ValueKey(9),
      tipo: 'Pantalón',
      estilo: 'Estilo C',
      color: 'Azul',
      image: 'assets/p_azul.png',
    ),
    Product(
      id: ValueKey(10),
      tipo: 'Pantalón',
      estilo: 'Estilo D',
      color: 'Rojo',
      image: 'assets/p_rojo.png',
    ),
    Product(
      id: ValueKey(11),
      tipo: 'Pantalón',
      estilo: 'Estilo E',
      color: 'Verde',
      image: 'assets/p_verde.png',
    ),
    Product(
      id: ValueKey(12),
      tipo: 'Pantalón',
      estilo: 'Estilo F',
      color: 'Mostaza',
      image: 'assets/p_mostaza.png',
    ),
  ];

  // Función para agregar un pantalón al armario
  Future<void> _addToCloset(Product pant) async {
    await clothController.createCloth(currentCategory, pant.estilo, pant.color, pant.image);
    Navigator.pop(context);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF477372),
        title: Text(
          "Selecciona el Estilo de los Pantalones:",
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
        itemCount: pants.length,
        itemBuilder: (context, index) {
          final pant = pants[index];
          return GestureDetector(
            onTap: () async {
              await _addToCloset(pant);
            },
            child: Card(
              child: Column(
                children: [
                  Image.asset(
                    pant.image,
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 8.0),
                  Text('${pant.color} - ${pant.estilo}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}