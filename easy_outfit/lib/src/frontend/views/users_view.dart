import 'package:easy_outfit/src/frontend/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:easy_outfit/src/backend/controllers/user_controller.dart';

class UsersView extends StatefulWidget {
  const UsersView({Key? key, required this.userController}) : super(key: key);

  final UserController userController;

  @override
  State<UsersView> createState() =>
      _UsersViewState(userController: userController);
}

class _UsersViewState extends State<UsersView> {
  _UsersViewState({required this.userController});

  final UserController userController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFC6D8D8),
      appBar: AppBar(
        backgroundColor: Color(0xFF578382),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 20,
              child: Icon(
                Icons.person,
                color: Color(0xFF578382),
                size: 30,
              ),
            ),
            SizedBox(width: 20),
            Text(
              'Bienvenido a Easy Outfit',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ), // Texto
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildGreeting(),
              SizedBox(height: 20),
              _buildUserImage(),
              SizedBox(height: 20),
              _buildUserInfo(),
              SizedBox(height: 15),
              _buildLogoutButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGreeting() {
    return Center(
      child: Container(
        child: Text(
          '¡Hola ${userController.currentUser.name}!',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildUserImage() {
    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/user.png',
            height: 150,
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }

  Widget _buildUserInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoBox(
          label: 'Usuario',
          value: userController.currentUser.name,
          icon: Icons.person,
        ),
        _buildInfoBox(
          label: 'Correo',
          value: userController.currentUser.email,
          icon: Icons.email,
        ),
        _buildInfoBox(
          label: 'Contraseña',
          value: userController.currentUser.password,
          icon: Icons.lock,
        ),
        _buildInfoBox(
          label: 'País',
          value: userController.currentUser.country,
          icon: Icons.location_on,
        ),
      ],
    );
  }

  Widget _buildLogoutButton() {
    return Center(
      child: Container(
        width: 200,
        alignment: Alignment.center,
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyAppForm()),
            );
            const snackBar = SnackBar(content: Text('Cerrando sesión'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
          style: ElevatedButton.styleFrom(
            primary: Color(0xFF2F3E44),
            fixedSize: Size(200, 30),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Text(
            "Cerrar Sesión",
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoBox({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon),
          SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
