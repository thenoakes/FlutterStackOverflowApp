import 'package:flutterstackapp/home/index.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/// A service for fetching Stack Overflow data
class HomeProvider {
  HomeProvider();

  /// Asynchronously fetch data and pakage it into a model
  Future<QuestionData> getData() async {
    var res = await http.get("https://api.stackexchange.com/2.2/questions?"
        "order=desc&"
        "sort=activity&"
        "site=stackoverflow&"
        "filter=!--1nZwT4.fol");
    var decodedJson = jsonDecode(res.body);

    return QuestionData(
        questions: List<Question>.from(decodedJson['items'].map((item) {
      return Question.fromJson(item);
    })));
  }
}
