import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swiftvote/blocs/blocs.dart';
import 'package:swiftvote/constants/shared_preference_keys.dart';
import 'package:swiftvote/data/repositories/user_repository.dart';
import 'package:swiftvote/screens/intro_page/intro_barrel.dart';
import 'package:swiftvote/screens/intro_page/register_widgets/register_form.dart';
import 'package:swiftvote/themes/themes.dart';
import 'package:swiftvote/constants/routes.dart';
import 'package:swiftvote/utils/shared_preferences_handler.dart';

class RegisterScreen extends StatefulWidget {
  final UserRepository userRepository;

  const RegisterScreen({Key key, UserRepository userRepository})
      : userRepository = userRepository,
        super(key: key);

  @override
  State createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  UserRepository _userRepository;

  @override
  void initState() {
    super.initState();
    _userRepository = widget.userRepository;
  }

  @override
  Widget build(BuildContext context) {
    double _safeAreaPadding = MediaQuery.of(context).padding.top;

    return BlocProvider<RegisterBloc>(
      create: (context) => RegisterBloc(userRepository: _userRepository),
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
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              size: 28.0,
                            ),
                            onPressed: () {
                              Navigator.of(context).pushNamed(Routes.LOGIN);
                            },
                          ),
                        ],
                      ),
                      Expanded(child: RegisterForm()),
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
