import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:swiftvote/blocs/vote/vote.dart';
import 'package:swiftvote/data/models.dart';
import 'package:swiftvote/data/repositories.dart';
import 'package:swiftvote/utils/file_storage.dart';
import 'package:swiftvote/utils/simple_bloc_observer.dart';
import 'package:swiftvote/widgets/widgets.dart';
import 'package:swiftvote/utils/swiftvote_widget_keys.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';

import 'blocs/blocs.dart';

import 'package:swiftvote/utils/routes.dart';
import 'package:swiftvote/screens/screens.dart';

//'__flutter_bloc_app__'

Future<void> main() async {
  Bloc.observer = SimpleBlocObserver();
//  runApp(
//    BlocProvider(
//      create: (context) {
//        return VoteBloc(
//          voteRepository: const VoteRepository(
//            fileStorage: const FileStorage(
//              '__swiftvote_app_filestorage__',
//              getApplicationDocumentsDirectory,
//            ),
//          ),
//        )..add(VoteLoaded());
//      },
//      child: SwiftvoteApp(),
//    ),
//  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(SwiftvoteApp());
}

class SwiftvoteApp extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<VoteBloc>(
          create: (context) => VoteBloc(
            voteRepository: FirebaseVoteRepository(),
          )..add(LoadVotes()),
        ),
      ],
      child: MaterialApp(
        title: 'SwiftVote',
        navigatorObservers: <NavigatorObserver>[observer],
        routes: {
          Routes.home: (context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider<TabBloc>(
                  create: (context) => TabBloc(),
                ),
                BlocProvider<ExploreBloc>(
                    create: (context) => ExploreBloc()
                      ..add(
                        ExploreLoaded(),
                      ))
              ],
              child: AppScreen(),
            );
          },
          Routes.addVoteSCreen: (context) {
            return AddVoteScreen(
              key: SwiftvoteWidgetKeys.addVoteScreen,
              isEditing: false,
              onSave: (title, voteOptionOne, voteOptionTwo, tag) {
                BlocProvider.of<VoteBloc>(context).add(AddVote(Vote(
                    title: title,
                    author: 'testAuthor',
                    voteOptions: [voteOptionOne, voteOptionTwo],
                    votes: [0, 0],
                    tags: [tag])));
              },
            );
          },
        },
      ),
    );
  }
}
