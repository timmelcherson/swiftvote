import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swiftvote/constants/routes.dart';
import 'package:swiftvote/data/entities/vote_entity.dart';
import 'package:swiftvote/data/models/vote_model.dart';
import 'package:swiftvote/global_widgets/global_widgets_barrel.dart';
import 'package:swiftvote/screens/explore_screen/category_card.dart';
import 'package:swiftvote/themes/themes.dart';
import 'package:swiftvote/constants/widget_keys.dart';
import 'package:swiftvote/blocs/index.dart';
import 'explore_barrel.dart';

import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class ExploreScreen extends StatelessWidget {
  ExploreScreen() : super(key: Keys.exploreScreen);

  String formatStr(String string) {
    return string.trim().replaceAll("[", "").replaceAll("]", "");
  }

  // REMOVE WHEN VOTES ARE ADDED
  // Future<void> loadAsset(context) async {
  //   print('loading asset');
  //   String votesStr = await DefaultAssetBundle.of(context).loadString('assets/votes.txt');
  //   List<String> allVotes = votesStr.split("*");
  //
  //   allVotes.forEach((result) async {
  //     List<String> voteData = result.split(',');
  //
  //     Vote vote = new Vote(
  //       title: formatStr(voteData[0]),
  //       author: 'swiftvote',
  //       categories: [formatStr(voteData[3]), formatStr(voteData[4])],
  //       sponsor: '',
  //       voteOptions: [formatStr(voteData[1]), formatStr(voteData[2])],
  //       totalVotes: 0,
  //       tags: [''],
  //     );
  //
  //     print(vote);
  //
  //     if (voteData.length > 4) {
  //       Vote vote = new Vote(
  //         title: formatStr(voteData[0]),
  //         author: 'swiftvote',
  //         categories: [formatStr(voteData[3]), formatStr(voteData[4])],
  //         sponsor: '',
  //         voteOptions: [formatStr(voteData[1]), formatStr(voteData[2])],
  //         totalVotes: 0,
  //         tags: [''],
  //       );
  //       await voteRepository.addNewVote(vote);
  //     } else if (voteData.length == 4) {
  //       Vote vote = new Vote(
  //         title: formatStr(voteData[0]),
  //         author: 'swiftvote',
  //         categories: [formatStr(voteData[3]), ""],
  //         sponsor: '',
  //         voteOptions: [formatStr(voteData[1]), formatStr(voteData[2])],
  //         totalVotes: 0,
  //         tags: [''],
  //       );
  //       await voteRepository.addNewVote(vote);
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // loadAsset(context);

    return Scaffold(
      bottomNavigationBar: MainNavBar(),
      backgroundColor: PRIMARY_BG,
      body: BlocBuilder<ExploreBloc, ExploreState>(
        builder: (context, state) {
          if (state is ExploreCategoriesLoadingState) {
            return LoadingIndicator();
          }

          if (state is ExploreCategoriesLoadedState) {
            final categories = state.categories;
            final categoryThumbnails = state.categoryThumbnails;
            // final categoryThumbnailAssetPath = state.categoryImagesPaths;

            return CustomScrollView(
              scrollDirection: Axis.vertical,
              slivers: <Widget>[
                SliverPersistentHeader(
                  pinned: true,
                  delegate: ExploreWidgetHeaderDelegate(),
                ),
                SliverPadding(
                    padding: EdgeInsets.all(16),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate(
                        List.generate(
                          categories.length,
                          (index) => GestureDetector(
                            onTap: () {
                              BlocProvider.of<ExploreBloc>(context).add(
                                ExploreCategoryTappedEvent(category: categories[index]),
                              );
                              Navigator.of(context).pushNamed(Routes.EXPLORE_CATEGORY);
                            },
                            child: CategoryCard(
                              title: categories[index],
                              icon: categoryThumbnails[index],
                            ),
                          ),
                        ),
                      ),
                    )
                    // SliverGrid(
                    //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //     crossAxisCount: 2,
                    //     crossAxisSpacing: 4,
                    //     mainAxisSpacing: 4,
                    //   ),
                    //   delegate: SliverChildBuilderDelegate(
                    //       (BuildContext context, int index) => Row(
                    //             children: <Widget>[
                    //               Expanded(
                    //                 child: GestureDetector(
                    //                   onTap: () {
                    //                     BlocProvider.of<ExploreBloc>(context).add(
                    //                       ExploreCategoryTappedEvent(
                    //                         category: categories[index],
                    //                       ),
                    //                     );
                    //                     Navigator.of(context).pushNamed(Routes.EXPLORE_CATEGORY);
                    //                   },
                    //                   child: CategoryCard(
                    //                     title: categories[index],
                    //                     icon: categoryThumbnails[index],
                    //                   ),
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //       childCount: categories.length),
                    // ),
                    ),
              ],
            );
          }
          return LoadingIndicator();
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
              color: PRIMARY_BG,
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
              child: Text('Explore', style: largeTitleStyle()),
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
  double get minExtent => 80.0;
}
