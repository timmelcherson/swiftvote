import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swiftvote/utils/keys.dart';
import 'package:swiftvote/utils/swiftvote_theme.dart';

class SearchWidget extends StatelessWidget {
  final bool _renderSearchResult = false;
  String searchQuery;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return GestureDetector(
        onTap: () {
          print("Tapped");
          print(FocusScope.of(context));
          FocusScope.of(context).unfocus();
        },
        child: CustomScrollView(
          key: SwiftvoteKeys.searchWidget,
          scrollDirection: Axis.vertical,
          slivers: <Widget>[
            SliverPersistentHeader(
              pinned: true,
              delegate: SearchWidgetHeaderDelegate(
                  maxExtentValue: constraints.maxHeight,
                  searchCallback: searchCallback),
            ),
            SliverGrid(
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
                            child: Stack(
                              alignment: Alignment.bottomLeft,
                              children: <Widget>[
                                Container(
                                  color: Colors.lightBlue[100 * (index % 9)],
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(8.0, 0, 0, 16.0),
                                  child: Text(
                                    searchQuery == null ? 'No search' : searchQuery,
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
                        ],
                      ),
                  childCount: 2),
            ),
          ],
        ),
      );
    });
  }

  void searchCallback(String search) {
    print("A SEARCH HAS BEEN MADE");
    print(search);
    searchQuery = search;
  }
}

class SearchWidgetHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double maxExtentValue;
  final Function(String) searchCallback;
  final TextEditingController _editingController = TextEditingController();

  SearchWidgetHeaderDelegate({this.maxExtentValue, this.searchCallback});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            margin: EdgeInsets.all(16.0),
            child: Text(
              'Search',
              style: SwiftvoteTheme.largeTitleTextStyle,
              textAlign: TextAlign.left,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 32.0),
              child: TextField(
                controller: _editingController,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.search),
                  hintText: 'Search question...',
                  hintStyle: TextStyle(fontSize: 18.0),
                ),
                onSubmitted: (String str) {
                  searchCallback(str);
                  _editingController.clear();
                },
                autofocus: false,
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
  double get maxExtent => maxExtentValue;

  @override
  double get minExtent => 80.0;
}
