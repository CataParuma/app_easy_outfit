import 'package:easy_outfit/src/backend/controllers/cloth_controller.dart';
import 'package:easy_outfit/src/frontend/home_section/pant_section.dart';
import 'package:easy_outfit/src/backend/models/cloth_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShirtSecction extends StatefulWidget {
  String user;
  final int weekday;
  final int weekyear;
  ShirtSecction({super.key, required this.user, required this.weekday, required this.weekyear});

  @override
  _ShirtSecctionState createState() => _ShirtSecctionState(user: user, weekday: weekday, weekyear: weekyear);
}

class _ShirtSecctionState extends State<ShirtSecction>
    with SingleTickerProviderStateMixin {
  final String user;
  final int weekday;
  final int weekyear;
  _ShirtSecctionState({required this.user, required this.weekday, required this.weekyear});

  late TabController _tabController;
  final ClothController _clothController = ClothController();

  // Índice de la categoría seleccionada
  int selectedCategoryIndex = 0;

  @override
  void initState() {
    super.initState();
    // Inicializa un controlador de pestañas con la cantidad de pestañas igual al número de categorías
    _tabController =
        TabController(length: _clothController.categories.length, vsync: this);
    _clothController.setUsername(user);
    debugPrint(_clothController.username);

    // Agrega un listener al controlador de pestañas para actualizar el índice de la categoría seleccionada al cambiar de pestaña
    _tabController.addListener(() {
      setState(() {
        selectedCategoryIndex = _tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF477372),
        title: Text(
          "1. Selecciona una Camisa",
          style: GoogleFonts.poppins(
            fontSize: 20,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: _clothController.getClothesByType(selectedCategoryIndex),
            builder:
                (BuildContext context, AsyncSnapshot<List<Cloth>> snapshot) {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemCount: snapshot.data?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PantSection(user: _clothController.username, idShirt: snapshot.data![index].id?? -1, weekday: weekday, weekyear: weekyear,),
                            ),
                          );
                        },

                        child: Card(
                          child: Column(
                            children: [
                              Image.asset(
                                snapshot.data![index].image,
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(height: 8.0),
                              
                              Text(
                                'Último uso: ${snapshot.data![index].getDaysFromLastUsed()}',
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 100, 30, 100),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/img1.png',
                              height: 200,
                            ),
                            SizedBox(height: 20),
                            Text(
                              "No hay prendas en tu armario",
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  

}