import 'package:flutter/material.dart';
import 'package:swiftvote/themes/themes.dart';

class CategoryExplorer extends StatelessWidget {
  final String headerImagePath;
  final String category;

  CategoryExplorer({this.headerImagePath, this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                expandedHeight: 250.0,
                pinned: true,
                iconTheme: innerBoxIsScrolled
                    ? IconThemeData(color: Colors.black)
                    : IconThemeData(color: Colors.white),
                backgroundColor: ColorThemes.lightYellowBackgroundColor,
                flexibleSpace: FlexibleSpaceBar(
                  title: AnimatedDefaultTextStyle(
                    child: Text(category),
                    style: innerBoxIsScrolled
                        ? TextStyle(
                            fontFamily: 'RobotoMono',
                            color: Colors.black,
                            fontSize: 18)
                        : TextStyle(
                            fontFamily: 'RobotoMono',
                            color: Colors.white,
                            fontSize: 24),
                    duration: Duration(milliseconds: 100),
                  ),
                  titlePadding: EdgeInsets.fromLTRB(64.0, 0, 0, 16.0),
                  background: Image.asset(
                    headerImagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ];
        },
        body: CustomScrollView(
          slivers: <Widget>[
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
                              child: Container(
                                color: Colors.lightBlue[100 * (index % 9)],
                              ),
                            ),
                          ],
                        ),
                    childCount: 20),
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
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Color.fromRGBO(255, 253, 245, 1),
      child: Column(
        children: <Widget>[
          Image.asset(
            path,
            height: 250,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            color: ColorThemes.primaryColor,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 8.0, 12.0, 12.0),
              child: Text(
                text,
                style: TextStyle(
                  fontFamily: 'RobotoMono',
                  fontSize: 24.0,
                  color: Colors.white,
                ),
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
  double get maxExtent => 350.0;

  @override
  double get minExtent => 120.0;
}
