import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_outfit/src/frontend/pages/signup.dart';
import 'package:easy_outfit/src/frontend/pages/main_screen.dart';
import 'package:easy_outfit/src/backend/controllers/user_controller.dart';

class MyAppForm extends StatefulWidget {
  const MyAppForm({Key? key}) : super(key: key);

  @override
  State<MyAppForm> createState() => _MyAppFormState();
}

class _MyAppFormState extends State<MyAppForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final UserController _userController =UserController();

  Future<void> loginUser() async{

    if(_nameController.text != "" && _passController.text != ""){
        debugPrint("1");
        int response = await _userController.loginUser(_nameController.text, _passController.text);

        
      if(response == 0){
        const snackBar = SnackBar(content: Text('Ese usuario no esta registrado'));
                       ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      else if(response == -1){
        const snackBar = SnackBar(content: Text('Contraseña incorrecta'));
                       ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      else{
         Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainScreen(userController: _userController)),
                );
      }

   
    }

    else{
      const snackBar = SnackBar(content: Text('Debes llenar todos los campos!'));
                       ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Image.asset(
            'assets/sesion.png',
          ),
  
          Container(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Usuario',
                prefixIcon: Icon(Icons.person),
                labelStyle: TextStyle(fontSize: 18),
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: TextFormField(
              controller: _passController,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
              style: TextStyle(fontSize: 18),
            ),
          ),

          SizedBox(height: 15),

          Container(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: ElevatedButton(
              onPressed: () async {
                await loginUser();
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF2F3E44),
                fixedSize: Size(300, 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                "Iniciar Sesión",
                style: GoogleFonts.poppins(
                  fontSize: 15,
                ),
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUp()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFC7D8D9),
                fixedSize: Size(300, 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                "Crear Cuenta",
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  color: Color(0xFF2F3E44),
                ),
              ),
            ),
          ),

          SizedBox(height: 20),

          Image.asset(
            'assets/img2.png',
            height: 150,
          ),
        ],
      ),
    );
  }
}