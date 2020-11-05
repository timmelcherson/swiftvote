import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swiftvote/blocs/blocs.dart';
import 'package:swiftvote/data/repositories/user_repository.dart';
import 'package:swiftvote/themes/themes.dart';
import 'package:swiftvote/utils/routes.dart';
import 'package:swiftvote/utils/swiftvote_widget_keys.dart';

class LoginForm extends StatefulWidget {
  final UserRepository _userRepository;

  LoginForm({UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: SwiftvoteWidgetKeys.loginForm);

  @override
  State createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool get isPopulated => _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isButtonEnabled(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  LoginBloc _loginBloc;

  @override
  void initState() {
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_emailChangeHandler);
    _passwordController.addListener(_passwordChangeHandler);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isFailure) {
          print("LOGIN STATE IS FAILURE");
          Scaffold.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Login Failure'),
                    Icon(Icons.error),
                  ],
                ),
                backgroundColor: Color(0xffffae88),
              ),
            );
        }

        if (state.isSubmitting) {
          print("LOGIN STATE IS SUBMITTING");
          Scaffold.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Logging In...'),
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  ],
                ),
                backgroundColor: Color(0xffffae88),
              ),
            );
        }

        if (state.isSuccess) {
          print("LOGIN STATE IS SUCCESS");
          BlocProvider.of<AuthenticationBloc>(context).add(
            AuthenticationLogInEvent(),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 32.0),
                      child: FractionallySizedBox(
                        widthFactor: 1.0,
                        child: Text(
                          'Log in',
                          style: TextThemes.largeTitleTextStyle,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.email,
                        color: ColorThemes.primaryColor,
                      ),
                      hintText: 'Email',
                      hintStyle: TextThemes.textHintStyle,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    autovalidateMode: AutovalidateMode.disabled,
                    autocorrect: false,
                    validator: (_) {
                      return !state.isEmailValid ? 'Invalid Email' : null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.vpn_key,
                        color: ColorThemes.primaryColor,
                      ),
                      hintText: 'Password',
                      hintStyle: TextThemes.textHintStyle,
                    ),
                    obscureText: true,
                    autovalidateMode: AutovalidateMode.disabled,
                    autocorrect: false,
                    validator: (_) {
                      return !state.isPasswordValid ? 'Invalid password' : null;
                    },
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 32.0),
                    child: Column(
                      children: [
                        FractionallySizedBox(
                          widthFactor: 0.9,
                          child: FlatButton(
                            padding: EdgeInsets.symmetric(vertical: 12.0),
                            color: ColorThemes.secondaryColor,
                            child: Text(
                              'Register',
                              style: TextThemes.smallDarkTextStyle,
                            ),
                            onPressed: () {
                              Navigator.of(context).pushNamed(Routes.register);
                            },
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: 0.9,
                          child: FlatButton(
                            padding: EdgeInsets.symmetric(vertical: 12.0),
                            color: ColorThemes.primaryColor,
                            child: Text(
                              'Login',
                              style: TextThemes.smallBrightTextStyle,
                            ),
                            onPressed: () {
                              _formSubmitHandler();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void _emailChangeHandler() {
    _loginBloc.add(LoginEmailChange(email: _emailController.text));
  }

  void _passwordChangeHandler() {
    _loginBloc.add(LoginPasswordChange(password: _passwordController.text));
  }

  void _formSubmitHandler() {
    _loginBloc.add(
        LoginWithCredentials(email: _emailController.text, password: _passwordController.text));
  }
}
