import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:swiftvote/src/data/models/question.dart';

@immutable
abstract class QuestionState extends Equatable {
  const QuestionState();
}

class QuestionInitial extends QuestionState {

  const QuestionInitial();

  @override
  List<Object> get props => [];
}


class QuestionLoading extends QuestionState {

  const QuestionLoading();

  @override
  List<Object> get props => [];
}

class QuestionLoaded extends QuestionState {

  final Question question;
  const QuestionLoaded(this.question);

  @override
  List<Object> get props => [question];
}

class QuestionError extends QuestionState {

  final String message;
  const QuestionError(this.message);

  @override
  List<Object> get props => [message];
}