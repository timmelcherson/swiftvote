import 'package:flutter/material.dart';

enum Category {
  ART_AND_LITERATURE,
  ECONOMY,
  E_SPORTS,
  FOOD_AND_DRINK,
  HEALTH_AND_BODY,
  HOUSEHOLD,
  MOVIES_AND_TV,
  MUSIC,
  POLITICS_AND_SOCIETY,
  SCIENCE,
  SEX_AND_RELATIONS,
  SPORTS,
  TECHNOLOGY_AND_IT,
  TRAVEL,
}

extension CategoryExtension on Category {

  static const categoryToString = {
    Category.ART_AND_LITERATURE: 'Art & Literature',
    Category.ECONOMY: 'Economy',
    Category.E_SPORTS: 'E-sports',
    Category.FOOD_AND_DRINK: 'Food & Drink',
    Category.HEALTH_AND_BODY: 'Health & Body',
    Category.HOUSEHOLD: 'Household',
    Category.MOVIES_AND_TV: 'Movies & TV',
    Category.MUSIC: 'Music',
    Category.POLITICS_AND_SOCIETY: 'Politics & Society',
    Category.SCIENCE: 'Science',
    Category.SEX_AND_RELATIONS: 'Sex & Relations',
    Category.SPORTS: 'Sports',
    Category.TECHNOLOGY_AND_IT: 'Technology & IT',
    Category.TRAVEL: 'Travel',
  };

  static const categoryThumbnailAssetPath = {
    Category.ART_AND_LITERATURE: 'assets/category_thumbnails/art_and_literature_thumbnail.png',
    Category.ECONOMY: 'assets/category_thumbnails/economy_thumbnail.png',
    Category.E_SPORTS: 'assets/category_thumbnails/esports_thumbnail.png',
    Category.FOOD_AND_DRINK: 'assets/category_thumbnails/esports_thumbnail.png',
    Category.HEALTH_AND_BODY: 'assets/category_thumbnails/health_and_body_thumbnail.png',
    Category.HOUSEHOLD: 'assets/category_thumbnails/MOVIES_AND_TV_thumbnail.png',
    Category.MOVIES_AND_TV: 'assets/category_thumbnails/MOVIES_AND_TV_thumbnail.png',
    Category.MUSIC: 'assets/category_thumbnails/music_thumbnail.png',
    Category.POLITICS_AND_SOCIETY: 'assets/category_thumbnails/politics_and_society_thumbnail.png',
    Category.SCIENCE: 'assets/category_thumbnails/science_thumbnail.png',
    Category.SEX_AND_RELATIONS: 'assets/category_thumbnails/sex_and_relations_thumbnail.png',
    Category.SPORTS: 'assets/category_thumbnails/sports_thumbnail.png',
    Category.TECHNOLOGY_AND_IT: 'assets/category_thumbnails/TECHNOLOGY_AND_IT_thumbnail.png',
    Category.TRAVEL: 'assets/category_thumbnails/travel_thumbnail.png',
  };

  static const categoryThumbnails = {
    Category.ART_AND_LITERATURE: Icons.book_outlined,
    Category.ECONOMY: Icons.attach_money_outlined,
    Category.E_SPORTS: Icons.sports_esports_outlined,
    Category.FOOD_AND_DRINK: Icons.fastfood_outlined,
    Category.HEALTH_AND_BODY: Icons.healing_outlined,
    Category.HOUSEHOLD: Icons.house_outlined,
    Category.MOVIES_AND_TV: Icons.movie_outlined,
    Category.MUSIC: Icons.music_note_outlined,
    Category.POLITICS_AND_SOCIETY: Icons.people_outlined,
    Category.SCIENCE: Icons.science_outlined,
    Category.SEX_AND_RELATIONS: Icons.arrow_upward_outlined,
    Category.SPORTS: Icons.sports_handball_outlined,
    Category.TECHNOLOGY_AND_IT: Icons.biotech_outlined,
    Category.TRAVEL: Icons.airplanemode_active_outlined,
  };

  String? get categories => categoryToString[this];
  String? get getThumbnailAssetPath => categoryThumbnailAssetPath[this];
  IconData? get getCategoryThumbnails => categoryThumbnails[this];
}