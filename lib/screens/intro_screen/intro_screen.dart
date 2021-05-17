import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swiftvote/blocs/blocs.dart';
import 'package:swiftvote/constants/routes.dart';
import 'package:swiftvote/constants/shared_preference_keys.dart';
import 'package:swiftvote/data/repositories.dart';
import 'package:swiftvote/global_widgets/global_widgets_barrel.dart';
import 'package:swiftvote/themes/color_themes.dart';
import 'package:swiftvote/utils/shared_preferences_handler.dart';
import 'package:swiftvote/screens/screens.dart';

class IntroScreen extends StatefulWidget {
  final UserRepository userRepository = UserRepository();
  final UserProfileRepository userProfileRepository;

  IntroScreen({@required this.userProfileRepository});

  @override
  State createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  UserRepository _userRepository;
  UserProfileRepository _userProfileRepository;
  bool _showRegister = false;

  @override
  void initState() {
    super.initState();
    _userRepository = widget.userRepository;
    _userProfileRepository = widget.userProfileRepository;
  }

  Future<bool> _initializeSharedPreferences() async {
    return await SharedPreferencesHandler.readBool(SharedPreferenceKeys.DEVICE_HAS_DISPLAYED_INTRO);
  }

  void onRegisterCallback(bool showRegister) {
    setState(() => _showRegister = showRegister);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_BG,
      body: FutureBuilder(
        future: _initializeSharedPreferences(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Container();
          }

          if (snapshot.connectionState == ConnectionState.done) {
            bool _skipToHome;

            if (snapshot.hasData) {
              // _skipToHome = snapshot.data;
              _skipToHome = true;
            }

            return BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                print('INTRO SCREEN STATE: $state');

                if (state is AuthInitialState) {
                  return LoginScreen();
                }
                if (state is AuthSuccessState) {
                  print('SKIP TO HOME? $_skipToHome');
                  if (_skipToHome) {
                    return LoadingIndicator();
                  }
                  return RegisterOptionalScreen();
                }
                if (state is AuthFailState) {
                  return Center(
                    child: Text('AUTH FAIL'),
                  );
                  // if (_showRegister) {
                  //   return RegisterScreen(
                  //     userRepository: _userRepository,
                  //     userProfileRepository: _userProfileRepository,
                  //   );
                  // }
                  // return LoginScreen(
                  //   userRepository: _userRepository,
                  //   userProfileRepository: _userProfileRepository,
                  //   registerCallback: onRegisterCallback,
                  // );
                }
                return LoadingIndicator();
              },
            );
          }
          return LoadingIndicator();
        },
      ),
    );
  }
}
