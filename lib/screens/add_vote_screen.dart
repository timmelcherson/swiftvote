import 'package:flutter/material.dart';
import 'package:swiftvote/data/models.dart';
import 'package:swiftvote/utils/swiftvote_theme.dart';
import 'package:swiftvote/utils/swiftvote_widget_keys.dart';

typedef OnSaveCallback = Function(String title, String voteOptionOne,
    String voteOptionTwo, List<String> tags);

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
      CategoryTag.values.length,
      (index) => ListItem(index,
          CategoryTagExtension.categoryToString[CategoryTag.values[index]]));

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
        List.generate(CategoryTag.values.length, (index) => false);
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
        CategoryTagExtension.categoryToString[CategoryTag.values[index]];
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Form(
        key: _addVoteFormKey,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 32.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'title',
                  hintStyle: TextStyle(fontSize: 18.0),
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
                widthFactor: 0.6,
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'option 1',
                    hintStyle: TextStyle(fontSize: 18.0),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(),
                    ),
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
                widthFactor: 0.6,
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'option 2',
                    hintStyle: TextStyle(fontSize: 18.0),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(),
                    ),
                  ),
                  validator: (value) {
                    return validateTextField(value);
                  },
                  onSaved: (value) => _voteOptionTwo = value,
                ),
              ),
            ),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              childAspectRatio: 4.0,
              crossAxisSpacing: 20.0,
              padding: EdgeInsets.all(8.0),
              children: List.generate(
                  _tagCheckboxValues.length, (index) => customCheckBox(index)),
            ),
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
            FractionallySizedBox(
              widthFactor: 0.5,
              child: RaisedButton(
                color: SwiftvoteTheme.primaryColor,
                textColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 12.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                onPressed: () {
                  if (_addVoteFormKey.currentState.validate()) {
                    _addVoteFormKey.currentState.save();
                    widget.onSave(
                        _voteTitle, _voteOptionOne, _voteOptionTwo, _voteTags);
                    Navigator.pop(context);
                  }
                },
                child: Text('Submit'),
              ),
            ),
          ],
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
