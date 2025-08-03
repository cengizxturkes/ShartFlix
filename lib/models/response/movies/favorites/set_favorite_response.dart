// To parse this JSON data, do
//
//     final setFavoriteResponse = setFavoriteResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'set_favorite_response.g.dart';

SetFavoriteResponse setFavoriteResponseFromJson(String str) =>
    SetFavoriteResponse.fromJson(json.decode(str));

String setFavoriteResponseToJson(SetFavoriteResponse data) =>
    json.encode(data.toJson());

@JsonSerializable()
class SetFavoriteResponse {
  @JsonKey(name: "response")
  Response response;
  @JsonKey(name: "data")
  Data data;

  SetFavoriteResponse({required this.response, required this.data});

  SetFavoriteResponse copyWith({Response? response, Data? data}) =>
      SetFavoriteResponse(
        response: response ?? this.response,
        data: data ?? this.data,
      );

  factory SetFavoriteResponse.fromJson(Map<String, dynamic> json) =>
      _$SetFavoriteResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SetFavoriteResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "movie")
  Movie movie;
  @JsonKey(name: "action")
  String action;

  Data({required this.movie, required this.action});

  Data copyWith({Movie? movie, String? action}) =>
      Data(movie: movie ?? this.movie, action: action ?? this.action);

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Movie {
  @JsonKey(name: "_id")
  String id;
  @JsonKey(name: "id")
  String movieId;
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

  Movie({
    required this.id,
    required this.movieId,
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

  Movie copyWith({
    String? id,
    String? movieId,
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
  }) => Movie(
    id: id ?? this.id,
    movieId: movieId ?? this.movieId,
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

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  Map<String, dynamic> toJson() => _$MovieToJson(this);
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
