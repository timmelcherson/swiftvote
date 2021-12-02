import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swiftvote/blocs/index.dart';
import 'package:swiftvote/data/repositories/index.dart';
import 'package:swiftvote/global_widgets/loading_indicator.dart';

class AppInitializer extends StatefulWidget {
  final Widget child;

  const AppInitializer({required Key key, required this.child}) : super(key: key);

  @override
  _AppInitializerState createState() => _AppInitializerState();
}

class _AppInitializerState extends State<AppInitializer> {
  final Future<FirebaseApp> _firebaseInit = Firebase.initializeApp();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([_firebaseInit]),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          // if (snapshot.hasData) {
          //   _skipLogin = snapshot.data[1];
          // }
          return MultiRepositoryProvider(
            providers: [
              RepositoryProvider<AuthRepository>(
                create: (context) => AuthRepository.instance,
              ),
              RepositoryProvider<UserProfileRepository>(
                create: (context) => UserProfileRepository(),
              ),
              RepositoryProvider<VoteRepository>(
                create: (context) => VoteRepository(),
              ),
            ],
            child: MultiBlocProvider(
              providers: [
                BlocProvider<AuthBloc>(
                  lazy: false,
                  create: (context) => AuthBloc(
                    authRepository:
                        RepositoryProvider.of<AuthRepository>(context),
                    userProfileRepository:
                        RepositoryProvider.of<UserProfileRepository>(context),
                  )..add(AuthCheckIfRegisteredEvent()),
                ),
                BlocProvider<NavigationBloc>(
                  lazy: false,
                  create: (context) => NavigationBloc(),
                ),
                BlocProvider<UserProfileBloc>(
                  lazy: false,
                  create: (context) => UserProfileBloc(
                    userProfileRepository:
                        RepositoryProvider.of<UserProfileRepository>(context),
                  )..add(UserProfilePrefetchEvent()),
                ),
                BlocProvider<VoteBloc>(
                  create: (context) => VoteBloc(
                    voteRepository:
                        RepositoryProvider.of<VoteRepository>(context),
                  ),
                ),
                BlocProvider<SettingsBloc>(
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
              child: widget.child,
            ),
          );
        }
        return LoadingIndicator();
      },
    );
  }
}
