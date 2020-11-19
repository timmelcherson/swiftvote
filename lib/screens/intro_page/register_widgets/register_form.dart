import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swiftvote/blocs/blocs.dart';
import 'package:swiftvote/themes/themes.dart';
import 'file:///C:/Users/Tim/Documents/Programmering/flutter/swiftvote/swiftvote/lib/constants/routes.dart';

class RegisterForm extends StatefulWidget {
  @override
  State createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool get isPopulated => _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isButtonEnabled(RegisterState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  RegisterBloc _registerBloc;

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _emailController.addListener(_emailChangeHandler);
    _passwordController.addListener(_passwordChangeHandler);
    _confirmPasswordController.addListener(_confirmPasswordChangeHandler);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.isFailure) {
          Scaffold.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Register Failure',
                      style: TextThemes.smallBrightTextStyle,
                    ),
                    Icon(Icons.error),
                  ],
                ),
                backgroundColor: Colors.red[300],
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
                    Text(
                      'Registering...',
                      style: TextThemes.smallBrightTextStyle,
                    ),
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
          Navigator.pop(context);
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return Form(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 48.0),
                  child: FractionallySizedBox(
                    widthFactor: 1.0,
                    child: Text(
                      'Create account',
                      style: TextThemes.largeTitleTextStyle,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(4.0, 4.0, 32.0, 0),
                  margin: EdgeInsets.only(bottom: 32.0),
                  child: FractionallySizedBox(
                    widthFactor: 1.0,
                    child: Text(
                      "Don't worry, your account at swiftvote is completely anonymous.",
                      style: TextThemes.smallDarkTextStyle,
                      textAlign: TextAlign.left,
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
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.vpn_key,
                      color: ColorThemes.primaryColor,
                    ),
                    hintText: 'Confirm password',
                    hintStyle: TextThemes.textHintStyle,
                  ),
                  obscureText: true,
                  autovalidateMode: AutovalidateMode.disabled,
                  autocorrect: false,
                  validator: (_) {
                    return !state.isPasswordValid ? 'Invalid confirm password' : null;
                  },
                ),
                Container(
                  margin: EdgeInsets.only(top: 24.0),
                  child: FractionallySizedBox(
                    widthFactor: 0.9,
                    child: FlatButton(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      color: ColorThemes.primaryColor,
                      child: Text(
                        'Register',
                        style: TextThemes.smallBrightTextStyle,
                      ),
                      onPressed: () {
                        _formSubmitHandler();
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _emailChangeHandler() {
    _registerBloc.add(RegisterEmailChangedEvent(email: _emailController.text));
  }

  void _passwordChangeHandler() {
    _registerBloc.add(RegisterPasswordChangedEvent(password: _passwordController.text));
  }

  void _confirmPasswordChangeHandler() {
    _registerBloc
        .add(RegisterConfirmPasswordChangedEvent(password: _confirmPasswordController.text));
  }

  void _formSubmitHandler() {
    if (_passwordController.text == _confirmPasswordController.text) {
      _registerBloc.add(
          RegisterSubmittedEvent(email: _emailController.text, password: _passwordController.text));
    }
  }
}
