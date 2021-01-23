import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swiftvote/data/entities/vote_entity.dart';
import 'package:swiftvote/data/models/vote_model.dart';
import 'package:swiftvote/data/repositories.dart';
import 'package:swiftvote/global_widgets/global_widgets_barrel.dart';
import 'package:swiftvote/screens/explore_screen/category_card.dart';
import 'package:swiftvote/themes/themes.dart';
import 'package:swiftvote/constants/widget_keys.dart';
import 'package:swiftvote/blocs/blocs.dart';
import 'explore_barrel.dart';

import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class ExploreScreen extends StatelessWidget {
  ExploreScreen({Key key}) : super(key: key);

  // REMOVE WHEN VOTES ARE ADDED
  Future<void> loadAsset(context) async {
    print('loading asset');
    String votesStr = await DefaultAssetBundle.of(context).loadString('assets/votes.txt');
    List<String> allVotes = votesStr.split(",-");
    // print("firt vote found in TSRING FILE: ${votesStr.split("-").first}");

    Vote voteModel;
    allVotes.forEach((result) {
      if (result.split(",").length == 3) {
        print(result.split(","));
      }
      // List<String> voteStr = allVotes.first.split(",");
      // print(result);

      // if (voteStr.length > 4) {
      //   voteModel = Vote(
      //       title: voteStr[0],
      //       author: 'swiftvote',
      //       categories: [voteStr[3], voteStr[4]],
      //       sponsor: '',
      //       voteOptions: [voteStr[1], voteStr[2]],
      //       totalVotes: 0,
      //       tags: ['']
      //   );
      // } else if (voteStr.length == 4){
      //   voteModel = Vote(
      //       title: voteStr[0],
      //       author: 'swiftvote',
      //       categories: [voteStr[3]],
      //       sponsor: '',
      //       voteOptions: [voteStr[1], voteStr[2]],
      //       totalVotes: 0,
      //       tags: ['']
      //   );
      // }
    });
    // VoteRepository vr = VoteRepository();
    // vr.addNewVote(voteModel);
    // print('Created a Vote model:');
    // print(voteModel.toString().replaceAll("[", ""));

  }

  @override
  Widget build(BuildContext context) {
    loadAsset(context);

    return Scaffold(
      bottomNavigationBar: MainNavBar(),
      body: BlocBuilder<ExploreBloc, ExploreState>(
        builder: (context, state) {
          if (state is ExploreCategoriesLoadingState) {
            return LoadingIndicator(key: Keys.loadingIndicator);
          } else if (state is ExploreCategoriesLoadedState) {
            final categories = state.categories;
            final categoryThumbnails = state.categoryThumbnails;
            // final categoryThumbnailAssetPath = state.categoryImagesPaths;

            return CustomScrollView(
              key: Keys.exploreWidget,
              scrollDirection: Axis.vertical,
              slivers: <Widget>[
                SliverPersistentHeader(
                  pinned: true,
                  delegate: ExploreWidgetHeaderDelegate(),
                ),
                SliverPadding(
                  padding: EdgeInsets.all(16),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                    ),
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) => Row(
                              children: <Widget>[
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      BlocProvider.of<ExploreBloc>(context).add(
                                          ExploreCategoryTappedEvent(
                                              category: state.categories[index]));
                                    },
                                    child: CategoryCard(
                                      title: state.categories[index],
                                      icon: categoryThumbnails[index],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        childCount: state.categories.length),
                  ),
                ),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class ExploreWidgetHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    double offsetFactor = shrinkOffset / maxExtent;

    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            height: maxExtent,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: ColorThemes.DEEP_BLUE_BG,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Color.fromRGBO(255, 255, 255, offsetFactor),
                  spreadRadius: 2,
                  blurRadius: 15,
                  offset: Offset(0, 3),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 12.0),
              child: Text(
                'Explore',
                style: TextThemes.HUGE_OFF_WHITE,
                textAlign: TextAlign.end,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;

  @override
  double get maxExtent => 150.0;

  @override
  double get minExtent => 70.0;
}
