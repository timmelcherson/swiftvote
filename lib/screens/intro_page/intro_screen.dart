import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swiftvote/blocs/blocs.dart';
import 'package:swiftvote/data/repositories/user_repository.dart';
import 'package:swiftvote/global_widgets/global_widgets_barrel.dart';
import 'package:swiftvote/screens/screens.dart';
import 'package:swiftvote/utils/routes.dart';

class IntroWidget extends StatelessWidget {
  final Key _introNavigatorKey = GlobalKey<NavigatorState>();
  final UserRepository _userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationSuccessState) {
              print("AUTHENTICATION STATE IS SUCCESS");
              return AppScreen();
            }

            if (state is AuthenticationFailState) {
              print("AUTHENTICATION STATE IS FAILURE");
              return Container(
                child: Navigator(
                  key: _introNavigatorKey,
                  initialRoute: Routes.login,
                  onGenerateRoute: (RouteSettings settings) {
                    print(settings);
                    if (settings.name != null) {
                      Widget displayWidget;
                      if (settings.name == Routes.register) {
                        displayWidget = RegisterScreen(userRepository: _userRepository);
                      }
                      if (settings.name == Routes.login || settings.name == "/") {
                        displayWidget = LoginScreen(userRepository: _userRepository);
                      }

                      return MaterialPageRoute(builder: (context) => displayWidget);
                    }

                    return MaterialPageRoute(
                        builder: (context) => Center(child: Text('SOMETHING WENT WRONG')));
                  },
                ),
              );
            }

            return LoadingIndicator();
          },
        ),
      ),
    );
  }
}
