import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swiftvote/app_localization.dart';
import 'package:swiftvote/blocs/blocs.dart';
import 'package:swiftvote/global_widgets/buttons/custom_button.dart';
import 'package:swiftvote/themes/themes.dart';
import 'package:swiftvote/constants/routes.dart';

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
                      style: bodyStyle(),
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
                      style: bodyStyle(),
                    ),
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  ],
                ),
                backgroundColor: PRIMARY_BLUE,
              ),
            );
        }

        if (state.isSuccess) {
          BlocProvider.of<AuthBloc>(context).add(
            AuthLogInEvent(),
          );
          Navigator.of(context).pop();
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return Form(
            child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: hintStyle(),
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
                          hintText: 'Password',
                          hintStyle: hintStyle(),
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
                          hintText: 'Confirm password',
                          hintStyle: hintStyle(),
                        ),
                        obscureText: true,
                        autovalidateMode: AutovalidateMode.disabled,
                        autocorrect: false,
                        validator: (_) {
                          return !state.isPasswordValid ? 'Invalid confirm password' : null;
                        },
                      ),
                      CustomButton(
                        buttonText: trans(context, "register.lets_go"),
                      ),
                    ],
                  ),
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
