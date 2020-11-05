import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swiftvote/blocs/blocs.dart';
import 'package:swiftvote/data/repositories/user_repository.dart';
import 'package:swiftvote/screens/intro_page/intro_barrel.dart';

class RegisterScreen extends StatelessWidget {

  final UserRepository _userRepository;

  const RegisterScreen({Key key, UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterBloc>(
      create: (context) => RegisterBloc(userRepository: _userRepository),
      child: Container(
        height: double.infinity,
        width: double.infinity,
        child: RegisterForm(),
      ),
    );
  }
}