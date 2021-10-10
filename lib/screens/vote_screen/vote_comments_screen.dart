import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swiftvote/blocs/vote_comments/index.dart';
import 'package:swiftvote/data/models/vote_model.dart';
import 'package:swiftvote/global_widgets/global_widgets_barrel.dart';
import 'package:swiftvote/screens/vote_screen/add_comment_overlay.dart';
import 'package:swiftvote/screens/vote_screen/vote_comment_item.dart';
import 'package:swiftvote/screens/vote_screen/vote_comments_header.dart';
import 'package:swiftvote/themes/color_themes.dart';
import 'package:swiftvote/themes/text_themes.dart';

class VoteCommentsScreen extends StatefulWidget {
  @override
  _VoteCommentsScreenState createState() => _VoteCommentsScreenState();
}

class _VoteCommentsScreenState extends State<VoteCommentsScreen> {
  VoteCommentsBloc _voteCommentsBloc;

  @override
  void initState() {
    _voteCommentsBloc = BlocProvider.of<VoteCommentsBloc>(context);
    super.initState();
  }

  void addCommentCallback(String content) {
    print('GOT comment: $content');
    _voteCommentsBloc.add(AddVoteCommentEvent(content: content));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: BlocBuilder<VoteCommentsBloc, VoteCommentsState>(
          builder: (context, state) {
            print('VoteCommentsScreenState: $state');
            if (state is VoteCommentsLoadingState) {
              return LoadingIndicator();
            }

            if (state is VoteCommentsLoadedState) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        VoteCommentsHeader(vote: state.vote),
                        if (state.timeSortedComments.length > 0)
                          Expanded(
                            child: ListView.builder(
                              itemCount: state.timeSortedComments.length,
                              itemBuilder: (context, index) {
                                return VoteCommentItem(
                                  content: state.timeSortedComments[index].content,
                                  commentIndex: index,
                                  createdAt: state.timeSortedComments[index].createdAt,
                                );
                              },
                            ),
                          ),
                        if (state.timeSortedComments.length <= 0)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text('There are no comments yet!', style: bodyStyle(size: 14.0)),
                          ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.white),
                        ),
                        color: PRIMARY_BG,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                      height: 50.0,
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: 'Write comment',
                          hintStyle: hintStyle(),
                          border: UnderlineInputBorder(borderSide: BorderSide(color: LIGHT_GRAY)),
                        ),
                      ),
                    ),
                  ),
                  // Align(
                  //   alignment: Alignment.bottomCenter,
                  //   child: Container(
                  //     width: 60.0,
                  //     height: 60.0,
                  //     margin: const EdgeInsets.only(bottom: 16.0),
                  //     child: IconButton(
                  //       padding: const EdgeInsets.all(0),
                  //       splashRadius: 25.0,
                  //       splashColor: LIGHT_BLUE,
                  //       icon: Icon(
                  //         Icons.add_circle_outline_rounded,
                  //         color: Colors.white,
                  //         size: 60.0,
                  //       ),
                  //       onPressed: () => Navigator.of(context).push(
                  //         AddCommentOverlay(
                  //           callback: (content) => addCommentCallback(content),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // )
                ],
              );
            }

            if (state is VoteCommentsLoadFailState) {
              return Center(
                child: Text('COMMENTS FAIL'),
              );
            }

            return LoadingIndicator();
          },
        ),
      ),
    );
  }
}
