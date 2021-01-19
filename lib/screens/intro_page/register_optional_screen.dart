import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swiftvote/blocs/blocs.dart';
import 'package:swiftvote/constants/routes.dart';
import 'package:swiftvote/constants/shared_preference_keys.dart';
import 'package:swiftvote/data/models/user_profile_model.dart';
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
  UserProfile _userProfile;

  String updatedGender;

  List<String> _childWidgetIdentifiers = [
    'GENDER_WIDGET',
    'DOB_WIDGET',
    'INTERESTS_WIDGET',
    'LANGUAGES_WIDGET',
    'LOCATION_WIDGET',
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

        print('IN SCREEN STATE IS: $state');

        if (state is UserProfileLoadingState) {
          return LoadingIndicator();
        }

        if (state is UserIdReceivedState) {
          if (state.userId != null) _userProfileBloc.add(UserIdReceivedEvent(state.userId));
          return LoadingIndicator();
        }

        if (state is UserProfileCreatedState) {
          _userProfile = state.userProfile;

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
                        _userProfileBloc.add(UserProfileUpdatedEvent(_userProfile, updateDB: true));
                        SharedPreferencesHandler.save(
                            SharedPreferenceKeys.DEVICE_HAS_DISPLAYED_INTRO, true);
                        Navigator.of(context, rootNavigator: true).pushNamed(Routes.HOME);
                      },
                      child: Text(
                        'Skip',
                        style: TextThemes.TINY_DARK_GRAY,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: getWidget(),
                ),
                FractionallySizedBox(
                  widthFactor: 0.9,
                  child: FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    color: ColorThemes.PRIMARY_BLUE,
                    child: Text(
                      _activeIndex < (_childWidgetIdentifiers.length - 1) ? 'Next' : "Let's go",
                      style: TextThemes.TINY_WHITE,
                    ),
                    onPressed: () {
                      progressForward();
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return Text('SOMETHING WENT WRONG');
        }
      },
    );
  }

  progressForward() {
    if (_activeIndex == (_childWidgetIdentifiers.length - 1)) {
      SharedPreferencesHandler.save(SharedPreferenceKeys.DEVICE_HAS_DISPLAYED_INTRO, true);
      _userProfileBloc.add(UserProfileUpdatedEvent(_userProfile, updateDB: true));
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

  void genderCallback(String gender) {
    print('GENDER CALLBACK WITH: $gender');
    if (_userProfile != null) {
      var _updatedProfile = _userProfile.copyWith(gender: gender);
      print('_updatedProfile: $_updatedProfile');
      _userProfileBloc.add(UserProfileUpdatedEvent(_updatedProfile));
    }
  }

  void dobCallback(String dob) {
    print(dob);
    if (_userProfile != null)
      _userProfileBloc.add(UserProfileUpdatedEvent(_userProfile.copyWith(dob: dob)));
  }

  void interestsCallback(List<String> interests) {
    if (_userProfile != null)
      _userProfileBloc.add(UserProfileUpdatedEvent(_userProfile.copyWith(interests: interests)));
  }

  void languagesCallback(List<String> languages) {
    if (_userProfile != null)
      _userProfileBloc.add(UserProfileUpdatedEvent(_userProfile.copyWith(languages: languages)));
  }

  void locationCallback(String location) {
    if (_userProfile != null)
      _userProfileBloc.add(UserProfileUpdatedEvent(_userProfile.copyWith(location: location)));
  }

  Widget getWidget() {
    switch (_childWidgetIdentifiers[_activeIndex]) {
      case 'GENDER_WIDGET':
        return RegisterOptionalGender(
            genderScreenCallback: (String gender) => genderCallback(gender));
      case 'DOB_WIDGET':
        return RegisterOptionalDob(dobScreenCallback: (String dob) => dobCallback(dob));
      case 'INTERESTS_WIDGET':
        return RegisterOptionalInterests(
            interestsScreenCallback: (List<String> interests) => interestsCallback(interests));
      case 'LANGUAGES_WIDGET':
        return RegisterOptionalLanguages(
            languagesScreenCallback: (List<String> languages) => languagesCallback(languages));
      case 'LOCATION_WIDGET':
        return RegisterOptionalLocation(
            locationScreenCallback: (String location) => locationCallback(location));
      default:
        return RegisterOptionalGender(
            genderScreenCallback: (String gender) => genderCallback(gender));
    }
  }

  renderProgressCircles() {
    List<Widget> circleList = List();

    for (int i = 0; i < _childWidgetIdentifiers.length; i++) {
      Widget w;

      if (i == _activeIndex) {
        w = Container(
          width: 20.0,
          height: 20.0,
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          decoration: new BoxDecoration(
            color: ColorThemes.PRIMARY_BLUE,
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
            color: ColorThemes.OFF_WHITE,
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
                  color: ColorThemes.PRIMARY_BLUE,
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
