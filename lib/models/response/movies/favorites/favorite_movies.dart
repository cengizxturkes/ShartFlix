// To parse this JSON data, do
//
//     final favoriteMovies = favoriteMoviesFromJson(jsonString);

// ignore: unused_import
import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'favorite_movies.g.dart';

FavoriteMovies favoriteMoviesFromJson(String str) =>
    FavoriteMovies.fromJson(json.decode(str));

String favoriteMoviesToJson(FavoriteMovies data) => json.encode(data.toJson());

@JsonSerializable()
class FavoriteMovies {
  @JsonKey(name: "response")
  Response response;
  @JsonKey(name: "data")
  List<FavoriteMoviesData> data;

  FavoriteMovies({required this.response, required this.data});

  FavoriteMovies copyWith({
    Response? response,
    List<FavoriteMoviesData>? data,
  }) => FavoriteMovies(
    response: response ?? this.response,
    data: data ?? this.data,
  );

  factory FavoriteMovies.fromJson(Map<String, dynamic> json) =>
      _$FavoriteMoviesFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteMoviesToJson(this);
}

@JsonSerializable()
class FavoriteMoviesData {
  @JsonKey(name: "_id")
  String id;
  @JsonKey(name: "Title")
  String title;
  @JsonKey(name: "Year")
  String year;
  @JsonKey(name: "Rated")
  String rated;
  @JsonKey(name: "Released")
  String released;
  @JsonKey(name: "Runtime")
  String runtime;
  @JsonKey(name: "Genre")
  String genre;
  @JsonKey(name: "Director")
  String director;
  @JsonKey(name: "Writer")
  String writer;
  @JsonKey(name: "Actors")
  String actors;
  @JsonKey(name: "Plot")
  String plot;
  @JsonKey(name: "Language")
  String language;
  @JsonKey(name: "Country")
  String country;
  @JsonKey(name: "Awards")
  String awards;
  @JsonKey(name: "Poster")
  String poster;
  @JsonKey(name: "Metascore")
  String metascore;
  @JsonKey(name: "imdbRating")
  String imdbRating;
  @JsonKey(name: "imdbVotes")
  String imdbVotes;
  @JsonKey(name: "imdbID")
  String imdbId;
  @JsonKey(name: "Type")
  String type;
  @JsonKey(name: "Response")
  String response;
  @JsonKey(name: "Images")
  List<String> images;
  @JsonKey(name: "ComingSoon")
  bool comingSoon;
  @JsonKey(name: "isFavorite")
  bool isFavorite;

  FavoriteMoviesData({
    required this.id,
    required this.title,
    required this.year,
    required this.rated,
    required this.released,
    required this.runtime,
    required this.genre,
    required this.director,
    required this.writer,
    required this.actors,
    required this.plot,
    required this.language,
    required this.country,
    required this.awards,
    required this.poster,
    required this.metascore,
    required this.imdbRating,
    required this.imdbVotes,
    required this.imdbId,
    required this.type,
    required this.response,
    required this.images,
    required this.comingSoon,
    required this.isFavorite,
  });

  FavoriteMoviesData copyWith({
    String? id,
    String? FavoriteMoviesDataId,
    String? title,
    String? year,
    String? rated,
    String? released,
    String? runtime,
    String? genre,
    String? director,
    String? writer,
    String? actors,
    String? plot,
    String? language,
    String? country,
    String? awards,
    String? poster,
    String? metascore,
    String? imdbRating,
    String? imdbVotes,
    String? imdbId,
    String? type,
    String? response,
    List<String>? images,
    bool? comingSoon,
    bool? isFavorite,
  }) => FavoriteMoviesData(
    id: id ?? this.id,

    title: title ?? this.title,
    year: year ?? this.year,
    rated: rated ?? this.rated,
    released: released ?? this.released,
    runtime: runtime ?? this.runtime,
    genre: genre ?? this.genre,
    director: director ?? this.director,
    writer: writer ?? this.writer,
    actors: actors ?? this.actors,
    plot: plot ?? this.plot,
    language: language ?? this.language,
    country: country ?? this.country,
    awards: awards ?? this.awards,
    poster: poster ?? this.poster,
    metascore: metascore ?? this.metascore,
    imdbRating: imdbRating ?? this.imdbRating,
    imdbVotes: imdbVotes ?? this.imdbVotes,
    imdbId: imdbId ?? this.imdbId,
    type: type ?? this.type,
    response: response ?? this.response,
    images: images ?? this.images,
    comingSoon: comingSoon ?? this.comingSoon,
    isFavorite: isFavorite ?? this.isFavorite,
  );

  factory FavoriteMoviesData.fromJson(Map<String, dynamic> json) =>
      _$FavoriteMoviesDataFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteMoviesDataToJson(this);
}

@JsonSerializable()
class Response {
  @JsonKey(name: "code")
  int code;
  @JsonKey(name: "message")
  String message;

  Response({required this.code, required this.message});

  Response copyWith({int? code, String? message}) =>
      Response(code: code ?? this.code, message: message ?? this.message);

  factory Response.fromJson(Map<String, dynamic> json) =>
      _$ResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseToJson(this);
}
