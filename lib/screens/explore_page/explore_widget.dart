import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swiftvote/data/models.dart';
import 'package:swiftvote/themes/themes.dart';
import 'package:swiftvote/utils/swiftvote_widget_keys.dart';
import 'package:swiftvote/blocs/blocs.dart';
import 'package:swiftvote/widgets/loading_indicator.dart';
import 'package:swiftvote/widgets/tab_selector.dart';

import 'explore_barrel.dart';

class ExploreWidget extends StatelessWidget {
  ExploreWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExploreBloc, ExploreState>(
      builder: (context, state) {
        if (state is ExploreCategoriesLoadingState) {
          return LoadingIndicator(key: SwiftvoteWidgetKeys.loadingIndicator);
        } else if (state is ExploreCategoriesLoadedState) {
          print('state: $state');
          final votes = state.votes;
          final categories = state.categories;
          final categoryThumbnailAssetPath = state.categoryImagesPaths;

          print('categoreis: $categories');

          return CustomScrollView(
            key: SwiftvoteWidgetKeys.exploreWidget,
            scrollDirection: Axis.vertical,
            slivers: <Widget>[
              SliverPersistentHeader(
                pinned: true,
                delegate: ExploreWidgetHeaderDelegate(),
              ),
              SliverPadding(
                padding: EdgeInsets.all(16),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                  ),
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) => Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CategoryExplorer(
                                              votes: votes,
                                              headerImagePath: categoryThumbnailAssetPath[index],
                                              category: categories[index])),
                                    ),
                                  },
                                  child: Stack(
                                    alignment: Alignment.bottomLeft,
                                    children: <Widget>[
                                      Image.asset(
                                        categoryThumbnailAssetPath[index],
                                      ),
                                      Container(
                                        margin: EdgeInsets.fromLTRB(8.0, 0, 0, 16.0),
                                        child: Text(
                                          categories[index],
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'RobotoMono',
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                      childCount: categoryThumbnailAssetPath.length),
                ),
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class ExploreWidgetHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    double offsetFactor = shrinkOffset / maxExtent;

    return Container(
      color: ColorThemes.lightYellowBackgroundColor,
      child: Stack(
        children: <Widget>[
          Container(
            height: maxExtent,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: ColorThemes.lightYellowBackgroundColor,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Color.fromRGBO(20, 20, 20, offsetFactor),
                  spreadRadius: 2,
                  blurRadius: 15,
                  offset: Offset(0, 3),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 12.0),
              child: Text(
                'Explore',
                style: TextThemes.largeTitleTextStyle,
                textAlign: TextAlign.end,
              ),
            ),
          ),
          // Expanded(
          //   flex: 3,
          //   child: Container(
          //     alignment: Alignment.bottomLeft,
          //     margin: EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 16.0),
          //     decoration: BoxDecoration(
          //       boxShadow: <BoxShadow>[
          //         BoxShadow(
          //           color: Colors.grey.withOpacity(offsetFactor),
          //           spreadRadius: 2,
          //           blurRadius: 15,
          //           offset: Offset(0, 1),
          //         ),
          //       ],
          //     ),
          //     child: Text(
          //       'Explore',
          //       style: TextThemes.largeTitleTextStyle,
          //       textAlign: TextAlign.end,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;

  @override
  double get maxExtent => 150.0;

  @override
  double get minExtent => 70.0;
}
