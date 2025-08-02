// To parse this JSON data, do
//
//     final listMoviesResponse = listMoviesResponseFromJson(jsonString);

// ignore: unused_import
import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'list_movies_response.g.dart';

ListMoviesResponse listMoviesResponseFromJson(String str) =>
    ListMoviesResponse.fromJson(json.decode(str));

String listMoviesResponseToJson(ListMoviesResponse data) =>
    json.encode(data.toJson());

@JsonSerializable()
class ListMoviesResponse {
  @JsonKey(name: "response")
  Response response;
  @JsonKey(name: "data")
  Data data;

  ListMoviesResponse({required this.response, required this.data});

  ListMoviesResponse copyWith({Response? response, Data? data}) =>
      ListMoviesResponse(
        response: response ?? this.response,
        data: data ?? this.data,
      );

  factory ListMoviesResponse.fromJson(Map<String, dynamic> json) =>
      _$ListMoviesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListMoviesResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "movies")
  List<Movie> movies;
  @JsonKey(name: "pagination")
  Pagination pagination;

  Data({required this.movies, required this.pagination});

  Data copyWith({List<Movie>? movies, Pagination? pagination}) => Data(
    movies: movies ?? this.movies,
    pagination: pagination ?? this.pagination,
  );

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Movie {
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

  Movie({
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
class Pagination {
  @JsonKey(name: "totalCount")
  int totalCount;
  @JsonKey(name: "perPage")
  int perPage;
  @JsonKey(name: "maxPage")
  int maxPage;
  @JsonKey(name: "currentPage")
  int currentPage;

  Pagination({
    required this.totalCount,
    required this.perPage,
    required this.maxPage,
    required this.currentPage,
  });

  Pagination copyWith({
    int? totalCount,
    int? perPage,
    int? maxPage,
    int? currentPage,
  }) => Pagination(
    totalCount: totalCount ?? this.totalCount,
    perPage: perPage ?? this.perPage,
    maxPage: maxPage ?? this.maxPage,
    currentPage: currentPage ?? this.currentPage,
  );

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationToJson(this);
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
