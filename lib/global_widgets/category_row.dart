import 'package:flutter/material.dart';
import 'package:swiftvote/themes/themes.dart';

class CategoryRow extends StatelessWidget {
  final List<String> categories;

  CategoryRow({@required this.categories});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: List.generate(
          categories.length,
          (index) {
            if (categories[index].isNotEmpty)
              return Container(
                padding: EdgeInsets.all(4.0),
                margin: EdgeInsets.all(4.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: LIGHT_GRAY),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  categories[index],
                  style: footnoteStyle(color: LIGHT_GRAY),
                ),
              );
            else
              return Container();
          },
        ),
      ),
    );
  }
}
