import 'dart:io';

class UserModel {
  String? id;
  String? name;
  String? enteredDate;
  String? primaryPhoneNo;

  File? filePhotoPath;
  String? photoURL;
  bool? admin;
  String? major;
  String? qualification;
  int? views;

  UserModel(
      {this.id,
      this.name,
      this.enteredDate,
      this.primaryPhoneNo,
      this.filePhotoPath,
      this.photoURL,
      this.major,
      this.views,
      this.qualification,
      this.admin});
  UserModel.fromJson(Map<String, dynamic>? json, String docId,
      {String? photoURL = ""}) {
    id = docId;
    name = json!['name'];
    // enteredDate = json['enteredDate'];
    // photoUrl = json['photoUrl'];
    primaryPhoneNo = json['primaryPhoneNo'];

   
    major = json['major'];
    qualification = json['qualification'];
    admin = json['admin'];
    views = json['views'];

    photoURL = photoURL;
  }
  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'name': name,
      "enteredDate": enteredDate,
      // "photoUrl": photoUrl,
      "primaryPhoneNo": primaryPhoneNo,

      "major": major,
      "qualification": qualification,
      "views": views,

      "admin": admin,
    };
  }
}
