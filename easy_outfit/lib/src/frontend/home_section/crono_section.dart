import 'package:easy_outfit/src/backend/controllers/cloth_controller.dart';
import 'package:easy_outfit/src/frontend/home_section/shirt_section.dart';
import 'package:flutter/material.dart';
import 'package:easy_outfit/src/backend/controllers/outfit_controller.dart';
import 'package:easy_outfit/src/backend/controllers/utilities.dart';
import 'package:easy_outfit/src/backend/models/outfit_model.dart';
import 'package:google_fonts/google_fonts.dart';

class CronoSection extends StatefulWidget {
  String user;
  CronoSection({super.key, required this.user});
  @override
  _CronoSectionState createState() => _CronoSectionState(user: user);
}

class _CronoSectionState extends State<CronoSection> {
  String user;
  _CronoSectionState({required this.user});
  final OutfitController _outfitController = OutfitController();
  final ClothController _clothController = ClothController();

  @override
  void initState() {
    super.initState();

    _clothController.setUsername(user);
  }

  // Lista de números para los botones
  List<String> dias = ["Lu", "Ma", "Mi", "Ju", "Vi", "Sa", "Do"];

  // Variable para rastrear el número seleccionado

  int currentWeek = Utilities.instance.weekNumber();
  int currentDay = Utilities.instance.weekDay();
  int selectedWeek = Utilities.instance.weekNumber();
  int numeroSeleccionado = Utilities.instance.weekDay();

  String _weekController = "Semana actual";

  // Lista de conjuntos asociadas a los números
  List<String> conjuntosVestir = [
    'Conjunto 1',
    'Conjunto 2',
    'Conjunto 3',
    'Conjunto 4',
    'Conjunto 5',
    'Conjunto 6',
    'Conjunto 7',
    'Conjunto 8',
    'Conjunto 9',
    'Conjunto 10',
  ];

  // conjunto seleccionada
  String conjuntoSeleccionada = 'Conjunto 1';

  // Lista de elementos guardados
  List<String> elementosGuardados = [];

  void back() {
    setState(() {
      selectedWeek--;
      numeroSeleccionado = 6;
      conjuntoSeleccionada = conjuntosVestir[6];

      int difWeeks = currentWeek - selectedWeek;

      if (difWeeks > 1) {
        _weekController = "Hace $difWeeks semanas";
      } else if (difWeeks == 1) {
        _weekController = "Semana anterior";
      }else if (difWeeks == 0) {
        _weekController = "Semana actual";
      }
    });

    debugPrint("---------------------- Semana actual $selectedWeek");
  }

  void next() {
    setState(() {
      selectedWeek++;

      if (selectedWeek <= currentWeek) {
        numeroSeleccionado = 0;
        conjuntoSeleccionada = conjuntosVestir[0];
      } else {
        selectedWeek = currentWeek+1;
      }

      int difWeeks = currentWeek - selectedWeek;

      if (difWeeks > 1) {
        _weekController = "Hace $difWeeks semanas";
      } else if (difWeeks == 1) {
        _weekController = "Semana anterior";
      } else if (difWeeks == 0) {
        _weekController = "Semana actual";
      }
      else if (difWeeks < 0) {
        _weekController = "Próxima semana";
      }
    });

    debugPrint("---------------------- Semana actual $selectedWeek");
  }

  void onGoBack(dynamic value) {
    setState(() {});
  }

  void removePlanOutfit(){
    _outfitController.removeOutfit(user, selectedWeek, numeroSeleccionado);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 400),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: back,
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF2F3E45),
                ),
                child: Icon(Icons.arrow_back),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Text(
                  _weekController,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    color: Color(0xFF2F3E45),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: next,
                style: ElevatedButton.styleFrom(
                  primary: getColorButton(),
                ),
                child: Icon(Icons.arrow_forward),
              ),
            ],
          ),

          // Botones numerados deslizables
          Container(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: dias.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      numeroSeleccionado = index;
                      conjuntoSeleccionada = conjuntosVestir[index];
                    });
                  },
                  child: Container(
                    width: 70,
                    height: 50,
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: getDayColor(index),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        dias[index],
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          SizedBox(height: 16),

          // Donde aparece el conjunto
          FutureBuilder(
            future: _outfitController.getOutfit(
                user, selectedWeek, numeroSeleccionado),
            builder: (BuildContext context, AsyncSnapshot<Outfit> snapshot) {
              if (snapshot.hasData && snapshot.data!.weekyear != -1) {
                if (currentWeek < selectedWeek || (currentWeek == selectedWeek && numeroSeleccionado>currentDay)
                    ){

                       return Expanded(
                  child: Container(
                    color: Color.fromARGB(71, 87, 131, 129),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 10, 20),
                          child: Text(
                            "Conjunto Planificado:",
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              color: Color(0xFF2F3E44),
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 0, 10, 0),
                                child: FutureBuilder<String>(
                                    future: _clothController
                                        .getClothImage(snapshot.data!.shirtid),
                                    builder: (_, imageSnapshot) {
                                      final String imageUrl =
                                          imageSnapshot.data ?? "";
                                      if (imageUrl != "") {
                                        return Image.asset(
                                          imageUrl,
                                          height: 100,
                                          width: 100,
                                        );
                                      } else {
                                        return Image.asset(
                                          'assets/c_blanco.png',
                                          height: 100,
                                          width: 100,
                                        );
                                      }
                                    })),
                            Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: FutureBuilder<String>(
                                    future: _clothController
                                        .getClothImage(snapshot.data!.pantsid),
                                    builder: (_, imageSnapshot) {
                                      final String imageUrl =
                                          imageSnapshot.data ?? "";
                                      if (imageUrl != "") {
                                        return Image.asset(
                                          imageUrl,
                                          height: 100,
                                          width: 100,
                                        );
                                      } else {
                                        return Image.asset(
                                          'assets/c_blanco.png',
                                          height: 100,
                                          width: 100,
                                        );
                                      }
                                    })),
                            Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 20, 0),
                                child: FutureBuilder<String>(
                                    future: _clothController
                                        .getClothImage(snapshot.data!.shoesid),
                                    builder: (_, imageSnapshot) {
                                      final String imageUrl =
                                          imageSnapshot.data ?? "";
                                      if (imageUrl != "") {
                                        return Image.asset(
                                          imageUrl,
                                          height: 100,
                                          width: 100,
                                        );
                                      } else {
                                        return Image.asset(
                                          'assets/c_blanco.png',
                                          height: 100,
                                          width: 100,
                                        );
                                      }
                                    })),
                                     
                          ],
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: removePlanOutfit,
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF2F3E44),
                            fixedSize: Size(300, 40),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            textStyle: GoogleFonts.poppins(
                              fontSize: 18,
                            ),
                          ),
                          child: Text('Remover'),
                        ),
                        
                      ],
                    ),
                  ),
                );
                    }else{
                       return Expanded(
                  child: Container(
                    color: Color.fromARGB(71, 87, 131, 129),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 10, 20),
                          child: Text(
                            "Conjunto Utilizado:",
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              color: Color(0xFF2F3E44),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 0, 10, 0),
                                child: FutureBuilder<String>(
                                    future: _clothController
                                        .getClothImage(snapshot.data!.shirtid),
                                    builder: (_, imageSnapshot) {
                                      final String imageUrl =
                                          imageSnapshot.data ?? "";
                                      if (imageUrl != "") {
                                        return Image.asset(
                                          imageUrl,
                                          height: 100,
                                          width: 100,
                                        );
                                      } else {
                                        return Image.asset(
                                          'assets/c_blanco.png',
                                          height: 100,
                                          width: 100,
                                        );
                                      }
                                    })),
                            Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: FutureBuilder<String>(
                                    future: _clothController
                                        .getClothImage(snapshot.data!.pantsid),
                                    builder: (_, imageSnapshot) {
                                      final String imageUrl =
                                          imageSnapshot.data ?? "";
                                      if (imageUrl != "") {
                                        return Image.asset(
                                          imageUrl,
                                          height: 100,
                                          width: 100,
                                        );
                                      } else {
                                        return Image.asset(
                                          'assets/c_blanco.png',
                                          height: 100,
                                          width: 100,
                                        );
                                      }
                                    })),
                            Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 20, 0),
                                child: FutureBuilder<String>(
                                    future: _clothController
                                        .getClothImage(snapshot.data!.shoesid),
                                    builder: (_, imageSnapshot) {
                                      final String imageUrl =
                                          imageSnapshot.data ?? "";
                                      if (imageUrl != "") {
                                        return Image.asset(
                                          imageUrl,
                                          height: 100,
                                          width: 100,
                                        );
                                      } else {
                                        return Image.asset(
                                          'assets/c_blanco.png',
                                          height: 100,
                                          width: 100,
                                        );
                                      }
                                    })),
                                     
                          ],
                        ),
                        
                      ],
                    ),
                  ),
                );
                    }
               
              } else {
                if (numeroSeleccionado == currentDay &&
                    currentWeek == selectedWeek) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 10),
                        Image.asset(
                          'assets/agregar.png',
                          height: 130,
                          width: 130,
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShirtSecction(user: user, weekday: numeroSeleccionado, weekyear: selectedWeek),
                            ),
                          ).then(onGoBack),
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF2F3E44),
                            fixedSize: Size(300, 40),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            textStyle: GoogleFonts.poppins(
                              fontSize: 18,
                            ),
                          ),
                          child: Text('Agrega un Conjunto'),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  );
                }if (currentWeek < selectedWeek || (currentWeek == selectedWeek && numeroSeleccionado>currentDay)
                    ) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 10),
                        Image.asset(
                          'assets/agregar.png',
                          height: 130,
                          width: 130,
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShirtSecction(user: user, weekday: numeroSeleccionado, weekyear: selectedWeek),
                            ),
                          ).then(onGoBack),
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF2F3E44),
                            fixedSize: Size(300, 40),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            textStyle: GoogleFonts.poppins(
                              fontSize: 18,
                            ),
                          ),
                          child: Text('Planifica un conjunto'),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  );
                } 
                else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 10),
                        Image.asset(
                          'assets/nousar.png',
                          height: 150,
                          width: 150,
                        ),
                        SizedBox(height: 20),
                        Text(
                          "No se utilizó un conjunto ese día",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }
  
  getColorButton() {

    if(selectedWeek>currentWeek){
      return Colors.grey;
    }
    return Color(0xFF2F3E44);
  }
  
  getDayColor(int index) {


    if(index == currentDay && currentWeek == selectedWeek && numeroSeleccionado!=index){
        return Colors.deepOrangeAccent;
    }
    
    return numeroSeleccionado == index
                          ? Color(0xFF2F3E45)
                          : Color(0xFF578382);
  }
}
