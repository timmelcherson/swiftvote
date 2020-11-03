import 'package:flutter/material.dart';
import 'package:swiftvote/screens/intro_page/intro_barrel.dart';
import 'package:swiftvote/themes/themes.dart';
import 'package:swiftvote/utils/routes.dart';

class IntroWidget extends StatefulWidget {
  final introScreenNavigatorKey = GlobalKey<NavigatorState>();

  IntroWidget();

  @override
  State createState() => _IntroWidgetState();
}

class _IntroWidgetState extends State<IntroWidget> {
  GlobalKey _navigatorKey;

  @override
  void initState() {
    _navigatorKey = widget.introScreenNavigatorKey;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Navigator(
          key: _navigatorKey,
          initialRoute: Routes.home,
          onGenerateRoute: (RouteSettings settings) {
            Widget currentWidget;

            if (settings.name == null) {
              return null;
            }

            return PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => currentWidget);
          },
          // child: Container(
          //   width: MediaQuery.of(context).size.width,
          //   height: MediaQuery.of(context).size.height,
          //   padding: EdgeInsets.fromLTRB(32.0, 64.0, 32.0, 32.0),
          //   color: Colors.white,
          //   child: Column(
          //     mainAxisSize: MainAxisSize.max,
          //     children: [
          //       Expanded(
          //         child: Text(
          //           'Welcome to Swiftvote',
          //           style: TextThemes.largeTitleTextStyle,
          //         ),
          //       ),
          //       FractionallySizedBox(
          //         widthFactor: 0.9,
          //         child: FlatButton(
          //           padding: EdgeInsets.symmetric(vertical: 12.0),
          //           child: Text(
          //             'Log in',
          //             style: TextThemes.smallBrightTextStyle,
          //           ),
          //           onPressed: () => {print('LOG IN')},
          //           color: ColorThemes.primaryColor,
          //         ),
          //       ),
          //       FractionallySizedBox(
          //         widthFactor: 0.9,
          //         child: Container(
          //           margin: EdgeInsets.only(top: 12.0),
          //           child: FlatButton(
          //             padding: EdgeInsets.symmetric(vertical: 12.0),
          //             child: Text(
          //               'Create an account',
          //               style: TextThemes.smallDarkTextStyle,
          //             ),
          //             onPressed: () => {print('SIGN UP')},
          //             color: ColorThemes.secondaryColor,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ),
      ),
    );
  }
}
