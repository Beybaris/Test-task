class UserData {
  int? id;
  Null? sex;
  String? documentID;
  Null? birthday;
  Null? fathername;
  String? firstname;
  String? lastname;
  String? phone;
  Null? nationality;

  UserData(
      {this.id,
      this.sex,
      this.documentID,
      this.birthday,
      this.fathername,
      this.firstname,
      this.lastname,
      this.phone,
      this.nationality});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sex = json['sex'];
    documentID = json['document_ID'];
    birthday = json['birthday'];
    fathername = json['fathername'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    phone = json['phone'];
    nationality = json['nationality'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sex'] = this.sex;
    data['document_ID'] = this.documentID;
    data['birthday'] = this.birthday;
    data['fathername'] = this.fathername;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['phone'] = this.phone;
    data['nationality'] = this.nationality;
    return data;
  }
}
