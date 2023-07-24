class EducationModel {
  String? id;
  String? major;
  String? year;
  String? institute;
  String? userID;

  EducationModel({this.id,this.userID, this.major, this.year, this.institute});
  EducationModel.fromJson(
    Map<String, dynamic>? json,
    String docId,
  ) {
    id = docId;
    major = json!['major'];
    year = json['year'];
    institute = json['institute'];
        userID = json['userID'];

  }
  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'major': major,
      "year": year,
      "institute": institute,
      "userID": userID,
    };
  }
}
