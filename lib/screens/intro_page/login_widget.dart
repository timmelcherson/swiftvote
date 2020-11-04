import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swiftvote/blocs/blocs.dart';
import 'package:swiftvote/data/repositories/user_repository.dart';
import 'package:swiftvote/utils/swiftvote_widget_keys.dart';

class LoginWidget extends StatelessWidget {

  final UserRepository _userRepository;

  const LoginWidget({UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: SwiftvoteWidgetKeys.loginWidget);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {

          // Finish this and create login form

          return Container();
        }
    );
  }
}