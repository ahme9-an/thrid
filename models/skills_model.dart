class SkillsModel {
  String? id;
  String? title;
    int? score;

  String? userID;


  SkillsModel({
    this.id,
    this.title,
    this.score,
    this.userID
  });
  SkillsModel.fromJson(Map<String, dynamic>? json, String docId,
     ) {
    id = docId;
    title = json!['title'];
    score= json['score'];
    userID = json['userID'];

  }
  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'title': title,
      "userID": userID,
       "score": score,

    };
  }
}
