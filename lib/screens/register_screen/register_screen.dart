import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swiftvote/app_localization.dart';
import 'package:swiftvote/blocs/blocs.dart';
import 'package:swiftvote/global_widgets/buttons/custom_button.dart';
import 'package:swiftvote/screens/register_screen/register_barrel.dart';
import 'package:swiftvote/themes/themes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key key}) : super(key: key);

  @override
  State createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  UserProfileBloc _userProfileBloc;
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _locationController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _userProfileBloc = BlocProvider.of<UserProfileBloc>(context);
    _ageController.addListener(_ageChangeHandler);
    _genderController.addListener(_genderChangeHandler);
    _locationController.addListener(_locationChangeHandler);
  }

  void _ageChangeHandler() {
    print(_ageController.text);
  }

  void _genderChangeHandler() {
    print(_genderController.text);
  }

  void _locationChangeHandler() {
    print(_locationController.text);
  }

  void _formSubmitHandler() {
    print("ADD USERPROFILE");
    // if (_passwordController.text == _confirmPasswordController.text) {
    //   _userProfileBloc.add(UserProfileCreateEvent());
    // }
  }

  @override
  Widget build(BuildContext context) {
    double _safeAreaPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: SECONDARY_BG,
      body: SafeArea(
        child: BlocBuilder<UserProfileBloc, UserProfileState>(
            builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
                  child: Text(
                    trans(context, 'register.sign_up'),
                    style: smallTitleStyle(),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.all(16.0),
                  child: Text(
                    trans(context, 'register.info'),
                    style: bodyStyle(),
                    textAlign: TextAlign.left,
                  ),
                ),
                Form(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 32.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: _ageController,
                          decoration: InputDecoration(
                            hintText: trans(context, 'input.age'),
                            hintStyle: hintStyle(),
                          ),
                          keyboardType: TextInputType.number,
                          autovalidateMode: AutovalidateMode.disabled,
                          autocorrect: false,
                          // validator: (_) {
                          //   return !state.isEmailValid ? 'Invalid Email' : null;
                          // },
                        ),
                        TextFormField(
                          controller: _genderController,
                          decoration: InputDecoration(
                            hintText: trans(context, 'input.gender'),
                            hintStyle: hintStyle(),
                          ),
                          autovalidateMode: AutovalidateMode.disabled,
                          autocorrect: false,
                          // validator: (_) {
                          //   return !state.isPasswordValid
                          //       ? 'Invalid password'
                          //       : null;
                          // },
                        ),
                        TextFormField(
                          controller: _locationController,
                          decoration: InputDecoration(
                            hintText: trans(context, 'input.location'),
                            hintStyle: hintStyle(),
                          ),
                          autovalidateMode: AutovalidateMode.disabled,
                          autocorrect: false,
                          // validator: (_) {
                          //   return !state.isPasswordValid
                          //       ? 'Invalid confirm password'
                          //       : null;
                          // },
                        ),
                        CustomButton(
                          buttonText: trans(context, "register.lets_go"),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
