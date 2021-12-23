import 'package:flutter/material.dart';

class VoteCommentsList extends StatefulWidget {
  const VoteCommentsList({Key? key}) : super(key: key);

  @override
  _VoteCommentsListState createState() => _VoteCommentsListState();
}

class _VoteCommentsListState extends State<VoteCommentsList>
    with TickerProviderStateMixin {
  late AnimationController _chevronController;
  late AnimationController _expandController;
  late Animation<double> animation;
  bool _showComments = false;

  @override
  void initState() {
    _chevronController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    _expandController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );

    animation = CurvedAnimation(
      parent: _expandController,
      curve: Curves.fastOutSlowIn,
    );

    super.initState();
  }

  @override
  void dispose() {
    _chevronController.dispose();
    _expandController.dispose();
    super.dispose();
  }

  List<String> comments = [
    '2j435r',
    'adg34',
    '9wnsf90w234nhtgf',
    '2j435r',
    'adg34',
    '9wnsf90w234nhtgf'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              _showComments
                  ? _chevronController.forward()
                  : _chevronController.reverse();
              _showComments
                  ? _expandController.forward()
                  : _expandController.reverse();
              _showComments = !_showComments;
            },
            child: Container(
              padding: EdgeInsets.all(4.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Comments'),
                  RotationTransition(
                    turns: Tween(begin: 0.0, end: 0.25)
                        .animate(_chevronController),
                    child: Icon(Icons.chevron_right,
                        size: 20.0, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          SizeTransition(
            axisAlignment: 1.0,
            sizeFactor: animation,
            child: Column(
              children: [
                ...List.generate(comments.length, (index) {
                  return Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 24.0),
                    decoration: BoxDecoration(
                      border: Border(top: BorderSide(color: Colors.white.withOpacity(0.3))),
                    ),
                    child: Text(comments[index]),
                  );
                })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
