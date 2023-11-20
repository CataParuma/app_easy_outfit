import 'package:easy_outfit/src/backend/models/cloth_model.dart';
import 'package:easy_outfit/src/backend/services/cloth_database.dart';
import 'package:flutter/material.dart';

class ClothController {


  final List<String> _categories = ["Camisas", "Pantalones", "Zapatos"];
  List<String> get categories =>_categories;
  String _username = "username";

  String get username => _username;


  void setUsername(String user){
    _username = user;
  }

  Future<int> createCloth(
      int clothType, String clothStyle, String color, String image) async {
    Cloth newCloth = Cloth(
        clothtype: clothType,
        clothstyle: clothStyle,
        color: color,
        image: image,
        username: username,
        lastweekday:-1,
        lastweekyear: -1,
        timesused: 0,
        );
    
    int result = await ClothDatabase.instance.createCloth(newCloth);

    return result;
  }

  Future<List<Cloth>> getClothesByType(int clothType) async {
    
    List<Cloth> result = await ClothDatabase.instance
        .clothListByUserAndType(_username, clothType);
  debugPrint("----------------------Result: ${result.length}");
    

    return result;
  }

  Future<List<Cloth>> getAllClothes() async {
    List<Cloth> result = await ClothDatabase.instance.clothListByUser(_username);

    return result;
  }

  Future<Cloth> getClothById(int id) async{

    Cloth findCloth = await ClothDatabase.instance.getClothById(id);

    return findCloth;
  }

  Future<String> getClothImage(int id) async{

    Cloth findCloth = await ClothDatabase.instance.getClothById(id);

    return findCloth.image;
  }

  Future<void> registerUse(int id, int weekday, int weekyear) async{
     Cloth findCloth = await ClothDatabase.instance.getClothById(id);

    
      findCloth.lastweekday = weekday;
      findCloth.lastweekyear = weekyear;
      findCloth.timesused++;
     await ClothDatabase.instance.updateCloth(findCloth);

  }
}
