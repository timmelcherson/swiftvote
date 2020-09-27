import 'package:flutter/material.dart';
import 'dart:math';
import 'package:swiftvote/data/models.dart';
import 'package:swiftvote/themes/themes.dart';
import 'package:swiftvote/utils/routes.dart';
import 'package:swiftvote/utils/swiftvote_widget_keys.dart';
import 'package:swiftvote/widgets/widgets.dart';

import '../screens.dart';

class CategoryExplorer extends StatelessWidget {
  final List<Vote> votes;
  final String headerImagePath;
  final String category;

  CategoryExplorer({this.votes, this.headerImagePath, this.category});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          key: SwiftvoteWidgetKeys.exploreCategoryWidget,
          scrollDirection: Axis.vertical,
          slivers: <Widget>[
            SliverPersistentHeader(
              pinned: true,
              delegate: CategoryExplorerHeaderDelegate(headerImagePath, category),
            ),
            SliverPadding(
              padding: EdgeInsets.all(16),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 2,
                  childAspectRatio: 1.2,
                ),
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) => Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () => {
                                  Navigator.of(context).pushNamed(
                                    Routes.homeWithSelectedVote,
                                    arguments: votes[index],
                                  ),
                                },
                                child: VoteThumbnail(votes[index].title),
                              ),
                            ),
                          ],
                        ),
                    childCount: votes.length),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryExplorerHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String path;
  final String text;

  CategoryExplorerHeaderDelegate(this.path, this.text);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    double offsetFactor = shrinkOffset / maxExtent;
    int colorValue = 230 - (offsetFactor * 210).toInt();

    return Stack(
      children: <Widget>[
        Image.asset(
          path,
          height: maxExtent,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
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
