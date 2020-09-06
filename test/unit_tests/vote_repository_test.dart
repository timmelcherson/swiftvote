import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:swiftvote/blocs/blocs.dart';
import 'package:swiftvote/data/models.dart';
import 'package:swiftvote/data/repositories.dart';

class MockFirebaseVoteRepository extends Mock implements FirebaseVoteRepository {}

void main() {

  MockFirebaseVoteRepository mockRepository;

  final vote = Vote();
  
  setUp(() {
    mockRepository = MockFirebaseVoteRepository();
  });


//  blocTest('Test votes', build: () {
//    when(mockRepository.votes()).thenAnswer((_) async => vote);
//  });

  test('Get votes entities from database', () {

  });

}