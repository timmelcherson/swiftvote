import 'package:bloc_test/bloc_test.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:swiftvote/blocs/blocs.dart';
import 'package:swiftvote/blocs/vote/vote_bloc.dart';
import 'package:swiftvote/data/models/vote_model.dart';
import 'package:swiftvote/data/repositories/firebase_vote_repository.dart';

class MockVoteBloc extends MockBloc implements VoteBloc {}

class MockFirebaseVoteRepository extends Mock
    implements FirebaseVoteRepository {}

void main() {
  group('unit tests', () {
    VoteBloc voteBloc;
    MockFirebaseVoteRepository mockRepository;

    final voteResponse = [
      Vote(),
      Vote(),
    ];

    setUp(() {
      mockRepository = MockFirebaseVoteRepository();
    });

    test('Throw AssertionError if repository is null', () {
      expect(() => VoteBloc(voteRepository: null), throwsA(AssertionError));
    });

    test('Get all votes', () {
      when(mockRepository.getVotes())
          .thenAnswer((_) => Stream.value(voteResponse));
    });
  });

  /*************************************************************/
//  group('bloc tests', () {
//    VoteBloc voteBloc;
//    MockFirebaseVoteRepository mockRepository;
//    Stream<VoteState> voteSubscription;
//    Future<Function> close;
//
//    final voteResponse = [
//      Vote(),
//      Vote(),
//    ];
//
//    setUp(() {
//      mockRepository = MockFirebaseVoteRepository();
//
//    });
//
//    blocTest(
//      'VoteBloc with no event added',
//      build: () => VoteBloc(voteRepository: mockRepository),
//      expect: [
//        VotesLoading,
//        VotesLoaded,
//        VotesUpdated,
//        close,
//      ],
//    );
//  });
}
