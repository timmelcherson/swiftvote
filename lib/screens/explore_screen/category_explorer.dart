import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swiftvote/blocs/explore/index.dart';
import 'package:swiftvote/data/models/index.dart';
import 'package:swiftvote/global_widgets/global_widgets_barrel.dart';
import 'package:swiftvote/constants/routes.dart';
import 'package:swiftvote/constants/widget_keys.dart';

class CategoryExplorer extends StatelessWidget {
  // final String headerImagePath;

  // CategoryExplorer({this.headerImagePath});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<ExploreBloc, ExploreState>(
          builder: (context, state) {
            if (state is ExploreCategoryLoadState) {
              return LoadingIndicator();
            }

            if (state is ExploreCategoryLoadedState) {
              return CustomScrollView(
                key: Keys.exploreCategoryWidget,
                scrollDirection: Axis.vertical,
                slivers: <Widget>[
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: CategoryExplorerHeaderDelegate(
                      text: state.category,
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.all(16),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        childAspectRatio: 1,
                      ),
                      delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) => Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: GestureDetector(
                                      onTap: () => {
                                        Navigator.of(context).pushNamed(
                                          Routes.HOME_WITH_VOTE,
                                          arguments: state.votes[index],
                                        ),
                                      },
                                      child: VoteThumbnail(state.votes[index].title),
                                    ),
                                  ),
                                ],
                              ),
                          childCount: state.votes.length),
                    ),
                  ),
                ],
              );
            }

            if (state is ExploreCategoryLoadFailState) {
              return Center(
                child: Text('FAILED'),
              );
            }

            return LoadingIndicator();
          },
        ),
      ),
    );
  }
}

class CategoryExplorerHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String? path;
  final String text;

  CategoryExplorerHeaderDelegate({this.path, required this.text});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    double offsetFactor = shrinkOffset / maxExtent;
    int colorValue = 230 - (offsetFactor * 210).toInt();

    return Stack(
      children: <Widget>[
        // Image.asset(
        //   path,
        //   height: maxExtent,
        //   width: MediaQuery.of(context).size.width,
        //   fit: BoxFit.cover,
        // ),
        Container(
          height: maxExtent,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(offsetFactor),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey.withOpacity(offsetFactor),
                spreadRadius: 2,
                blurRadius: 15,
                offset: Offset(0, 1),
              ),
            ],
          ),
        ),
        IconButton(
          alignment: Alignment.topLeft,
          icon: Icon(
            Icons.arrow_back,
            size: 36.0,
            color: Color.fromRGBO(colorValue, colorValue, colorValue, 1.0),
          ),
          onPressed: () {
            BlocProvider.of<ExploreBloc>(context).add(ExploreCategoryReturnEvent());
            Navigator.pop(context);
          },
        ),
        Container(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 12.0),
            child: Text(
              text,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 28.0,
                fontFamily: 'RobotoMono',
                color: Color.fromRGBO(colorValue, colorValue, colorValue, 1.0),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;

  @override
  double get maxExtent => 220.0;

  @override
  double get minExtent => 55.0;
}
