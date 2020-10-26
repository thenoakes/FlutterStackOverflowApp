class QuestionData {
  QuestionData({this.questions});
  List<Question> questions;
}

class Question {
  int id;
  String question;
  int score;
  int views;
  List<String> tags;

  Question({this.id, this.question, this.score, this.views, this.tags});

  Question.fromJson(Map<String, dynamic> json) {
    id = json['question_id'];
    question = json['body'];
    score = json['score'] ?? 0;
    views = json['view_count'];
    tags = List<String>.from(json['tags']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question_id'] = this.id;
    data['body'] = this.question;
    data['score'] = this.score;
    data['view_count'] = this.views;
    data['tags'] = this.tags;
    return data;
  }
}
