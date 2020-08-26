import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swiftvote/utils/swiftvote_widget_keys.dart';
import 'package:swiftvote/utils/swiftvote_theme.dart';

class SearchWidget extends StatelessWidget {
  bool _renderSearchResult = false;
  final ScrollController _scrollController = new ScrollController();

  String searchQuery;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: CustomScrollView(
            key: SwiftvoteWidgetKeys.searchWidget,
            scrollDirection: Axis.vertical,
            controller: _scrollController,
            physics: _renderSearchResult
                ? BouncingScrollPhysics()
                : NeverScrollableScrollPhysics(),
            slivers: <Widget>[
              SliverPersistentHeader(
                pinned: true,
                floating: false,
                delegate: SearchWidgetHeaderDelegate(
                    maxExtentValue: constraints.maxHeight,
                    searchCallback: searchCallback,
                    isSearchMade: _renderSearchResult),
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
                                    margin:
                                        EdgeInsets.fromLTRB(8.0, 0, 0, 16.0),
                                    child: Text(
                                      'Search here',
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
                    childCount: _renderSearchResult ? 20 : 0),
              ),
            ],
          ),
        );
      },
    );
  }

  void searchCallback(String search) {
    if (!_renderSearchResult) {
      _scrollController.animateTo(0,
          duration: Duration(milliseconds: 200), curve: Curves.easeOut);
    }
    _renderSearchResult = true;
    print(search);
    searchQuery = search;
  }
}

class SearchWidgetHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double maxExtentValue;
  final bool isSearchMade;
  final Function(String) searchCallback;
  final TextEditingController _editingController = TextEditingController();

  SearchWidgetHeaderDelegate(
      {this.maxExtentValue, this.isSearchMade, this.searchCallback});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return FractionallySizedBox(
      child: Container(
        color: SwiftvoteTheme.lightYellowBackgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                constraints: BoxConstraints(minHeight: 80.0),
                margin: EdgeInsets.all(16.0),
                child: Text(
                  'Search',
                  style: SwiftvoteTheme.largeTitleTextStyle,
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Expanded(
              flex: 1,
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
                    print(isSearchMade);
                    searchCallback(str);
                    _editingController.clear();
                  },
                  autofocus: false,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;

  @override
  double get maxExtent => isSearchMade ? 180.0 : maxExtentValue;

  @override
  double get minExtent => 180.0;
}
