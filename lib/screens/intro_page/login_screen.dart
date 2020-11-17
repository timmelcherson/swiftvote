import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swiftvote/blocs/blocs.dart';
import 'package:swiftvote/data/repositories/user_repository.dart';
import 'file:///C:/Users/Tim/Documents/Programmering/flutter/swiftvote/swiftvote/lib/constants/swiftvote_widget_keys.dart';
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
      child: SizedBox.expand(
        child: SingleChildScrollView(
          child: LoginForm(),
        ),
      ),
    );
  }
}