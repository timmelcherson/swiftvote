import 'package:flutter/material.dart';
import 'file:///C:/Users/Tim/Documents/Programmering/flutter/swiftvote/swiftvote/lib/constants/swiftvote_widget_keys.dart';
import 'package:swiftvote/themes/themes.dart';

class SearchWidget extends StatelessWidget {
  bool _renderSearchResult = false;
  final ScrollController _scrollController = new ScrollController();

  String searchQuery;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorThemes.LIGHT_YELLOW,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: CustomScrollView(
              key: SwiftvoteWidgetKeys.searchWidget,
              scrollDirection: Axis.vertical,
              controller: _scrollController,
              physics: _renderSearchResult ? BouncingScrollPhysics() : NeverScrollableScrollPhysics(),
              slivers: <Widget>[
                SliverPersistentHeader(
                  pinned: true,
                  floating: true,
                  delegate: SearchWidgetHeaderDelegate(
                      maxExtentValue: constraints.maxHeight,
                      searchCallback: searchCallback,
                      isSearchMade: _renderSearchResult,
                      searchQuery: searchQuery),
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
      ),
    );
  }

  void searchCallback(String search) {
    if (!_renderSearchResult) {
      _scrollController.animateTo(0, duration: Duration(milliseconds: 1000), curve: Curves.easeOut);
    }
    _renderSearchResult = true;
    searchQuery = search;
  }
}

class SearchWidgetHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double maxExtentValue;
  final bool isSearchMade;
  final String searchQuery;
  final Function(String) searchCallback;
  final TextEditingController _editingController = TextEditingController();

  SearchWidgetHeaderDelegate(
      {this.maxExtentValue, this.isSearchMade, this.searchQuery, this.searchCallback});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: maxExtent,
      decoration: BoxDecoration(
        color: ColorThemes.LIGHT_YELLOW,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color.fromRGBO(20, 20, 20, isSearchMade ? 1.0 : 0.0),
            spreadRadius: 2,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 12.0),
                child: Text(
                  'Search',
                  style: TextThemes.TITLE_GRANITE_GRAY,
                  textAlign: TextAlign.end,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0),
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
          if (isSearchMade)
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Showing results for: $searchQuery',
                  style: TextThemes.TINY_DARK_GRAY,
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
  double get maxExtent => isSearchMade ? minExtent : maxExtentValue;

  @override
  double get minExtent => 180.0;
}
