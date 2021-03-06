import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:swiftvote/app_localization.dart';
import 'package:swiftvote/blocs/navigation/navigation.dart';
import 'package:swiftvote/blocs/vote/vote.dart';
import 'package:swiftvote/data/models.dart';
import 'package:swiftvote/data/repositories.dart';
import 'package:swiftvote/data/repositories/user_repository.dart';
import 'package:swiftvote/global_widgets/global_widgets_barrel.dart';
import 'package:swiftvote/themes/themes.dart';
import 'package:swiftvote/utils/shared_preferences_handler.dart';
import 'package:swiftvote/utils/simple_bloc_observer.dart';
import 'package:swiftvote/constants/widget_keys.dart';
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
          return MultiRepositoryProvider(
            providers: [
              RepositoryProvider<UserRepository>(
                create: (context) => UserRepository(),
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
                BlocProvider<NavigationBloc>(
                  create: (context) => NavigationBloc(),
                ),
                BlocProvider<AuthenticationBloc>(
                  create: (context) => AuthenticationBloc(
                    userRepository: RepositoryProvider.of<UserRepository>(context),
                  )..add(AuthenticationStartedEvent()),
                ),
                BlocProvider<UserProfileBloc>(
                  create: (context) => UserProfileBloc(
                    authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
                    userProfileRepository: RepositoryProvider.of<UserProfileRepository>(context),
                  )..add(UserProfileLoadingEvent()),
                ),
                BlocProvider<VoteBloc>(
                  create: (context) => VoteBloc(
                    voteRepository: RepositoryProvider.of<VoteRepository>(context),
                  )..add(LoadVotesEvent()),
                ),
                BlocProvider<VoteResultBloc>(
                  create: (context) => VoteResultBloc(
                    voteRepository: RepositoryProvider.of<VoteRepository>(context),
                  ),
                ),
                BlocProvider<ExploreBloc>(
                  create: (context) => ExploreBloc(
                    voteRepository: RepositoryProvider.of<VoteRepository>(context),
                    voteBloc: BlocProvider.of<VoteBloc>(context),
                  )..add(ExploreCategoriesLoadedEvent()),
                ),
                BlocProvider<SearchBloc>(
                  create: (context) => SearchBloc(
                    voteRepository: RepositoryProvider.of<VoteRepository>(context),
                  ),
                ),
              ],
              child: GestureDetector(
                onTap: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);
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
                  theme: primaryAppTheme,
                  supportedLocales: [
                    const Locale('en', 'GB'),
                    const Locale('sv', 'SE'),
                  ],
                  localizationsDelegates: [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  localeResolutionCallback: (locale, supportedLocales) {
                    for (var supportedLocale in supportedLocales) {
                      if (supportedLocale.languageCode == locale.languageCode &&
                          supportedLocale.countryCode == locale.countryCode) {
                        return supportedLocale;
                      }
                    }
                    // English locale fallback
                    return supportedLocales.first;
                  },
                  initialRoute: Routes.VOTE,
                  routes: {
                    Routes.LOGIN: (context) {
                      return IntroScreen(userProfileRepository: UserProfileRepository());
                    },
                    // Routes.HOME: (context) {
                    //   print('MAIN ROUTE HOME');
                    //   return AppScreen();
                    // },
                    // Routes.VOTE_RESULT: {},
                    Routes.EXPLORE: (context) {
                      return ExploreScreen(
                          voteRepository: RepositoryProvider.of<VoteRepository>(context));
                    },
                    Routes.EXPLORE_CATEGORY: (context) {
                      return CategoryExplorer();
                    },
                    Routes.SEARCH: (context) {
                      return SearchScreen();
                    },
                    Routes.VOTE: (context) {
                      return VoteScreen();
                    },
                    Routes.NOTIFICATIONS: (context) {
                      return NotificationsScreen();
                    },
                    Routes.SETTINGS: (context) {
                      return SettingsScreen();
                    },
                    Routes.ADD_VOTE: (context) {
                      return AddVoteScreen(
                        key: Keys.addVoteScreen,
                        isEditing: false,
                        onSave: (title, categories, voteOptionOne, voteOptionTwo, tags) {
                          BlocProvider.of<VoteBloc>(context).add(
                            AddVoteEvent(
                              Vote(
                                title: title,
                                author: 'swiftvote',
                                categories: categories,
                                sponsor: "",
                                voteOptions: [voteOptionOne, voteOptionTwo],
                                totalVotes: 0,
                                tags: tags,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  },
                ),
              ),
            ),
          );
        }
        return LoadingIndicator();
      },
    );
  }
}
