class AwardModel {
  String? id;
  String? name;
  String? userID;


  AwardModel({
    this.id,
    this.name,
    this.userID
  });
  AwardModel.fromJson(Map<String, dynamic>? json, String docId,
     ) {
    id = docId;
    name = json!['name'];
    userID = json['userID'];

  }
  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'name': name,
      "userID": userID,

    };
  }
}
