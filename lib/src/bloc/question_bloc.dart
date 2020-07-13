import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:swiftvote/src/data/question_repository.dart';
import 'bloc.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {

  final QuestionRepository questionRepository;

  QuestionBloc(this.questionRepository);

  @override
  QuestionState get initialState => QuestionInitial();

  @override
  Stream<QuestionState> mapEventToState(
    QuestionEvent event,
  ) async* {
    yield QuestionLoading();

    if (event is GetQuestion) {
      try {
        final question = await questionRepository.fetchQuestion(event.id);
        yield QuestionLoaded(question);
      } on NetworkError {
        yield QuestionError("Couldn't fetch question. Something WENT WRONG!!!");
      }
    }
  }
}
