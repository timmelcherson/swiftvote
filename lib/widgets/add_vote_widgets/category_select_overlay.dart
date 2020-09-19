import 'package:flutter/material.dart';
import 'package:swiftvote/data/models.dart';
import 'package:swiftvote/utils/swiftvote_widget_keys.dart';
import 'package:swiftvote/themes/themes.dart';

typedef OnSaveCallback = Function(String title, String category,
    String voteOptionOne, String voteOptionTwo, List<String> tags);

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

  String _voteTitle;
  String _voteCategory;
  String _voteOptionOne;
  String _voteOptionTwo;
  List<String> _voteTags = new List();

//  List<ListItem> _dropDownItems = [
//    ListItem(1, "First Item"),
//    ListItem(2, "Second Item"),
//    ListItem(3, "Third Item"),
//    ListItem(4, "Fourth Item"),
//  ];
  List<ListItem> _dropDownItems = List.generate(
      Category.values.length,
          (index) => ListItem(
          index, CategoryExtension.categoryToString[Category.values[index]]));

//  List<DropdownMenuItem<ListItem>> _dropdownMenuItems;
//  ListItem _selectedItem;

  List<bool> _tagCheckboxValues;

  bool get isEditing => widget.isEditing;

  @override
  void initState() {
    super.initState();
//    _dropdownMenuItems = buildDropDownMenuItems(_dropDownItems);
//    _selectedItem = _dropdownMenuItems[0].value;
    _tagCheckboxValues =
        List.generate(Category.values.length, (index) => false);
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

  Widget customCheckBox(int index) {
    String tagDescr =
    CategoryExtension.categoryToString[Category.values[index]];
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          value: _tagCheckboxValues[index],
          onChanged: (bool value) {
            value ? _voteTags.add(tagDescr) : _voteTags.remove(tagDescr);
            print(_voteTags);
            setState(() {
              _tagCheckboxValues[index] = value;
            });
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
          child: Column(
            mainAxisSize: MainAxisSize.max,
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
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24.0),
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
              Container(
                margin: EdgeInsets.only(top: 32.0),
                child: GestureDetector(
                  child: Text(
                    'Choose category ->',
                    style: TextStyle(
                      fontFamily: 'RobotoMono',
                      fontSize: 24.0,
                      color: ColorThemes.secondaryColorAccent,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  onTap: () {
                    print("category choose");
                  },
                ),
              ),
//              GridView.count(
//                shrinkWrap: true,
//                crossAxisCount: 2,
//                childAspectRatio: 4.0,
//                crossAxisSpacing: 20.0,
//                padding: EdgeInsets.all(8.0),
//                children: List.generate(_tagCheckboxValues.length,
//                    (index) => customCheckBox(index)),
//              ),
//            DropdownButton(
//              value: _selectedItem,
//              items: _dropdownMenuItems,
//              onChanged: (value) {
//                setState(() {
//                  _selectedItem = value;
//                  _voteTags = _selectedItem.name;
//                });
//              },
//            ),
              Container(
                margin: EdgeInsets.only(top: 32.0),
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
                        _addVoteFormKey.currentState.save();
                        widget.onSave(_voteTitle, _voteCategory, _voteOptionOne,
                            _voteOptionTwo, _voteTags);
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

  printCheckbox() {
    print("");
  }
}

class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}