class WorkModel {
  String? id;
  String? position;
  String? year;
  String? company;
  String? detail;

  String? userID;

  WorkModel(
      {this.id,
      this.userID,
      this.position,
      this.year,
      this.company,
      this.detail});
  WorkModel.fromJson(
    Map<String, dynamic>? json,
    String docId,
  ) {
    id = docId;
    position = json!['position'];
    year = json['year'];
    company = json['company'];
    userID = json['userID'];
    detail = json['detail'];
  }
  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'position': position,
      "year": year,
      "company": company,
      "detail": detail,
      "userID": userID,
    };
  }
}
