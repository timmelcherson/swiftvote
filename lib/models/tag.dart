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

  String get categories => categoryToString[this];
}