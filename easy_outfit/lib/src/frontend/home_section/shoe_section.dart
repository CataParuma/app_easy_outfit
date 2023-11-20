import 'package:easy_outfit/src/backend/controllers/cloth_controller.dart';
import 'package:easy_outfit/src/backend/controllers/outfit_controller.dart';
import 'package:easy_outfit/src/backend/controllers/utilities.dart';
import 'package:easy_outfit/src/backend/models/cloth_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShoeSection extends StatefulWidget {
  String user;
  final int idShirt;
  final int idPants;
  final int weekday;
  final int weekyear;
  ShoeSection({super.key, required this.user, required this.idShirt, required this.idPants, required this.weekday, required this.weekyear});

  @override
  _ShoeSectionState createState() => _ShoeSectionState(user: user, idShirt: idShirt, idPants: idPants, weekday:weekday, weekyear: weekyear);
}

class _ShoeSectionState extends State<ShoeSection>
    with SingleTickerProviderStateMixin {
  final String user;
  final int idShirt;
  final int idPants;
  final int weekday;
  final int weekyear;
  _ShoeSectionState({required this.user, required this.idShirt, required this.idPants, required this.weekday, required this.weekyear});

  late TabController _tabController;
  final ClothController _clothController = ClothController();
  final OutfitController _outfitController = OutfitController();

  // Índice de la categoría seleccionada
  int selectedCategoryIndex = 2;

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

  Future<void> _addOutfit(int idShoes) async{


    _outfitController.addOutfit(_clothController.username, weekyear, weekday, idShirt, idPants, idShoes);    
    Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF477372),
        title: Text(
          "3. Selecciona unos Zapatos",
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
                          _addOutfit(snapshot.data![index].id?? -1);
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