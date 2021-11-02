import 'package:flutter/material.dart';
import 'package:swiftvote/data/models/index.dart';
import 'package:swiftvote/themes/themes.dart';

typedef void InterestsScreenCallback(List<String> interests);

class RegisterOptionalInterests extends StatefulWidget {
  final InterestsScreenCallback interestsScreenCallback;

  RegisterOptionalInterests({required this.interestsScreenCallback});

  @override
  State createState() => _RegisterOptionalInterestsState();
}

class _RegisterOptionalInterestsState extends State<RegisterOptionalInterests> {
  final _categories = CategoryExtension.categoryToString.values.toList();
  final _categoryImages =
      CategoryExtension.categoryThumbnailAssetPath.values.toList();

  late Function _callback;
  late List<bool> _selectedIndices;
  List<String> _selectedCategories = [];
  bool _selectedAll = false;

  @override
  void initState() {
    super.initState();
    _callback = widget.interestsScreenCallback;
    _selectedIndices = List.generate(_categories.length, (index) => false);
    print('Initialized selectedIndices list: $_selectedIndices');
  }

  void clearCallback() {
    setState(() {
      _selectedAll = false;
      _selectedCategories = [];
      _selectedIndices = List.generate(_categories.length, (index) => false);
    });
    _callback(_selectedCategories);
  }

  void selectAllCallback() {
    setState(() {
      _selectedAll = !_selectedAll;
      if (_selectedAll) {
        _selectedCategories = _categories;
        _selectedIndices = List.generate(_categories.length, (index) => true);
      } else {
        _selectedCategories = _categories;
        _selectedIndices = List.generate(_categories.length, (index) => false);
      }
    });
    _callback(_selectedCategories);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      scrollDirection: Axis.vertical,
      slivers: <Widget>[
        SliverPersistentHeader(
          pinned: true,
          delegate: InterestsWidgetHeaderDelegate(
              isNoneSelected: _selectedCategories.length == 0,
              clearCallback: () => clearCallback(),
              selectAllCallback: () => selectAllCallback()),
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
                      Flexible(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedIndices[index] =
                                  !_selectedIndices[index];
                              _selectedIndices[index]
                                  ? _selectedCategories.add(_categories[index])
                                  : _selectedCategories
                                      .remove(_categories[index]);
                            });
                            _callback(_selectedCategories);
                          },
                          child: Container(
                            color: LIGHT_YELLOW,
                            child: Stack(
                              alignment: Alignment.bottomLeft,
                              children: <Widget>[
                                Image.asset(
                                  _categoryImages[index],
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(8.0, 0, 0, 16.0),
                                  child: Text(_categories[index],
                                      style: bodyStyle()),
                                ),
                                if (_selectedIndices[index]) selectedOverlay()
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
              childCount: _categoryImages.length),
        ),
      ],
    );
  }

  Widget selectedOverlay() {
    return Container(
      color: Colors.white.withOpacity(0.5),
      child: SizedBox.expand(
        child: Align(
          alignment: Alignment.topRight,
          child: Container(
            margin: EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Container(
                  width: 20.0,
                  height: 20.0,
                  decoration: new BoxDecoration(
                    color: OFF_WHITE,
                    shape: BoxShape.circle,
                  ),
                ),
                Container(
                  width: 20.0,
                  height: 20.0,
                  child: Center(
                    child: Icon(
                      Icons.check,
                      size: 20.0,
                      color: PRIMARY_BLUE,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InterestsWidgetHeaderDelegate extends SliverPersistentHeaderDelegate {
  final bool isNoneSelected;
  final VoidCallback selectAllCallback;
  final VoidCallback clearCallback;

  InterestsWidgetHeaderDelegate({
    required this.isNoneSelected,
    required this.selectAllCallback,
    required this.clearCallback,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            child: FractionallySizedBox(
              widthFactor: 1.0,
              child: Text(
                'Interests',
                style: largeTitleStyle(color: GRANITE_GRAY),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 8.0, bottom: 4.0),
            child: FractionallySizedBox(
              widthFactor: 1.0,
              child: Text(
                'Select your preferred categories',
                style: bodyStyle(color: CHARCOAL_GRAY),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                margin: EdgeInsets.only(right: 8.0),
                child: FlatButton(
                  onPressed: () {
                    selectAllCallback();
                  },
                  color: OFF_WHITE,
                  child: Text(
                    'Select all',
                    style: bodyStyle(size: 14.0, color: DARK_GRAY),
                  ),
                ),
              ),
              if (!isNoneSelected)
                FlatButton(
                  onPressed: () {
                    clearCallback();
                  },
                  color: OFF_WHITE,
                  child: Text(
                    'Clear',
                    style: bodyStyle(size: 14.0, color: DARK_GRAY),
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;

  @override
  double get maxExtent => 140.0;

  @override
  double get minExtent => 140.0;
}
