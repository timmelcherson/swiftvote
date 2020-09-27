import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:swiftvote/blocs/vote/vote.dart';
import 'package:swiftvote/data/models.dart';
import 'package:swiftvote/data/repositories.dart';
import 'package:swiftvote/screens/explore_page/explore_scaffold.dart';
import 'package:swiftvote/screens/vote_page/vote_scaffold.dart';
import 'package:swiftvote/utils/simple_bloc_observer.dart';
import 'package:swiftvote/widgets/loading_indicator.dart';
import 'package:swiftvote/widgets/widgets.dart';
import 'package:swiftvote/utils/swiftvote_widget_keys.dart';
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
//  FirebaseFirestore firestore = FirebaseFirestore.instance;
  runApp(SwiftvoteApp());
}

class SwiftvoteApp extends StatelessWidget {
  Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print("Snapshot had error");
          return Container();
        }

        if (snapshot.connectionState == ConnectionState.done) {
          print("ConnectionState is done");
          return MultiBlocProvider(
            providers: [
              //   BlocBuilder<TabBloc, AppTab>(
              //     builder: (context, activeTab) {
              // return Scaffold(
              // body: getWidget(activeTab),
              // bottomNavigationBar: TabSelector(
              // activeTab: activeTab,
              // onTabSelected: (tab) =>
              // {BlocProvider.of<TabBloc>(context).add(TabUpdated(tab))}),
              // );
              // },
              // );
              BlocProvider<VoteBloc>(
                create: (context) => VoteBloc(
                  voteRepository: FirebaseVoteRepository(),
                )..add(LoadVotesEvent()),
              ),
              BlocProvider<TabBloc>(
                create: (context) => TabBloc(),
              ),
              BlocProvider<ExploreBloc>(
                create: (context) => ExploreBloc(
                  voteBloc: BlocProvider.of<VoteBloc>(context),
                )..add(
                    ExploreCategoriesLoadedEvent(),
                  ),
              ),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'SwiftVote',
              routes: {
                Routes.home: (context) => AppScreen(),
                Routes.addVoteSCreen: (context) {
                  return AddVoteScreen(
                    key: SwiftvoteWidgetKeys.addVoteScreen,
                    isEditing: false,
                    onSave: (title, category, voteOptionOne, voteOptionTwo, tags) {
                      BlocProvider.of<VoteBloc>(context).add(AddVoteEvent(Vote(
                          title: title,
                          author: 'Swiftvote',
                          category: category,
                          sponsor: "",
                          voteOptions: [voteOptionOne, voteOptionTwo],
                          votes: [0, 0],
                          tags: tags)));
                    },
                  );
                },
              },
            ),
          );
        }

        return LoadingIndicator();
      },
    );
  }
}
