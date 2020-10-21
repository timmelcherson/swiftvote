import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swiftvote/blocs/vote/vote.dart';
import 'package:swiftvote/data/models.dart';
import 'package:swiftvote/data/repositories.dart';
import 'package:swiftvote/global_widgets/global_widgets_barrel.dart';
import 'package:swiftvote/screens/intro_page/intro_widget.dart';
import 'package:swiftvote/utils/simple_bloc_observer.dart';
import 'package:swiftvote/utils/swiftvote_widget_keys.dart';
import 'package:firebase_core/firebase_core.dart';
import 'blocs/blocs.dart';
import 'package:swiftvote/utils/routes.dart';
import 'package:swiftvote/screens/screens.dart';

Future<void> main() async {
  Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(SwiftvoteApp());
}

class SwiftvoteApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  // final Future<SharedPreferences> _sharedPrefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {

    // initializePrefs();

    return FutureBuilder(
      future: _initialization,
      builder: (context, firebaseSnapshot) {
        if (firebaseSnapshot.hasError) {
          return Container();
        }
        if (firebaseSnapshot.connectionState == ConnectionState.done) {
          return MultiBlocProvider(
            providers: [
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
                Routes.home: (context) {


                  // getBooleanPreference('intro_screen_has_been_presented')
                  //   .then((result) => result ? AppScreen() : IntroWidget());

                  return AppScreen();
                  // return _isIntroSeen ? AppScreen() : IntroWidget();
                },
                Routes.addVoteSCreen: (context) {
                  return AddVoteScreen(
                    key: SwiftvoteWidgetKeys.addVoteScreen,
                    isEditing: false,
                    onSave: (title, categories, voteOptionOne, voteOptionTwo, tags) {
                      BlocProvider.of<VoteBloc>(context).add(AddVoteEvent(Vote(
                          title: title,
                          author: 'Swiftvote',
                          categories: categories,
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

  initializePrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('intro_screen_has_been_presented'))
      prefs.setBool('intro_screen_has_been_presented', false);
    return;
  }

  Future<bool> getBooleanPreference(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }
}
