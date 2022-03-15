// To parse this JSON data, do
//
//     final movieDetail = movieDetailFromJson(jsonString);

import 'dart:convert';

MovieDetailResponse movieDetailFromJson(String str) =>
    MovieDetailResponse.fromJson(json.decode(str));

String movieDetailToJson(MovieDetailResponse data) =>
    json.encode(data.toJson());

class MovieDetailResponse {
  MovieDetailResponse({
    required this.adult,
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.originalLanguage,
    required this.overview,
    required this.posterPath,
    required this.title,
    required this.voteAverage,
  });

  bool adult;
  String backdropPath;
  List<Genre> genres;
  int id;
  String originalLanguage;
  String overview;
  String posterPath;
  String title;
  double voteAverage;

  factory MovieDetailResponse.fromJson(Map<dynamic, dynamic> json) =>
      MovieDetailResponse(
        adult: json["adult"],
        backdropPath: json["backdrop_path"] ?? "",
        genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
        id: json["id"],
        originalLanguage: json["original_language"],
        overview: json["overview"],
        posterPath: json["poster_path"] ?? "",
        title: json["title"] ?? json["name"] ?? "",
        voteAverage: json["vote_average"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "id": id,
        "original_language": originalLanguage,
        "overview": overview,
        "poster_path": posterPath,
        "title": title,
        "vote_average": voteAverage,
      };
}

class BelongsToCollection {
  BelongsToCollection({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.backdropPath,
  });

  int id;
  String name;
  String posterPath;
  String backdropPath;

  factory BelongsToCollection.fromJson(Map<dynamic, dynamic> json) =>
      BelongsToCollection(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        posterPath: json["poster_path"] ?? "",
        backdropPath: json["backdrop_path"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "poster_path": posterPath,
        "backdrop_path": backdropPath,
      };
}

class Genre {
  Genre({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Genre.fromJson(Map<dynamic, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class ProductionCompany {
  ProductionCompany({
    required this.id,
    required this.logoPath,
    required this.name,
    required this.originCountry,
  });

  int id;
  String logoPath;
  String name;
  String originCountry;

  factory ProductionCompany.fromJson(Map<dynamic, dynamic> json) =>
      ProductionCompany(
        id: json["id"],
        logoPath: json["logo_path"] ?? "",
        name: json["name"],
        originCountry: json["origin_country"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "logo_path": logoPath,
        "name": name,
        "origin_country": originCountry,
      };
}

class ProductionCountry {
  ProductionCountry({
    required this.iso31661,
    required this.name,
  });

  String iso31661;
  String name;

  factory ProductionCountry.fromJson(Map<dynamic, dynamic> json) =>
      ProductionCountry(
        iso31661: json["iso_3166_1"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "iso_3166_1": iso31661,
        "name": name,
      };
}

class SpokenLanguage {
  SpokenLanguage({
    required this.englishName,
    required this.iso6391,
    required this.name,
  });

  String englishName;
  String iso6391;
  String name;

  factory SpokenLanguage.fromJson(Map<dynamic, dynamic> json) => SpokenLanguage(
        englishName: json["english_name"],
        iso6391: json["iso_639_1"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "english_name": englishName,
        "iso_639_1": iso6391,
        "name": name,
      };
}
