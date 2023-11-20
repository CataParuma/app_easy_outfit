import 'package:easy_outfit/src/backend/controllers/cloth_controller.dart';
import 'package:easy_outfit/src/backend/models/cloth_model.dart';
import 'package:easy_outfit/src/frontend/screen/select_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class ArmarioView extends StatefulWidget {
  String user;
  ArmarioView({super.key, required this.user});

  @override
  _ArmarioViewState createState() => _ArmarioViewState(user: user);
}

class _ArmarioViewState extends State<ArmarioView>
    with SingleTickerProviderStateMixin {
  final String user;
  _ArmarioViewState({required this.user});

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

  void onGoBack(dynamic value){
    const snackBar = SnackBar(content: Text('Prenda Agregada'));
                       ScaffoldMessenger.of(context).showSnackBar(snackBar);
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xFF477372),
          title: Text(
            "Mi Armario",
            style: GoogleFonts.poppins(
              fontSize: 20,
            ),
          ),
          automaticallyImplyLeading: false,
        ),
      body: Column(children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: Color(0xFFC7D9D8),
          ),
          child: TabBar(
            controller: _tabController,
            tabs: _clothController.categories
                .map((category) => Tab(text: category))
                .toList(),
            labelStyle: TextStyle(
              fontSize: 16,
            ),
            indicator: BoxDecoration(
              color: Color(0xFF477372),
            ),
          ),
        ),

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
                        // Agrega el producto tocado al armario
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
                                '${snapshot.data![index].color} - ${snapshot.data![index].clothstyle}'),
                          ],
                        ),
                      ),
                    );
                  },
                ));
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
            }),
        // Boton Agregar Prenda
        Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SelectScreen(
                      clothController: _clothController,
                    ),
                  ),
                ).then(onGoBack);
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF2F3E44),
                fixedSize: Size(300, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                "Agregar Prenda",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
