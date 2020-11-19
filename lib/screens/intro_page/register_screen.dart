import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swiftvote/blocs/blocs.dart';
import 'package:swiftvote/constants/shared_preference_keys.dart';
import 'package:swiftvote/data/repositories/user_repository.dart';
import 'package:swiftvote/screens/intro_page/intro_barrel.dart';
import 'package:swiftvote/themes/themes.dart';
import 'package:swiftvote/constants/routes.dart';
import 'package:swiftvote/utils/shared_preferences_handler.dart';

class RegisterScreen extends StatefulWidget {
  final UserRepository userRepository;
  final bool hasRegistered;

  const RegisterScreen({Key key, UserRepository userRepository, this.hasRegistered})
      : userRepository = userRepository,
        super(key: key);

  @override
  State createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  UserRepository _userRepository;
  int _activeIndex;

  List<Widget> _activeWidget = [
    RegisterForm(),
    RegisterGender(),
    RegisterDob(),
    RegisterLocation(),
    RegisterLanguages(),
    RegisterInterests(),
  ];

  @override
  void initState() {
    super.initState();
    _userRepository = widget.userRepository;
    _activeIndex = widget.hasRegistered ? 1 : 0;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterBloc>(
      create: (context) => RegisterBloc(userRepository: _userRepository),
      child: LayoutBuilder(
        builder: (context, constraint) {
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraint.maxHeight),
                child: IntrinsicHeight(
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
                            _activeIndex == 0 ? MainAxisAlignment.start : MainAxisAlignment.end,
                        children: [
                          if (_activeIndex == 0)
                            IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                size: 28.0,
                              ),
                              onPressed: () {
                                Navigator.of(context).pushNamed(Routes.login);
                              },
                            ),
                          if (_activeIndex != 0 && _activeIndex <= _activeWidget.length - 1)
                            TextButton(
                              onPressed: () {
                                SharedPreferencesHandler.save(
                                    SharedPreferenceKeys.DEVICE_HAS_DISPLAYED_INTRO, true);
                                Navigator.of(context, rootNavigator: true).pushNamed(Routes.home);
                              },
                              child: Text(
                                'Skip',
                                style: TextThemes.smallDarkTextStyle,
                              ),
                            ),
                        ],
                      ),
                      _activeIndex == 0 ? RegisterForm() : _activeWidget[_activeIndex],

                      if (_activeIndex != 0)
                        FractionallySizedBox(
                          widthFactor: 0.9,
                          child: FlatButton(
                            padding: EdgeInsets.symmetric(vertical: 12.0),
                            color: ColorThemes.primaryColor,
                            child: Text(
                              _activeIndex < (_activeWidget.length - 1) ? 'Next' : "Let's go",
                              style: TextThemes.smallBrightTextStyle,
                            ),
                            onPressed: () {
                              updateProgress();
                            },
                          ),
                        ),
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

  updateProgress() {
    if (_activeIndex == (_activeWidget.length - 1)) {
      SharedPreferencesHandler.save(SharedPreferenceKeys.DEVICE_HAS_DISPLAYED_INTRO, true);
      Navigator.of(context, rootNavigator: true).pushNamed(Routes.home);
    } else {
      setState(() {
        _activeIndex++;
      });
    }
  }

  renderProgressCircles() {
    List<Widget> circleList = List();

    for (int i = 0; i < 6; i++) {
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
