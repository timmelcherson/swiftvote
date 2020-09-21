// import 'package:flutter/cupertino.dart';
//
// class Dummy extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return NestedScrollView(
//       headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//         print('innerBoxIsScrolled: $innerBoxIsScrolled');
//         return <Widget>[
//           SliverOverlapAbsorber(
//             handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
//             sliver: SliverAppBar(
//               expandedHeight: 250.0,
//               pinned: true,
//               iconTheme: innerBoxIsScrolled
//                   ? IconThemeData(color: Colors.black)
//                   : IconThemeData(color: Colors.white),
//               backgroundColor: ColorThemes.lightYellowBackgroundColor,
//               flexibleSpace: FlexibleSpaceBar(
//                 collapseMode: CollapseMode.parallax,
//                 title: AnimatedDefaultTextStyle(
//                   child: Text(category),
//                   style: innerBoxIsScrolled
//                       ? TextStyle(fontFamily: 'RobotoMono', color: Colors.black, fontSize: 18)
//                       : TextStyle(fontFamily: 'RobotoMono', color: Colors.white, fontSize: 24),
//                   duration: Duration(milliseconds: 100),
//                 ),
//                 titlePadding: EdgeInsets.fromLTRB(64.0, 0, 0, 16.0),
//                 background: Image.asset(
//                   headerImagePath,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           ),
//         ];
//       },
//       body: CustomScrollView(
//         slivers: <Widget>[
//           SliverPadding(
//             padding: EdgeInsets.all(16),
//             sliver: SliverGrid(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//               ),
//               delegate: SliverChildBuilderDelegate(
//                   (BuildContext context, int index) => Row(
//                         children: <Widget>[
//                           VoteThumbnail(votes[index].title),
//                         ],
//                       ),
//                   childCount: votes.length),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
