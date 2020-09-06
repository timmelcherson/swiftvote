enum Category {
  art_and_literature,
  economy,
  esports,
  health_and_body,
  household,
  movies_and_series,
  music,
  politics_and_society,
  science,
  sex_and_relations,
  sports,
  technology,
  travel,
}

extension CategoryExtension on Category {

  static const categoryToString = {
    Category.art_and_literature: 'Art & Literature',
    Category.economy: 'Economy',
    Category.esports: 'E-sports',
    Category.health_and_body: 'Health & Body',
    Category.household: 'Household',
    Category.movies_and_series: 'Movies & Series',
    Category.music: 'Music',
    Category.politics_and_society: 'Politics & Society',
    Category.science: 'Science',
    Category.sex_and_relations: 'Sex & Relations',
    Category.sports: 'Sports',
    Category.technology: 'Technology',
    Category.travel: 'Travel',
  };

  static const categoryThumbnailAssetPath = {
    Category.art_and_literature: 'assets/category_thumbnails/art_and_literature_thumbnail.png',
    Category.economy: 'assets/category_thumbnails/economy_thumbnail.png',
    Category.esports: 'assets/category_thumbnails/esports_thumbnail.png',
    Category.health_and_body: 'assets/category_thumbnails/health_and_body_thumbnail.png',
    Category.household: 'assets/category_thumbnails/movies_and_series_thumbnail.png',
    Category.movies_and_series: 'assets/category_thumbnails/movies_and_series_thumbnail.png',
    Category.music: 'assets/category_thumbnails/music_thumbnail.png',
    Category.politics_and_society: 'assets/category_thumbnails/politics_and_society_thumbnail.png',
    Category.science: 'assets/category_thumbnails/science_thumbnail.png',
    Category.sex_and_relations: 'assets/category_thumbnails/sex_and_relations_thumbnail.png',
    Category.sports: 'assets/category_thumbnails/sports_thumbnail.png',
    Category.technology: 'assets/category_thumbnails/technology_thumbnail.png',
    Category.travel: 'assets/category_thumbnails/travel_thumbnail.png',
  };

  String get categories => categoryToString[this];
  String get getThumbnailAssetPath => categoryThumbnailAssetPath[this];
}