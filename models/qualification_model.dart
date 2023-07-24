class QualificationModel {
  String? id;
  String? name;
  String? enteredDate;

  QualificationModel({
    this.id,
    this.name,
    this.enteredDate,
  });
  QualificationModel.fromJson(Map<String, dynamic>? json, String docId,
    ) {
    id = docId;
    name = json!['name'];
    enteredDate = json['enteredDate'];
  }
  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'name': name,
      "enteredDate": enteredDate,
    };
  }
}
