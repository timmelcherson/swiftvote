import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swiftvote/blocs/blocs.dart';
import 'package:swiftvote/data/repositories/user_repository.dart';
import 'package:swiftvote/global_widgets/global_widgets_barrel.dart';
import 'package:swiftvote/screens/screens.dart';
import 'package:swiftvote/utils/routes.dart';

class IntroWidget extends StatelessWidget {

  final UserRepository _userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<AuthenticationBloc, AuthenticationState> (
            builder: (context, state) {
              if (state is AuthenticationSuccessState) {
                AppScreen();
              }

              if (state is AuthenticationFailState) {
                return LoginWidget(userRepository: _userRepository);
              }

              return LoadingIndicator();
            }
        ),
      ),
    );
  }
}
