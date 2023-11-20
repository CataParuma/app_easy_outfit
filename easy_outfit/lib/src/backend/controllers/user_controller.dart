import 'package:easy_outfit/src/backend/models/user_model.dart';
import 'package:easy_outfit/src/backend/services/cloth_database.dart';

class UserController {
  late User _currentUser;
  User get currentUser => _currentUser;

  Future<int> registerUser(
      String name, String password, String email, String country) async {
    bool existUser = await ClothDatabase.instance.existUserByName(name);

    if (existUser) {
      return 0;
    }

    bool existEmail = await ClothDatabase.instance.existUserByEmail(email);

    if (existEmail) {
      return -1;
    }

    User newUser =
        User(name: name, password: password, email: email, country: country);
    await ClothDatabase.instance.createUser(newUser);

    return 1;
  }

  Future<int> loginUser(String name, String password) async{

    bool existUser = await ClothDatabase.instance.existUserByName(name);

    if (!existUser) {
      return 0;
    }

    User user = await ClothDatabase.instance.getUserByName(name);

    if(user.password == password){

        _currentUser = user;
        return 1;
    }

    return -1;

  }

}