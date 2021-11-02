import 'package:meta/meta.dart';

@immutable
abstract class NavigationEvent {
  const NavigationEvent();

  List<Object> get props => [];
}

class MainNavBarTapEvent extends NavigationEvent {

  final int index;

  MainNavBarTapEvent({required this.index});
}
