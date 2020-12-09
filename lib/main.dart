import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swiftvote/blocs/vote/vote.dart';
import 'package:swiftvote/data/models.dart';
import 'package:swiftvote/data/repositories.dart';
import 'package:swiftvote/data/repositories/user_repository.dart';
import 'package:swiftvote/global_widgets/global_widgets_barrel.dart';
import 'package:swiftvote/screens/intro_page/intro_screen.dart';
import 'package:swiftvote/utils/shared_preferences_handler.dart';
import 'package:swiftvote/utils/simple_bloc_observer.dart';
import 'package:swiftvote/constants/swiftvote_widget_keys.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:swiftvote/blocs/blocs.dart';
import 'package:swiftvote/constants/routes.dart';
import 'package:swiftvote/screens/screens.dart';

Future<void> main() async {
  Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(SwiftvoteApp());
}

class SwiftvoteApp extends StatelessWidget {
  final Future<FirebaseApp> _firebaseInit = Firebase.initializeApp();

  // final Future<FirebaseAuth> _authInit = FirebaseAuth
  // bool _skipLogin = false;

  @override
  Widget build(BuildContext context) {
    // bool test = _sharedPrefs.getBool("device_has_displayed_intro") ?? false;
    // print('user has seen intro: $test');
    return FutureBuilder(
      future: Future.wait([
        _firebaseInit,
      ]),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          // if (snapshot.hasData) {
          //   _skipLogin = snapshot.data[1];
          // }
          return MultiBlocProvider(
            providers: [
              BlocProvider<AuthenticationBloc>(
                create: (context) => AuthenticationBloc(
                  userRepository: UserRepository(),
                  userProfileRepository: UserProfileRepository(),
                )..add(AuthenticationStartedEvent()),
              ),
              BlocProvider<VoteBloc>(
                create: (context) => VoteBloc(
                  voteRepository: VoteRepository(),
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
            child: GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                print(currentFocus.focusedChild);
                print(currentFocus.hasPrimaryFocus);
                if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
                  currentFocus.focusedChild.unfocus();
                }
                // if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
                //   FocusManager.instance.primaryFocus.unfocus();
                // }
              },
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'swiftvote',
                initialRoute: Routes.LOGIN,
                routes: {
                  Routes.LOGIN: (context) {
                    print('MAIN ROUTE LOGIN');
                    print(_firebaseInit);
                    return IntroScreen(userProfileRepository: UserProfileRepository());
                  },
                  Routes.HOME: (context) {
                    print('MAIN ROUTE HOME');
                    return AppScreen();
                  },
                  Routes.ADD_VOTE_SCREEN: (context) {
                    return AddVoteScreen(
                      key: SwiftvoteWidgetKeys.addVoteScreen,
                      isEditing: false,
                      onSave: (title, categories, voteOptionOne, voteOptionTwo, tags) {
                        BlocProvider.of<VoteBloc>(context).add(AddVoteEvent(Vote(
                            title: title,
                            author: 'swiftvote',
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
            ),
          );
        }
        return LoadingIndicator();
      },
    );
  }
}
