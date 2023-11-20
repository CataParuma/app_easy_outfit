import 'package:easy_outfit/src/backend/controllers/utilities.dart';
import 'package:flutter/material.dart';

class Cloth{

  final int? id;
  final int clothtype;
  final String clothstyle;
  final String color;
  final String image;
  final String username;
  int lastweekday;
  int lastweekyear;
  int timesused;

 Cloth({this.id, required this.clothtype, required this.clothstyle, required this.color, required this.image,required this.username, required this.lastweekday,required this.lastweekyear,required this.timesused});

  Cloth.fromMap(Map<String, dynamic> item):
    id=item["id"], clothtype=item["clothType"], clothstyle=item["clothStyle"], color=item["color"], image=item["image"],  username=item["userName"], lastweekday=item["lastweekday"], lastweekyear=item["lastweekyear"], timesused=item["timesUsed"];

  Map<String, Object?> toMap(){
    return {'id':id, 'clothType':clothtype, 'clothStyle':clothstyle, 'color':color, 'image':image, 'userName':username, 'lastweekday': lastweekday, 'lastweekyear': lastweekyear, 'timesUsed': timesused};
  }

  String getDaysFromLastUsed(){

    debugPrint('----------- Last day: $lastweekday');
    debugPrint('----------- Last week: $lastweekyear');
      if(lastweekday >-1){

        if(lastweekday == Utilities.instance.weekDay() && lastweekyear == Utilities.instance.weekNumber()){
          return "Hoy";
        }

        if(lastweekday < Utilities.instance.weekDay() && lastweekyear == Utilities.instance.weekNumber()){
            int num = (Utilities.instance.weekDay()-lastweekday);
            if(num>1){
                return "Hace $num dia";
            }else{
               return "Hace $num dias";
            }
        }

          else if(lastweekday > Utilities.instance.weekDay() && lastweekyear == (Utilities.instance.weekNumber()-1)){
            int num =Utilities.instance.weekDay() +(7-lastweekday);
            if(num<1){
                return "Hace $num dia";
            }else{
               return "Hace $num dias";
            }
        }
        else{

            int num = Utilities.instance.weekNumber()-lastweekyear;
            if(num>0){
                return "Hace $num semana";
            }else{
               return "Hace $num semanas";
            }
            
        }
        
      }

      return "Nunca";
  }


}