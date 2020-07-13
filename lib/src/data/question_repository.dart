import 'dart:math';

import 'models/question.dart';

abstract class QuestionRepository {
  Future<Question> fetchQuestion(String id);
}

class FakeQuestionRepository implements QuestionRepository {
  String cachedQuestionBody;

  @override
  Future<Question> fetchQuestion(String id) {
    // TODO: implement fetchQuestion
    return Future.delayed(
      Duration(seconds: 1),
      () {
        final random = Random();

        if (random.nextBool()) {
          throw NetworkError();
        }
        return Question(id: id, questionBody: cachedQuestionBody, answerOptions: []);
      },
    );
  }
}

class NetworkError extends Error {}