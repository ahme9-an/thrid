class ProfileModel {
  String? id;
  String? firstName;
  String? lastName;
  String? positionName;
  String? profileDetail;
  String? infoNationality;
  String? infoBirthDate;
  String? userID;

  ProfileModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.positionName,
      this.infoBirthDate,
      this.infoNationality,
      this.profileDetail,
      this.userID});
  ProfileModel.fromJson(
    Map<String, dynamic>? json,
    String docId,
  ) {
    id = docId;
    firstName = json!['firstName'];
    lastName = json['lastName'];
    positionName = json['positionName'];
    profileDetail = json['profileDetail'];
    infoBirthDate = json['infoBirthDate'];
    infoNationality = json['infoNationality'];
    userID = json['userID'];
  }
  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'firstName': firstName,
      "lastName": lastName,
      "positionName": positionName,
      "profileDetail": profileDetail,
      "infoBirthDate": infoBirthDate,
      "infoNationality": infoNationality,
      "userID": userID,
    };
  }
}
