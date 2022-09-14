class PhoneModel {
  String? number;

  PhoneModel({this.number});

  static PhoneModel fromMap(Map<String, dynamic> map) {
    return PhoneModel(number: map['number']);
  }
}
