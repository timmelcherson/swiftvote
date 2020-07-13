import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class QuestionEvent extends Equatable{
  const QuestionEvent();
}

class GetQuestion extends QuestionEvent {

  final String id;

  const GetQuestion(this.id);

  @override
  List<Object> get props => [id];
}