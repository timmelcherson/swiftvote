enum Category {
  ART_AND_LITERATURE,
  ECONOMY,
  E_SPORTS,
  HEALTH_AND_BODY,
  HOUSEHOLD,
  MOVIES_AND_SERIES,
  MUSIC,
  POLITICS_AND_SOCIETY,
  SCIENCE,
  SEX_AND_RELATIONS,
  SPORTS,
  TECHNOLOGY,
  TRAVEL,
}

extension CategoryExtension on Category {

  static const categoryToString = {
    Category.ART_AND_LITERATURE: 'Art & Literature',
    Category.ECONOMY: 'Economy',
    Category.E_SPORTS: 'E-sports',
    Category.HEALTH_AND_BODY: 'Health & Body',
    Category.HOUSEHOLD: 'Household',
    Category.MOVIES_AND_SERIES: 'Movies & Series',
    Category.MUSIC: 'Music',
    Category.POLITICS_AND_SOCIETY: 'Politics & Society',
    Category.SCIENCE: 'Science',
    Category.SEX_AND_RELATIONS: 'Sex & Relations',
    Category.SPORTS: 'Sports',
    Category.TECHNOLOGY: 'Technology',
    Category.TRAVEL: 'Travel',
  };

  static const categoryThumbnailAssetPath = {
    Category.ART_AND_LITERATURE: 'assets/category_thumbnails/art_and_literature_thumbnail.png',
    Category.ECONOMY: 'assets/category_thumbnails/economy_thumbnail.png',
    Category.E_SPORTS: 'assets/category_thumbnails/esports_thumbnail.png',
    Category.HEALTH_AND_BODY: 'assets/category_thumbnails/health_and_body_thumbnail.png',
    Category.HOUSEHOLD: 'assets/category_thumbnails/movies_and_series_thumbnail.png',
    Category.MOVIES_AND_SERIES: 'assets/category_thumbnails/movies_and_series_thumbnail.png',
    Category.MUSIC: 'assets/category_thumbnails/music_thumbnail.png',
    Category.POLITICS_AND_SOCIETY: 'assets/category_thumbnails/politics_and_society_thumbnail.png',
    Category.SCIENCE: 'assets/category_thumbnails/science_thumbnail.png',
    Category.SEX_AND_RELATIONS: 'assets/category_thumbnails/sex_and_relations_thumbnail.png',
    Category.SPORTS: 'assets/category_thumbnails/sports_thumbnail.png',
    Category.TECHNOLOGY: 'assets/category_thumbnails/technology_thumbnail.png',
    Category.TRAVEL: 'assets/category_thumbnails/travel_thumbnail.png',
  };

  String get categories => categoryToString[this];
  String get getThumbnailAssetPath => categoryThumbnailAssetPath[this];
}