import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swiftvote/blocs/blocs.dart';
import 'package:swiftvote/data/repositories.dart';
import 'package:swiftvote/data/repositories/user_repository.dart';
import 'package:swiftvote/constants/swiftvote_widget_keys.dart';
import 'package:swiftvote/screens/screens.dart';
import 'package:swiftvote/themes/themes.dart';

typedef ShowRegisterCallback = Function(bool showRegister);

class LoginScreen extends StatelessWidget {
  final UserRepository userRepository;
  final UserProfileRepository userProfileRepository;
  final ShowRegisterCallback registerCallback;

  const LoginScreen(
      {Key key,
      @required this.userRepository,
      @required this.userProfileRepository,
      @required this.registerCallback});

  @override
  Widget build(BuildContext context) {
    double _safeAreaPadding = MediaQuery.of(context).padding.top;

    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(
        userRepository: this.userRepository,
        userProfileRepository: userProfileRepository,
      ),
      child: LayoutBuilder(
        builder: (context, constraint) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: _safeAreaPadding, horizontal: 16.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height - 2 * _safeAreaPadding),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(child: LoginForm()),
                      Container(
                        height: 50.0,
                        width: constraint.maxWidth,
                        child: FractionallySizedBox(
                          widthFactor: 0.9,
                          child: FlatButton(
                            color: ColorThemes.OFF_WHITE,
                            child: Text(
                              'Register',
                              style: TextThemes.TINY_DARK_GRAY,
                            ),
                            onPressed: () {
                              print('LOGIN SCREEN REGISTER CALLBACK');
                              this.registerCallback(true);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
