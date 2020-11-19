import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swiftvote/blocs/blocs.dart';
import 'package:swiftvote/constants/shared_preference_keys.dart';
import 'package:swiftvote/data/repositories/user_repository.dart';
import 'package:swiftvote/global_widgets/global_widgets_barrel.dart';
import 'package:swiftvote/utils/shared_preferences_handler.dart';
import 'package:swiftvote/screens/screens.dart';
import 'file:///C:/Users/Tim/Documents/Programmering/flutter/swiftvote/swiftvote/lib/constants/routes.dart';

class IntroScreen extends StatelessWidget {
  final Key _introNavigatorKey = GlobalKey<NavigatorState>();
  final UserRepository _userRepository = UserRepository();
  bool _skipToHome;

  Future<bool> _initializeSharedPreferences() async {
    print('INITIALIZE SHARED PREFS');
    _skipToHome =
        await SharedPreferencesHandler.readBool(SharedPreferenceKeys.DEVICE_HAS_DISPLAYED_INTRO);
    return _skipToHome == null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: _initializeSharedPreferences(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Container();
            }

            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                _skipToHome = snapshot.data;
                print(_skipToHome);
                print('-----------');
              }
              return BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  if (state is AuthenticationSuccessState) {
                    print("AUTHENTICATION STATE IS SUCCESS");
                    // return AppScreen();
                    var user = state.props[0];
                    print('-------------------');
                    print(user);
                    print('-------------------');
                    return _skipToHome
                        ? AppScreen()
                        : RegisterScreen(
                            userRepository: _userRepository,
                            hasRegistered: true,
                          );
                  }

                  if (state is AuthenticationFailState) {
                    print("AUTHENTICATION STATE IS FAILURE");
                    return Container(
                      child: Navigator(
                        key: _introNavigatorKey,
                        initialRoute: Routes.login,
                        onGenerateRoute: (RouteSettings settings) {
                          print(settings);
                          if (settings.name != null) {
                            Widget displayWidget;
                            if (settings.name == Routes.register) {
                              displayWidget = RegisterScreen(
                                userRepository: _userRepository,
                                hasRegistered: false,
                              );
                            }
                            if (settings.name == Routes.login || settings.name == "/") {
                              displayWidget = LoginScreen(userRepository: _userRepository);
                            }

                            return MaterialPageRoute(builder: (context) => displayWidget);
                          }

                          return MaterialPageRoute(
                              builder: (context) => Center(child: Text('SOMETHING WENT WRONG')));
                        },
                      ),
                    );
                  }
                  return LoadingIndicator();
                },
              );
            }
            return LoadingIndicator();
          },
        ),
      ),
    );
  }
}
