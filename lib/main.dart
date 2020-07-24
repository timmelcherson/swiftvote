import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/blocs.dart';

import 'package:swiftvote/utils/routes.dart';
import 'package:swiftvote/screens/screens.dart';

void main() => runApp(SwiftvoteApp());

class SwiftvoteApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SwiftVote',
      routes: {
        Routes.home : (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<TabBloc>(
                create: (context) => TabBloc(),
              ),
            ],
            child: AppScreen(),
          );
        }
      },
    );
  }

}

//void main = () => runApp(App());
