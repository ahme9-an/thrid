class MajorModel {
  String? id;
  String? name;
  String? enteredDate;

  MajorModel({
    this.id,
    this.name,
    this.enteredDate,
  });
  MajorModel.fromJson(Map<String, dynamic>? json, String docId,
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
