import 'package:swiftvote/data/entities.dart';
import 'package:swiftvote/data/models.dart';

class WebClient {
  final Duration delay;

  const WebClient([this.delay = const Duration(milliseconds: 3000)]);

  /// Mock that "fetches" some Votes from a "web service" after a short delay
  Future<List<VoteEntity>> fetchVotes() async {
    return Future.delayed(
        delay,
        () => [
              VoteEntity(
                null,
                'Who is better?',
                'username123',
                ["Lionel Messi", "Christiano Ronaldo"],
                [3000, 4000],
                ["Sports", "Gaming"],
              ),
              VoteEntity(
                null,
                'Coolest colour?',
                'username999',
                ["Red", "Blue"],
                [9999, 9999],
                ["Politics", "Gaming"],
              ),
            ]);
  }

//  final String id;
//  final String title;
//  final String author;
//  final List<String> voteOptions;
//  final List<int> votes;
//  final List<String> tags;
  /// Mock that returns true or false for success or failure. In this case,
  /// it will "Always Succeed"
  Future<bool> postVotes(List<VoteEntity> votes) async {
    return Future.value(true);
  }
}
