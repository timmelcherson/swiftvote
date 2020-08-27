import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swiftvote/data/models.dart';
import 'package:swiftvote/utils/swiftvote_widget_keys.dart';
import 'package:swiftvote/utils/swiftvote_theme.dart';
import 'package:swiftvote/blocs/blocs.dart';
import 'package:swiftvote/widgets/loading_indicator.dart';

import 'explore_barrel.dart';

class ExploreWidget extends StatelessWidget {
  ExploreWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExploreBloc, ExploreState>(
      builder: (context, state) {
        if (state is ExploreCategoriesLoadInProgress) {
          return LoadingIndicator(key: SwiftvoteWidgetKeys.loadingIndicator);
        } else if (state is ExploreCategoriesLoadSuccess) {
          final categories = state.categories;
          final categoryThumbnailAssetPath = state.categoryImagesPaths;

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
                                              headerImagePath:
                                                  categoryThumbnailAssetPath[
                                                      index],
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
                                        margin: EdgeInsets.fromLTRB(
                                            8.0, 0, 0, 16.0),
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
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Color.fromRGBO(255, 253, 245, 1),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              alignment: Alignment.bottomLeft,
              margin: EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 16.0),
              child: Text(
                'Explore',
                style: SwiftvoteTheme.largeTitleTextStyle,
                textAlign: TextAlign.end,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;

  @override
  double get maxExtent => 90.0;

  @override
  double get minExtent => 80.0;
}
