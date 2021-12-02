import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/index.dart';
import 'data/repositories/index.dart';

class AppBlocProvider extends StatelessWidget {
  final Widget child;
  const AppBlocProvider({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<VoteBloc>(
          create: (context) => VoteBloc(
            voteRepository:
            RepositoryProvider.of<VoteRepository>(context),
          )..add(LoadVotesEvent()),
        ),
        BlocProvider<SettingsBloc>(
          lazy: false,
          create: (context) => SettingsBloc(
            voteRepository:
            RepositoryProvider.of<VoteRepository>(context),
            userProfileRepository:
            RepositoryProvider.of<UserProfileRepository>(context),
            voteBloc: BlocProvider.of<VoteBloc>(context),
            userProfileBloc: BlocProvider.of<UserProfileBloc>(context),
          ),
        ),
        BlocProvider<VoteResultBloc>(
          create: (context) => VoteResultBloc(
            voteRepository:
            RepositoryProvider.of<VoteRepository>(context),
            userProfileBloc: BlocProvider.of<UserProfileBloc>(context),
          ),
        ),
        BlocProvider<VoteCommentsBloc>(
          create: (context) => VoteCommentsBloc(
            voteRepository:
            RepositoryProvider.of<VoteRepository>(context),
          ),
        ),
        BlocProvider<ExploreBloc>(
          create: (context) => ExploreBloc(
            voteRepository:
            RepositoryProvider.of<VoteRepository>(context),
            voteBloc: BlocProvider.of<VoteBloc>(context),
          )..add(ExploreCategoriesLoadedEvent()),
        ),
        BlocProvider<SearchBloc>(
          create: (context) => SearchBloc(
            voteRepository:
            RepositoryProvider.of<VoteRepository>(context),
          ),
        ),
      ],
      child: child,
    );
  }
}
