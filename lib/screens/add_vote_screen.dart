import 'package:flutter/material.dart';
import 'package:swiftvote/utils/swiftvote_widget_keys.dart';

typedef OnSaveCallback = Function(
    String title, String answerOne, String answerTwo, String category);

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
  String _voteAnswerOne;
  String _voteAnswerTwo;
  String _voteCategory;

  List<ListItem> _dropDownItems = [
    ListItem(1, "First Item"),
    ListItem(2, "Second Item"),
    ListItem(3, "Third Item"),
    ListItem(4, "Fourth Item"),
  ];
  List<DropdownMenuItem<ListItem>> _dropdownMenuItems;
  ListItem _selectedItem;

  bool get isEditing => widget.isEditing;

  @override
  void initState() {
    super.initState();
    _dropdownMenuItems = buildDropDownMenuItems(_dropDownItems);
    _selectedItem = _dropdownMenuItems[0].value;
  }

  List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<ListItem>> items = List();
    for (ListItem listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Form(
        key: _addVoteFormKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              validator: (value) {
                return validateTextField(value);
              },
              onSaved: (value) => _voteTitle = value,
            ),
            TextFormField(
              validator: (value) {
                return validateTextField(value);
              },
              onSaved: (value) => _voteAnswerOne = value,
            ),
            TextFormField(
              validator: (value) {
                return validateTextField(value);
              },
              onSaved: (value) => _voteAnswerTwo = value,
            ),
            DropdownButton(
              value: _selectedItem,
              items: _dropdownMenuItems,
              onChanged: (value) {
                setState(() {
                  _selectedItem = value;
                  _voteCategory = _selectedItem.name;
                });
              },
            ),
            RaisedButton(
              onPressed: () {
                if (_addVoteFormKey.currentState.validate()) {
                  _addVoteFormKey.currentState.save();
                  widget.onSave(_voteTitle, _voteAnswerOne, _voteAnswerTwo,
                      _voteCategory);
                  print("VALIDATED");
                  Navigator.pop(context);
                }
              },
              child: Text('Submit'),
            )
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
}

class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}
