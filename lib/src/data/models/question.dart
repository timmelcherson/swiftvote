import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Question extends Equatable {

  final String id;
  final String questionBody;
  final List<String> answerOptions;

  Question({
    @required this.id,
    @required this.questionBody,
    @required this.answerOptions
  });

  @override
  List<Object> get props => [
    questionBody,
    answerOptions
  ];
}