import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swiftvote/app_localization.dart';
import 'package:swiftvote/blocs/blocs.dart';
import 'package:swiftvote/constants/routes.dart';
import 'package:swiftvote/global_widgets/buttons/custom_button.dart';
import 'package:swiftvote/global_widgets/custom_text_input.dart';
import 'package:swiftvote/themes/themes.dart';

typedef ShowRegisterCallback = Function(bool showRegister);

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  AuthBloc _authBloc;

  bool get isPopulated => _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isButtonEnabled() {
    // return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _emailController.addListener(_emailChangeHandler);
    _passwordController.addListener(_passwordChangeHandler);

    _authBloc.stream.listen((state) {
      if (state is AuthSuccessState) {
        Navigator.of(context).pushNamed(Routes.VOTE);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_BG,
      body: BlocBuilder(
        bloc: _authBloc,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              child: ListView(
                // mainAxisSize: MainAxisSize.max,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 32.0),
                    child: FractionallySizedBox(
                      widthFactor: 1.0,
                      child: Text(
                        trans(context, 'login_screen.header'),
                        style: largeTitleStyle(color: DARK_GRAY),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 64.0),
                    child: Column(
                      children: [
                        CustomTextInput(
                          controller: _emailController,
                          hintText: 'Email',
                          icon: Icon(Icons.email, color: PRIMARY_BLUE),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        TextFormField(
                          autocorrect: false,
                          autovalidateMode: AutovalidateMode.disabled,
                          controller: _passwordController,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: PRIMARY_BLUE, width: 2.0),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: PRIMARY_BLUE, width: 2.0),
                            ),
                            hintStyle: hintStyle(),
                            hintText: 'Password',
                            icon: Icon(Icons.vpn_key, color: PRIMARY_BLUE),
                            suffix: GestureDetector(
                              onTap: () => setState(() => _obscureText = !_obscureText),
                              child: Text(
                                _obscureText ? 'show' : 'hide',
                                style: bodyStyle(color: DARK_GRAY),
                              ),
                            ),
                          ),
                          obscureText: _obscureText,
                          style: bodyStyle(),
                          validator: (_) {
                            return 'Invalid password';
                            // return !state.isPasswordValid ? 'Invalid password' : null;
                          },
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      CustomButton(
                        buttonText: trans(context, 'button.login'),
                        margin: EdgeInsets.symmetric(horizontal: 0, vertical: 8.0),
                        onPress: _formSubmitHandler,
                      ),
                      CustomButton(
                        buttonText: trans(context, 'button.register'),
                        margin: EdgeInsets.symmetric(horizontal: 0, vertical: 4.0),
                        onPress: () => Navigator.of(context).pushNamed(Routes.REGISTER),
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
    // print(_emailController.text);
  }

  void _passwordChangeHandler() {
    // print(_passwordController.text);
  }

  void _formSubmitHandler() {
    BlocProvider.of<AuthBloc>(context).add(AuthLogInEvent(
      email: _emailController.text,
      password: _passwordController.text,
    ));
  }

// return LayoutBuilder(
//   builder: (context, constraint) {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: EdgeInsets.symmetric(vertical: _safeAreaPadding, horizontal: 16.0),
//         child: ConstrainedBox(
//           constraints: BoxConstraints(
//               minHeight: MediaQuery.of(context).size.height - 2 * _safeAreaPadding),
//           child: IntrinsicHeight(
//             child: Column(
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 Expanded(child: LoginForm()),
//                 Container(
//                   height: 50.0,
//                   width: constraint.maxWidth,
//                   child: FractionallySizedBox(
//                     widthFactor: 0.9,
//                     child: FlatButton(
//                       color: OFF_WHITE,
//                       child: Text(
//                         'Register',
//                         style: bodyStyle(color: DARK_GRAY),
//                       ),
//                       onPressed: () {
//                         print('LOGIN SCREEN REGISTER CALLBACK');
//                         this.registerCallback(true);
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   },
// );
}
