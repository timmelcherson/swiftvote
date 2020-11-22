import 'package:flutter/material.dart';
import 'package:swiftvote/constants/supported_langs.dart';
import 'package:swiftvote/themes/themes.dart';

class RegisterOptionalLanguages extends StatefulWidget {
  @override
  State createState() => _RegisterOptionalLanguagesState();
}

class _RegisterOptionalLanguagesState extends State<RegisterOptionalLanguages> {
  // Lang _selectedLangKey = Lang.EN;
  List<String> _selectedLangs = [
    LangExt.languages[Lang.EN],
  ];
  int numberOfLangRows = 1;

  @override
  Widget build(BuildContext context) {
    print('number of language rows: $numberOfLangRows');
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 32.0),
          child: FractionallySizedBox(
            widthFactor: 1.0,
            child: Text(
              'Languages',
              style: TextThemes.largeTitleTextStyle,
              textAlign: TextAlign.left,
            ),
          ),
        ),
        Column(
          children: List.generate(numberOfLangRows, (index) => languageRow(index)),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: FlatButton(
            color: ColorThemes.secondaryColor,
            child: Text(
              'Add more +',
              style: TextThemes.smallDarkTextStyle,
            ),
            onPressed: () {
              addNewLangRow();
            },
          ),
        ),
      ],
    );
  }

  void addNewLangRow() {
    if (numberOfLangRows < LangExt.languages.length) {
      setState(() {
        _selectedLangs.add(LangExt.languages[Lang.EN]);
        numberOfLangRows++;
      });
    }
  }

  void removeLangRow() {

  }

  Widget languageRow(int index) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: DropdownButton<String>(
            value: _selectedLangs[index],
            style: TextThemes.mediumDarkTextStyle,
            icon: Icon(Icons.arrow_downward),
            onChanged: (value) {
              setState(() {
                _selectedLangs[index] = value;
              });
            },
            items: LangExt.languages.keys.map<DropdownMenuItem<String>>((Lang key) {
              return DropdownMenuItem<String>(
                value: LangExt.languages[key],
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(LangExt.languages[key]),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
