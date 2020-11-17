import 'package:flutter/material.dart';
import 'package:swiftvote/constants/supported_langs.dart';
import 'package:swiftvote/themes/themes.dart';

class RegisterLanguages extends StatefulWidget {
  @override
  State createState() => _RegisterLanguagesState();
}

class _RegisterLanguagesState extends State<RegisterLanguages> {
  // Lang _selectedLangKey = Lang.EN;
  String _selectedLang = LangExt.languages[Lang.EN];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 48.0),
          child: FractionallySizedBox(
            widthFactor: 1.0,
            child: Text(
              'Languages',
              style: TextThemes.largeTitleTextStyle,
              textAlign: TextAlign.left,
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: DropdownButton<String>(
                value: _selectedLang,
                style: TextThemes.mediumDarkTextStyle,
                icon: Icon(Icons.arrow_downward),
                onChanged: (value) {
                  setState(() {
                    _selectedLang = value;
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
        ),
      ],
    );
  }
}
