import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class NavigationState extends Equatable {
  const NavigationState();

  @override
  List<Object> get props => [];
}

class MainNavBarState extends NavigationState {

  final int index;

  MainNavBarState({this.index});

  @override
  List<Object> get props => [index];
}