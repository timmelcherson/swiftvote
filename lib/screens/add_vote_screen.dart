import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swiftvote/data/models.dart';
import 'package:swiftvote/utils/swiftvote_widget_keys.dart';
import 'package:swiftvote/themes/themes.dart';
import 'package:swiftvote/widgets/add_vote_widgets/category_select_overlay.dart';

typedef OnSaveCallback = Function(
    String title, List<String> category, String voteOptionOne, String voteOptionTwo, List<String> tags);

class AddVoteScreen extends StatefulWidget {
  final bool isEditing;
  final OnSaveCallback onSave;
  final Map<int, String> tempVote;

  AddVoteScreen({
    Key key,
    @required this.onSave,
    @required this.isEditing,
    this.tempVote,
  }) : super(key: key ?? SwiftvoteWidgetKeys.addVoteScreen);

  @override
  State createState() => _AddVoteScreenState();
}

class _AddVoteScreenState extends State<AddVoteScreen> {
  static final _addVoteFormKey = GlobalKey<FormState>();

  int _value = 1;
  int _selectCount = 0;
  bool _showErrorMsg = false;
//  bool _showOverlay = false;
  String _voteTitle;
  String _voteOptionOne;
  String _voteOptionTwo;
  List<String> _voteCategory = new List();
  List<String> _voteTags = ['#hashtag1', '#hashtag2'];  // Dummy list

//  void _showOverlay(BuildContext context) =>
//      Navigator.of(context).push(CategorySelectorOverlay());

//  List<ListItem> _dropDownItems = [
//    ListItem(1, "First Item"),
//    ListItem(2, "Second Item"),
//    ListItem(3, "Third Item"),
//    ListItem(4, "Fourth Item"),
//  ];
  List<ListItem> _dropDownItems = List.generate(Category.values.length,
      (index) => ListItem(index, CategoryExtension.categoryToString[Category.values[index]]));

//  List<DropdownMenuItem<ListItem>> _dropdownMenuItems;
//  ListItem _selectedItem;

  List<bool> _tagCheckboxValues;

  bool get isEditing => widget.isEditing;

  @override
  void initState() {
    super.initState();
//    _dropdownMenuItems = buildDropDownMenuItems(_dropDow,nItems);
//    _selectedItem = _dropdownMenuItems[0].value;
    _tagCheckboxValues = List.generate(Category.values.length, (index) => false);
    print(_tagCheckboxValues);
  }

//  List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
//    List<DropdownMenuItem<ListItem>> items = List();
//    for (ListItem listItem in listItems) {
//      items.add(
//        DropdownMenuItem(
//          child: Text(listItem.name),
//          value: listItem,
//        ),
//      );
//    }
//    return items;
//  }

  Widget customCheckBox(int index, String tagDescr) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          value: _tagCheckboxValues[index],
          onChanged: (bool value) {

            if (!(_selectCount >= 2)) {
              value ? _voteCategory.add(tagDescr) : _voteCategory.remove(tagDescr);
              setState(() {
                _tagCheckboxValues[index] = value;
                value ? _selectCount++ : _selectCount--;
                _showErrorMsg = false;
              });
            }
            else if (_tagCheckboxValues[index]) {
              _voteCategory.remove(tagDescr);
              setState(() {
                _tagCheckboxValues[index] = value;
                value ? _selectCount++ : _selectCount--;
                _showErrorMsg = false;
              });
            }
          },
        ),
        Text(tagDescr),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: ColorThemes.secondaryColor,
      body: SafeArea(
        child: Form(
          key: _addVoteFormKey,
          child: ListView(
            children: <Widget>[
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    iconSize: 32.0,
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.all(12.0),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              Container(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      flex: 6,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 32.0),
                        child: Text(
                          'Start a vote',
                          style: TextThemes.mediumTitleTextStyle,
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: ClipOval(
                        child: Material(
                          color: ColorThemes.primaryColor,
                          child: InkWell(
                            child: Container(
                              width: 32,
                              height: 32,
                              alignment: Alignment.center,
                              child: Text(
                                '?',
                                style: TextStyle(color: Colors.white, fontSize: 24.0),
                              ),
                            ),
                            onTap: () {
                              print('HELP ME');
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 32.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Type question',
                    hintStyle: TextThemes.textHintStyle,
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(),
                    ),
                  ),
                  validator: (value) {
                    return validateTextField(value);
                  },
                  onSaved: (value) => _voteTitle = value,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 4.0),
                child: FractionallySizedBox(
                  widthFactor: 0.8,
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Answer',
                      hintStyle: TextThemes.textHintStyle,
                    ),
                    validator: (value) {
                      return validateTextField(value);
                    },
                    onSaved: (value) => _voteOptionOne = value,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 4.0),
                child: FractionallySizedBox(
                  widthFactor: 0.8,
                  child: TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0.0),
                      hintText: 'Answer',
                      hintStyle: TextThemes.textHintStyle,
                    ),
                    validator: (value) {
                      return validateTextField(value);
                    },
                    onSaved: (value) => _voteOptionTwo = value,
                  ),
                ),
              ),
//              GridView.count(
//                shrinkWrap: true,
//                crossAxisCount: 2,
//                childAspectRatio: 4.0,
//                crossAxisSpacing: 20.0,
//                padding: EdgeInsets.all(8.0),
//                children: List.generate(
//                  _tagCheckboxValues.length,
//                  (index) => customCheckBox(
//                    index,
//                    CategoryExtension.categoryToString[Category.values[index]],
//                  ),
//                ),
//              ),
              Container(
                margin: EdgeInsets.all(16.0),
                child: Center(
                  child: Text('Choose categories ($_selectCount/2)', style: TextThemes.lightQuestionTextStyle,),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  crossAxisCount: 2,
                  childAspectRatio: 4.0,
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 4.0,
                  padding: EdgeInsets.all(8.0),
                  children: List.generate(
                      _tagCheckboxValues.length,
                      (index) => customCheckBox(
                            index,
                            CategoryExtension.categoryToString[Category.values[index]],
                          )),
                ),
              ),
              if(_showErrorMsg) Container(child: Text('SELECT 2 CATEGORIES PLS'),),
              Container(
                margin: EdgeInsets.only(top: 32.0, bottom: 32.0),
                height: 50.0,
                alignment: Alignment.bottomCenter,
                child: FractionallySizedBox(
                  widthFactor: 0.6,
                  child: RaisedButton(
                    color: ColorThemes.primaryColor,
                    textColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    onPressed: () {
                      if (_addVoteFormKey.currentState.validate()) {
                        if (_selectCount != 2) {
                          setState(() {
                            _showErrorMsg = true;
                          });
                          return;
                        }
                        _addVoteFormKey.currentState.save();
                        widget.onSave(
                            _voteTitle, _voteCategory, _voteOptionOne, _voteOptionTwo, _voteTags);
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      'Submit',
                      style: TextThemes.darkQuestionTextStyle,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  validateTextField(String value) {
    if (value.trim().isEmpty) {
      return 'Enter some text';
    }

    return null;
  }

//  Widget getOverlay() {
//    return _showOverlay == true
//        ? CategorySelectorOverlay(
//            showOverlayCallback: (value) {
//              setState(() {
//                _showOverlay = value;
//              });
//            },
//          )
//        : Container(
//            color: Colors.red,
//            height: 0,
//          );
//  }
}

class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}

class AddVoteScreenHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Color.fromRGBO(255, 253, 245, 1),
      child: IconButton(
        icon: Icon(Icons.arrow_back),
        iconSize: 32.0,
        alignment: Alignment.topLeft,
        padding: EdgeInsets.all(12.0),
        onPressed: () {
          Navigator.pop(context);
        },
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
