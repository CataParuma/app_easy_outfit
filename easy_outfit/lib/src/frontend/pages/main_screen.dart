import 'package:easy_outfit/src/frontend/views/armario_view.dart';
import 'package:easy_outfit/src/frontend/views/users_view.dart';
import 'package:easy_outfit/src/frontend/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:easy_outfit/src/backend/controllers/user_controller.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.userController});

  final UserController userController;

  @override
  State<MainScreen> createState() => _MainScreenState(userController: userController);
}

class _MainScreenState extends State<MainScreen> {
  _MainScreenState ({ required this.userController});

  int selectedIndex = 0;
  

  final UserController userController;

  @override
  Widget build(BuildContext context) {

    final screens = [HomeView(user: userController.currentUser.name), ArmarioView(user: userController.currentUser.name,), UsersView(userController: userController),];

    return Scaffold(

      body: IndexedStack(
        index: selectedIndex,
        children: screens,
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        backgroundColor: const Color(0xFFC6D8D8),
        selectedItemColor: const Color(0xFF568281),
        unselectedItemColor: const Color(0xFF181B1B),
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            activeIcon: const Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.notifications),
            activeIcon: const Icon(Icons.notifications),
            label: 'Armario',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            activeIcon: const Icon(Icons.person),
            label: 'Usuario',
          ),
        ],
      ),
    );
  }
}