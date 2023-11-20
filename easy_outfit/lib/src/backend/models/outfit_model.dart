class Outfit{

  int? id;
  int weekyear;
  int weekday;
  int shirtid;
  int pantsid;
  int shoesid;
  String username;
  

  Outfit({this.id, required this.weekyear, required this.weekday, required this.shirtid, required this.pantsid, required this.shoesid, required this.username});

   Outfit.fromMap(Map<String, dynamic> item):
    id=item["id"], weekyear=item["weekyear"], weekday=item["weekday"], shirtid=item["shirtid"], pantsid=item["pantsid"],  shoesid=item["shoesid"], username=item["username"];

  Map<String, Object?> toMap(){
    return {'id':id, 'weekyear':weekyear, 'weekday':weekday, 'shirtid':shirtid, 'pantsid':pantsid, 'shoesid':shoesid, 'username':username};
  }
}