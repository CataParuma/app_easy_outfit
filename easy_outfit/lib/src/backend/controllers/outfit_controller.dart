import 'package:easy_outfit/src/backend/controllers/cloth_controller.dart';
import 'package:easy_outfit/src/backend/controllers/utilities.dart';
import 'package:easy_outfit/src/backend/models/outfit_model.dart';
import 'package:easy_outfit/src/backend/services/cloth_database.dart';

class OutfitController{


  Future<Outfit> getOutfit(String user,int weekYear, int weekDay) async{
   

    Outfit findOutfit = await ClothDatabase.instance.getOutfitByDate(user, weekYear, weekDay);
    return findOutfit;

  }

  Future<void> addOutfit(String user,int weekYear, int weekDay, int idShirt, int idPants, int idShoes) async{

    //weekYear = 46;
    //weekDay = 6;

      Outfit newOutfit = Outfit(weekyear: weekYear, weekday: weekDay, shirtid: idShirt, pantsid: idPants, shoesid: idShoes, username: user);
      await ClothDatabase.instance.createOutfit(newOutfit);

      if(weekYear < Utilities.instance.weekNumber() || (weekYear == Utilities.instance.weekNumber() && weekDay<=Utilities.instance.weekDay())){
         ClothController _clothController = ClothController();
      _clothController.setUsername(user);
      _clothController.registerUse(idShirt,weekDay, weekYear);
      _clothController.registerUse(idPants,weekDay, weekYear);
      _clothController.registerUse(idShoes,weekDay, weekYear);
      }

     


  }

  Future<void> removeOutfit(String user,int weekYear, int weekDay) async{
       Outfit findOutfit = await ClothDatabase.instance.getOutfitByDate(user, weekYear, weekDay);
       await ClothDatabase.instance.deleteOutfit(findOutfit.id ?? -1);
  }

}