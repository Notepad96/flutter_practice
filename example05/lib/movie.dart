class Movie {
  late int id;
  late String title;
  late double voteAverage;
  late String releaseDate;
  late String overview;
  late String posterPath;

  Movie(this.id, this.title, this.voteAverage, this.releaseDate, this.overview, this.posterPath);

  Movie.fromJson(Map<String, dynamic> parseJson) {
    id = parseJson['id'];
    title = parseJson['title'];
    voteAverage = parseJson['vote_average']*1.0;
    releaseDate = parseJson['release_date'];
    overview = parseJson['overview'];
    posterPath = parseJson['poster_path'];
  }
}