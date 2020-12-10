import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swiftvote/blocs/blocs.dart';
import 'package:swiftvote/constants/routes.dart';
import 'package:swiftvote/constants/shared_preference_keys.dart';
import 'package:swiftvote/global_widgets/loading_indicator.dart';
import 'package:swiftvote/screens/intro_page/intro_barrel.dart';
import 'package:swiftvote/themes/themes.dart';
import 'package:swiftvote/utils/shared_preferences_handler.dart';

class RegisterOptionalScreen extends StatefulWidget {

  @override
  State createState() => _RegisterOptionalScreenState();
}

class _RegisterOptionalScreenState extends State<RegisterOptionalScreen> {
  int _activeIndex = 0;
  UserProfileBloc _userProfileBloc;

  String updatedGender;

  List<Widget> _widgetList = [
    RegisterOptionalGender(),
    RegisterOptionalDob(),
    RegisterOptionalInterests(),
    RegisterOptionalLanguages(),
    RegisterOptionalLocation(),
  ];

  @override
  void initState() {
    super.initState();
    _userProfileBloc = BlocProvider.of<UserProfileBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    double _safeAreaPadding = MediaQuery.of(context).padding.top;

    return BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (context, state) {

        if (state is UserProfileLoadingState) {
          print('IN SCREEN STATE IS UserProfileLoadingState: $state');
          return LoadingIndicator();
        }

        if (state is UserProfileLoadedState) {
          print('IN SCREEN STATE IS UserProfileLoadedState: $state');
          if (state.userId != null) _userProfileBloc.add(UserProfileUpdatedEvent(state.userId));
          return LoadingIndicator();
        }

        if (state is UserProfileCreatedState) {
          print('IN SCREEN STATE IS UserProfileCreatedState WITH PROFILE: ${state.userProfile}');
          return Padding(
            padding: EdgeInsets.symmetric(vertical: _safeAreaPadding, horizontal: 16.0),
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: renderProgressCircles(),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment:
                  _activeIndex > 0 ? MainAxisAlignment.spaceBetween : MainAxisAlignment.end,
                  children: [
                    if (_activeIndex > 0)
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          size: 28.0,
                        ),
                        onPressed: () {
                          progressBackward();
                        },
                      ),
                    TextButton(
                      onPressed: () {
                        SharedPreferencesHandler.save(
                            SharedPreferenceKeys.DEVICE_HAS_DISPLAYED_INTRO, true);
                        Navigator.of(context, rootNavigator: true).pushNamed(Routes.HOME);
                      },
                      child: Text(
                        'Skip',
                        style: TextThemes.smallDarkTextStyle,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: _widgetList[_activeIndex],
                ),
                FractionallySizedBox(
                  widthFactor: 0.9,
                  child: FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    color: ColorThemes.primaryColor,
                    child: Text(
                      _activeIndex < (_widgetList.length - 1) ? 'Next' : "Let's go",
                      style: TextThemes.smallBrightTextStyle,
                    ),
                    onPressed: () {
                      progressForward();
                    },
                  ),
                ),
              ],
            ),
          );
        }
        else {
          return Text('SOMETHING WENT WRONG');
        }
      },
    );
  }

  progressForward() {
    if (_activeIndex == (_widgetList.length - 1)) {
      SharedPreferencesHandler.save(SharedPreferenceKeys.DEVICE_HAS_DISPLAYED_INTRO, true);
      Navigator.of(context, rootNavigator: true).pushNamed(Routes.HOME);
    } else {
      setState(() {
        _activeIndex++;
      });
    }
  }

  progressBackward() {
    setState(() {
      _activeIndex--;
    });
  }

  void genderCallback([String data]) {}

  renderProgressCircles() {
    List<Widget> circleList = List();

    for (int i = 0; i < _widgetList.length; i++) {
      Widget w;

      if (i == _activeIndex) {
        w = Container(
          width: 20.0,
          height: 20.0,
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          decoration: new BoxDecoration(
            color: ColorThemes.primaryColor,
            shape: BoxShape.circle,
          ),
        );
      }

      if (i > _activeIndex) {
        w = Container(
          width: 20.0,
          height: 20.0,
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          decoration: new BoxDecoration(
            color: ColorThemes.secondaryColor,
            shape: BoxShape.circle,
            border: Border.all(
              width: 1,
              color: Colors.black.withOpacity(0.2),
            ),
          ),
        );
      }

      if (i < _activeIndex) {
        w = Container(
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          child: Stack(
            children: [
              Container(
                width: 20.0,
                height: 20.0,
                decoration: new BoxDecoration(
                  color: ColorThemes.primaryColor,
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                width: 20.0,
                height: 20.0,
                child: Center(
                  child: Icon(
                    Icons.check,
                    size: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      }

      circleList.add(w);
    }

    return circleList;
  }
}
