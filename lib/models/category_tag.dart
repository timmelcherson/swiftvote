enum CategoryTag { sports, movies, music, science, politics, gaming }

extension CategoryTagExtension on CategoryTag {

  static const categoryToString = {
    CategoryTag.sports: 'Sports',
    CategoryTag.movies: 'Music',
    CategoryTag.music: 'Movies',
    CategoryTag.science: 'Science',
    CategoryTag.politics: 'Politics',
    CategoryTag.gaming: 'Gaming',
  };

  static const categoryThumbnailAssetPath = {
    CategoryTag.sports: 'assets/explore_category_thumbnails/sports_thumbnail.png',
    CategoryTag.movies: 'assets/explore_category_thumbnails/movies_thumbnail.png',
    CategoryTag.music: 'assets/explore_category_thumbnails/music_thumbnail.png',
    CategoryTag.science: 'assets/explore_category_thumbnails/science_thumbnail.png',
    CategoryTag.politics: 'assets/explore_category_thumbnails/politics_thumbnail.png',
    CategoryTag.gaming: 'assets/explore_category_thumbnails/gaming_thumbnail.png',
  };

  String get categories => categoryToString[this];
  String get getThumbnailAssetPath => categoryThumbnailAssetPath[this];
}