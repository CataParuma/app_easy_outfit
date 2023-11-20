import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_outfit/src/frontend/pages/login.dart';
import 'package:easy_outfit/src/backend/controllers/user_controller.dart';

class SignUp extends StatefulWidget {
   const SignUp({super.key});

  

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  

   final UserController _userController =UserController();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  String? selectedCountry;

  Future<void> SignUpUser() async{

    if(_nameController.text != "" && _passController.text != "" && _emailController.text != ""){
       
        int response = await _userController.registerUser(_nameController.text, _passController.text, _emailController.text, selectedCountry.toString());

        
      if(response == 0){
        const snackBar = SnackBar(content: Text('Ese nombre de usuario ya esta registrado'));
                       ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      else if(response == -1){
        const snackBar = SnackBar(content: Text('Ese correo ya esta registrado'));
                       ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      else{
          const snackBar = SnackBar(content: Text('Usuario Añadido'));
                       ScaffoldMessenger.of(context).showSnackBar(snackBar);
       
   Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyAppForm()),
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
            'assets/cuenta.png',
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
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Correo',
                prefixIcon: Icon(Icons.email),
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
                labelStyle: TextStyle(fontSize: 18),
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'País',
                prefixIcon: Icon(Icons.flag),
              ),
              style: TextStyle(fontSize: 18, color: Colors.black),
              items: [
                DropdownMenuItem(
                  value: 'Argentina',
                  child: Text('Argentina'),
                ),
                DropdownMenuItem(
                  value: 'Brasil',
                  child: Text('Brasil'),
                ),
                DropdownMenuItem(
                  value: 'Canadá',
                  child: Text('Canadá'),
                ),
                DropdownMenuItem(
                  value: 'Chile',
                  child: Text('Chile'),
                ),
                DropdownMenuItem(
                  value: 'Colombia',
                  child: Text('Colombia'),
                ),
                DropdownMenuItem(
                  value: 'Ecuador',
                  child: Text('Ecuador'),
                ),
                DropdownMenuItem(
                  value: 'Estados Unidos',
                  child: Text('Estados Unidos'),
                ),
                DropdownMenuItem(
                  value: 'México',
                  child: Text('México'),
                ),
                DropdownMenuItem(
                  value: 'Perú',
                  child: Text('Perú'),
                ),
                DropdownMenuItem(
                  value: 'Venezuela',
                  child: Text('Venezuela'),
                ),
              ],
              onChanged: (String? newValue) {
                setState(() {
                  selectedCountry = newValue;
                });
              },
              value: selectedCountry,
            ),
          ),
          
          SizedBox(height: 15),

          Container(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: ElevatedButton(
              onPressed: () async{
               await SignUpUser();
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF2F3E44),
                fixedSize: Size(300, 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                "Crear Usuario",
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
                  MaterialPageRoute(builder: (context) => MyAppForm()),
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
                "Iniciar Sesión",
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  color: Color(0xFF2F3E44),
                ),
              ),
            ),
          ),

          SizedBox(height: 20),
          Image.asset(
            'assets/img1.png',
            height: 150,
          ),
        ],
      ),
    );
  }
}