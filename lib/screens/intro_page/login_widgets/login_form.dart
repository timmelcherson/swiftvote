import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swiftvote/blocs/blocs.dart';
import 'package:swiftvote/data/repositories/user_repository.dart';
import 'package:swiftvote/themes/themes.dart';
import 'file:///C:/Users/Tim/Documents/Programmering/flutter/swiftvote/swiftvote/lib/constants/routes.dart';
import 'file:///C:/Users/Tim/Documents/Programmering/flutter/swiftvote/swiftvote/lib/constants/swiftvote_widget_keys.dart';

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

  LoginBloc _loginBloc;
  bool _obscureText = true;

  bool get isPopulated => _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isButtonEnabled(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_emailChangeHandler);
    _passwordController.addListener(_passwordChangeHandler);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isFailure) {
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
                backgroundColor: ColorThemes.primaryColor,
              ),
            );
        }

        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(
            AuthenticationLogInEvent(),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
            child: Form(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    child: FractionallySizedBox(
                      widthFactor: 1.0,
                      child: Text(
                        'Log in',
                        style: TextThemes.largeTitleTextStyle,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  Column(
                    children: [
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
                          suffix: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            child: Text(
                              _obscureText ? 'show' : 'hide',
                              style: TextThemes.smallDarkTextStyle,
                            ),
                          ),
                          hintText: 'Password',
                          hintStyle: TextThemes.textHintStyle,
                        ),
                        obscureText: _obscureText,
                        autovalidateMode: AutovalidateMode.disabled,
                        autocorrect: false,
                        validator: (_) {
                          return !state.isPasswordValid ? 'Invalid password' : null;
                        },
                      ),
                    ],
                  ),
                  Column(
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
