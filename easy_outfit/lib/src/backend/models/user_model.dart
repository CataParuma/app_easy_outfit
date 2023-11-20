class User{

  final String name;
  final String password;
  final String email;
  final String country;

  User({required this.name, required this.password, required this.email, required this.country});

  User.fromMap(Map<String, dynamic> item):
    name=item["name"], password=item["password"], email=item["email"], country=item["country"];

  Map<String, Object> toMap(){
    return {'name':name, 'password':password, 'email':email, 'country':country};
  }
}