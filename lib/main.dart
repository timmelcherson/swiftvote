import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:swiftvote/blocs/vote/vote.dart';
import 'package:swiftvote/repositories/vote_repository.dart';
import 'package:swiftvote/utils/file_storage.dart';
import 'package:swiftvote/utils/simple_bloc_observer.dart';
import 'package:swiftvote/widgets/widgets.dart';

import 'blocs/blocs.dart';

import 'package:swiftvote/utils/routes.dart';
import 'package:swiftvote/screens/screens.dart';

//'__flutter_bloc_app__'

void main() {
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
  runApp(SwiftvoteApp());
}

class SwiftvoteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SwiftVote',
      routes: {
        Routes.home: (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<TabBloc>(
                create: (context) => TabBloc(),
              ),
              BlocProvider<VoteBloc>(
                create: (context) => VoteBloc(
                  voteRepository: const VoteRepository(
                    fileStorage: const FileStorage(
                      '__swiftvote_app_filestorage__',
                      getApplicationDocumentsDirectory,
                    ),
                  ),
                )..add(VoteLoaded()),
              ),
              BlocProvider<ExploreBloc>(
                create: (context) => ExploreBloc()..add(ExploreLoaded(),
              ))
            ],
            child: AppScreen(),
          );
        },
      },
    );
  }
}
