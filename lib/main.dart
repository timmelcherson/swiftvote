import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swiftvote/AppInitializer.dart';
import 'package:swiftvote/app_localization.dart';
import 'package:swiftvote/constants/widget_keys.dart';
import 'package:swiftvote/data/repositories/index.dart';
import 'package:swiftvote/global_widgets/global_widgets_barrel.dart';
import 'package:swiftvote/screens/vote_result/vote_result_screen.dart';
import 'package:swiftvote/screens/vote_screen/vote_comments_screen.dart';
import 'package:swiftvote/themes/themes.dart';
import 'package:swiftvote/utils/simple_bloc_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:swiftvote/blocs/index.dart';
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

  @override
  Widget build(BuildContext context) {
    // print('user has seen intro: $test');

    // return BlocBuilder<AuthBloc, AuthState>(
    //     builder: (context, state) {});

    return AppInitializer(
      key: Keys.main,
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {

          if (state is AuthLoadingState) {
            return LoadingIndicator();
          }

          if (state is AuthSuccessState || state is AuthNotRegisteredState) {
            return GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.focusedChild!.unfocus();
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
                    if (supportedLocale.languageCode == locale!.languageCode &&
                        supportedLocale.countryCode == locale.countryCode) {
                      return supportedLocale;
                    }
                  }
                  // English locale fallback
                  return supportedLocales.first;
                },
                initialRoute: state is AuthNotRegisteredState ? Routes.REGISTER : Routes.VOTE,
                routes: {
                  Routes.REGISTER: (context) {
                    return RegisterScreen();
                  },
                  Routes.VOTE: (context) {
                    print("ROUTE VOTE");
                    return VoteScreen(key: Keys.voteScreen);
                  },
                  Routes.VOTE_COMMENTS: (context) {
                    return VoteCommentsScreen();
                  },
                  Routes.VOTE_RESULT: (context) {
                    return VoteResultScreen();
                  },
                  Routes.SETTINGS: (context) {
                    return SettingsScreen();
                  },
                  Routes.ADD_VOTE: (context) {
                    return AddVoteScreen();
                  },
                },
              ),
            );
          }

          return LoadingIndicator();
        },
      ),
    );
  }
}
