import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swiftvote/blocs/blocs.dart';
import 'package:swiftvote/data/repositories/user_repository.dart';
import 'package:swiftvote/utils/swiftvote_widget_keys.dart';
import 'package:swiftvote/screens/screens.dart';

class LoginScreen extends StatelessWidget {

  final UserRepository _userRepository;

  const LoginScreen({UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: SwiftvoteWidgetKeys.loginScreen);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(userRepository: _userRepository),
      child: Container(
        height: double.infinity,
        width: double.infinity,
        child: LoginForm(),
      ),
    );
  }
}