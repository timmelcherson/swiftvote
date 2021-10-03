import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swiftvote/app_localization.dart';
import 'package:swiftvote/blocs/navigation/navigation.dart';
import 'package:swiftvote/blocs/vote/vote.dart';
import 'package:swiftvote/blocs/vote_comments/vote_comments.dart';
import 'package:swiftvote/data/repositories.dart';
import 'package:swiftvote/data/repositories/user_repository.dart';
import 'package:swiftvote/global_widgets/global_widgets_barrel.dart';
import 'package:swiftvote/screens/vote_result/vote_result_screen.dart';
import 'package:swiftvote/screens/vote_screen/vote_comments_screen.dart';
import 'package:swiftvote/themes/themes.dart';
import 'package:swiftvote/utils/simple_bloc_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:swiftvote/blocs/blocs.dart';
import 'package:swiftvote/constants/routes.dart';
import 'package:swiftvote/screens/screens.dart';

Future<void> main() async {
  Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(SwiftvoteApp());
}

class SwiftvoteApp extends StatefulWidget {
  @override
  _SwiftvoteAppState createState() => _SwiftvoteAppState();
}

class _SwiftvoteAppState extends State<SwiftvoteApp> {
  final Future<FirebaseApp> _firebaseInit = Firebase.initializeApp();
  bool _hasRegisteredInfo;

  @override
  void initState() {
    super.initState();
    _loadSharedPreferences();
  }

  //Loading counter value on start
  void _loadSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _hasRegisteredInfo =
          (prefs.getBool('device_has_displayed_intro') ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
    // print('user has seen intro: $test');

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

          print("-------------------");
          print(_hasRegisteredInfo);
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
                  lazy: false,
                  create: (context) => NavigationBloc(),
                ),
                BlocProvider<UserProfileBloc>(
                  lazy: false,
                  create: (context) => UserProfileBloc(
                    userProfileRepository:
                        RepositoryProvider.of<UserProfileRepository>(context),
                  ),
                ),
                BlocProvider<VoteBloc>(
                  create: (context) => VoteBloc(
                    voteRepository:
                        RepositoryProvider.of<VoteRepository>(context),
                  )..add(LoadVotesEvent()),
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
              child: GestureDetector(
                onTap: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus &&
                      currentFocus.focusedChild != null) {
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
                  initialRoute:
                      _hasRegisteredInfo ? Routes.VOTE : Routes.REGISTER,
                  routes: {
                    // Routes.LOGIN: (context) {
                    //   return LoginScreen();
                    // },
                    Routes.REGISTER: (context) {
                      return RegisterScreen();
                    },
                    // Routes.HOME: (context) {
                    //   print('MAIN ROUTE HOME');
                    //   return AppScreen();
                    // },
                    // Routes.VOTE_RESULT: {},
                    // Routes.EXPLORE: (context) {
                    //   return ExploreScreen();
                    // },
                    // Routes.EXPLORE_CATEGORY: (context) {
                    //   return CategoryExplorer();
                    // },
                    // Routes.SEARCH: (context) {
                    //   return SearchScreen();
                    // },
                    Routes.VOTE: (context) {
                      print("ROUTE VOTE");
                      return VoteScreen();
                    },
                    Routes.VOTE_COMMENTS: (context) {
                      return VoteCommentsScreen();
                    },
                    Routes.VOTE_RESULT: (context) {
                      return VoteResultScreen();
                    },
                    // Routes.NOTIFICATIONS: (context) {
                    //   return NotificationsScreen();
                    // },
                    Routes.SETTINGS: (context) {
                      return SettingsScreen();
                    },
                    Routes.ADD_VOTE: (context) {
                      return AddVoteScreen();
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
