class ItemModelCharity {
  final String? id;
  final String? itemPic;
  final String? date;
  final String? detail;
  final String? username;
  final String? displayPic;
  final String? num;
  final String? itemName;

  ItemModelCharity({
    this.itemName,
    this.num,
    this.id, this.itemPic, this.date, this.detail, this.username, this.displayPic,
  });

  static ItemModelCharity fromMap(Map<String, dynamic> map) {

    return ItemModelCharity(

      itemName: map['itemName'],
      num:map['num'],
      id: map['id'],
      date: map['date'],
      itemPic: map['itemPic'],
      detail: map['detail'],
      username:map['username'],
      displayPic: map['displayPic'],
    );
  }

  Map<String, dynamic> toJSON() => {

    'num':num,
    'displayPic': displayPic,
    'id': id,
    'date': date,
    'itemPic': itemPic,
    'detail': detail,
    'username': username,
    'itemName': itemName,
  };
}
