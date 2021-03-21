import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:swiftvote/blocs/explore/explore.dart';
import 'package:swiftvote/blocs/vote_comments/vote_comments.dart';
import 'package:swiftvote/data/models.dart';
import 'package:swiftvote/data/repositories.dart';

class VoteCommentsBloc extends Bloc<VoteCommentsEvent, VoteCommentsState> {
  final VoteRepository _voteRepository;
  StreamSubscription _voteSubscription;

  VoteCommentsBloc({@required VoteRepository voteRepository})
      : assert(voteRepository != null),
        _voteRepository = voteRepository,
        super(VoteCommentsLoadingState());

  @override
  Stream<VoteCommentsState> mapEventToState(
    VoteCommentsEvent event,
  ) async* {
    if (event is LoadVoteCommentsByVoteIdEvent) {
      yield* _mapLoadVoteCommentsByVoteIdEventToState(event);
    }
    if (event is VoteCommentsUpdatedEvent) {
      yield* _mapVoteCommentsUpdatedEventToState(event);
    }
    if (event is AddVoteCommentEvent) {
      yield* _mapAddVoteCommentEventToState(event);
    }
  }

  Stream<VoteCommentsState> _mapLoadVoteCommentsByVoteIdEventToState(
    LoadVoteCommentsByVoteIdEvent event,
  ) async* {
    _voteSubscription?.cancel();
    _voteSubscription = _voteRepository
        .getVoteCommentsByVoteId(
          voteId: event.vote.id,
        )
        .listen(
          (comments) => add(
            VoteCommentsUpdatedEvent(
              vote: event.vote,
              comments: comments,
            ),
          ),
        );
  }

  Stream<VoteCommentsState> _mapVoteCommentsUpdatedEventToState(
    VoteCommentsUpdatedEvent event,
  ) async* {
    yield VoteCommentsLoadedState(vote: event.vote, comments: event.comments);
  }

  Stream<VoteCommentsState> _mapAddVoteCommentEventToState(AddVoteCommentEvent event) async* {
    VoteComment comment = VoteComment(
      content: event.content,
      createdAt: DateTime.now(),
    );
    _voteRepository.addCommentToVote(
      voteId: (state as VoteCommentsLoadedState).vote.id,
      comment: comment,
    );
  }

  @override
  Future<void> close() {
    _voteSubscription?.cancel();
    return super.close();
  }
}
