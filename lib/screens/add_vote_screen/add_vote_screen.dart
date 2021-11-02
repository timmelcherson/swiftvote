import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swiftvote/app_localization.dart';
import 'package:swiftvote/blocs/vote/index.dart';
import 'package:swiftvote/blocs/vote/vote_bloc.dart';
import 'package:swiftvote/constants/routes.dart';
import 'package:swiftvote/data/entities/vote_entity.dart';
import 'package:swiftvote/data/models/index.dart';
import 'package:swiftvote/constants/widget_keys.dart';
import 'package:swiftvote/global_widgets/buttons/custom_button.dart';
import 'package:swiftvote/global_widgets/global_widgets_barrel.dart';
import 'package:swiftvote/themes/themes.dart';

typedef OnSaveCallback = Function(String title, List<String> category,
    String voteOptionOne, String voteOptionTwo, List<String> tags);

class AddVoteScreen extends StatefulWidget {
  AddVoteScreen() : super(key: Keys.addVoteScreen);

  @override
  State createState() => _AddVoteScreenState();
}

class _AddVoteScreenState extends State<AddVoteScreen> {
  GlobalKey<FormState> _addVoteFormKey = GlobalKey<FormState>();

  int _selectCount = 0;
  bool _showErrorMsg = false;
  late String _voteTitle;
  late String _voteOptionOne;
  late String _voteOptionTwo;
  List<String> _voteCategories = [];
  List<String> _voteTags = ['#hashtag1', '#hashtag2']; // Dummy list
  late List<bool> _tagCheckboxValues;

  @override
  void initState() {
    super.initState();
    _tagCheckboxValues =
        List.generate(Category.values.length, (index) => false);
  }

  Widget customCheckBox(int index, String tagDescr) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          value: _tagCheckboxValues[index],
          onChanged: (bool? value) {
            if (!(_selectCount >= 2)) {
              _tagCheckboxValues[index]
                  ? _voteCategories.add(tagDescr)
                  : _voteCategories.remove(tagDescr);
              setState(() {
                _tagCheckboxValues[index] = !_tagCheckboxValues[index];
                _tagCheckboxValues[index] ? _selectCount++ : _selectCount--;
                _showErrorMsg = false;
              });
            } else if (_tagCheckboxValues[index]) {
              _voteCategories.remove(tagDescr);
              setState(() {
                _tagCheckboxValues[index] = !_tagCheckboxValues[index];
                _tagCheckboxValues[index] ? _selectCount++ : _selectCount--;
                _showErrorMsg = false;
              });
            }
          },
        ),
        Flexible(
          child: Text(
            tagDescr,
            overflow: TextOverflow.clip,
          ),
        ),
      ],
    );
  }

  void onSave(title, categories, voteOptionOne, voteOptionTwo, tags) {
    VoteEntity entity = VoteEntity(
        title: _voteTitle,
        author: 'swiftvote',
        sponsor: "",
        voteOptions: [_voteOptionOne, _voteOptionTwo],
        totalVotes: 0,
        tags: _voteTags,
        categories: _voteCategories);
    BlocProvider.of<VoteBloc>(context).add(
      AddVoteEvent(voteEntity: entity),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: SECONDARY_BG,
        automaticallyImplyLeading: false,
        title: Text("Add a vote"),
        actions: [
          GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(Routes.SETTINGS),
            child: Container(
              margin: EdgeInsets.only(right: 16.0),
              child: Icon(Icons.settings_outlined),
            ),
          )
        ],
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: SECONDARY_BG,
      bottomNavigationBar: MainNavBar(),
      body: SafeArea(
        child: Form(
          key: _addVoteFormKey,
          child: ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 32.0),
                child: TextFormField(
                  maxLength: 70,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 8.0),
                    hintText: 'Type question',
                    hintStyle: bodyStyle(),
                    border: OutlineInputBorder(borderSide: const BorderSide()),
                  ),
                  validator: (value) {
                    return validateTextField(value!);
                  },
                  onSaved: (value) => _voteTitle = value!,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 4.0),
                child: FractionallySizedBox(
                  widthFactor: 0.8,
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Answer 1',
                      hintStyle: bodyStyle(),
                    ),
                    validator: (value) {
                      return validateTextField(value!);
                    },
                    onSaved: (value) => _voteOptionOne = value!,
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
                      hintText: 'Answer 2',
                      hintStyle: bodyStyle(),
                    ),
                    validator: (value) {
                      return validateTextField(value!);
                    },
                    onSaved: (value) => _voteOptionTwo = value!,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 32.0, bottom: 32.0),
                alignment: Alignment.bottomCenter,
                child: CustomButton(
                  buttonText: trans(context, 'button.post'),
                  onPress: () {
                    if (_addVoteFormKey.currentState!.validate()) {
                      // if (_selectCount != 2) {
                      //   setState(() {
                      //     _showErrorMsg = true;
                      //   });
                      //   return;
                      // }
                      _addVoteFormKey.currentState!.save();
                      onSave(
                        _voteTitle,
                        _voteCategories,
                        _voteOptionOne,
                        _voteOptionTwo,
                        _voteTags,
                      );
                    }
                  },
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
}
