class UserModel {
  final String uid;
  final String name;
  final String email;
  final int? dt;
  final String cnic;
  final String? image;
  final String? body;


  UserModel({
    this.body,
     this.image,
    required this.cnic,
    required this.uid,
    required this.name,
    required this.email,
     this.dt,
  });

  static UserModel fromMap(Map<String, dynamic> map) {
    return UserModel(
      body: map['body'],
      cnic: map['cnic'],
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      dt: map['dt'],
      image: map['image'],
    );
  }
}