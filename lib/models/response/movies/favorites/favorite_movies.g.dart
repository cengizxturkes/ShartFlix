// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_movies.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteMovies _$FavoriteMoviesFromJson(Map<String, dynamic> json) =>
    FavoriteMovies(
      response: Response.fromJson(json['response'] as Map<String, dynamic>),
      data: (json['data'] as List<dynamic>)
          .map((e) => FavoriteMoviesData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FavoriteMoviesToJson(FavoriteMovies instance) =>
    <String, dynamic>{
      'response': instance.response,
      'data': instance.data,
    };

FavoriteMoviesData _$FavoriteMoviesDataFromJson(Map<String, dynamic> json) =>
    FavoriteMoviesData(
      id: json['_id'] as String,
      title: json['Title'] as String,
      year: json['Year'] as String,
      rated: json['Rated'] as String,
      released: json['Released'] as String,
      runtime: json['Runtime'] as String,
      genre: json['Genre'] as String,
      director: json['Director'] as String,
      writer: json['Writer'] as String,
      actors: json['Actors'] as String,
      plot: json['Plot'] as String,
      language: json['Language'] as String,
      country: json['Country'] as String,
      awards: json['Awards'] as String,
      poster: json['Poster'] as String,
      metascore: json['Metascore'] as String,
      imdbRating: json['imdbRating'] as String,
      imdbVotes: json['imdbVotes'] as String,
      imdbId: json['imdbID'] as String,
      type: json['Type'] as String,
      response: json['Response'] as String,
      images:
          (json['Images'] as List<dynamic>).map((e) => e as String).toList(),
      comingSoon: json['ComingSoon'] as bool,
      isFavorite: json['isFavorite'] as bool,
    );

Map<String, dynamic> _$FavoriteMoviesDataToJson(FavoriteMoviesData instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'Title': instance.title,
      'Year': instance.year,
      'Rated': instance.rated,
      'Released': instance.released,
      'Runtime': instance.runtime,
      'Genre': instance.genre,
      'Director': instance.director,
      'Writer': instance.writer,
      'Actors': instance.actors,
      'Plot': instance.plot,
      'Language': instance.language,
      'Country': instance.country,
      'Awards': instance.awards,
      'Poster': instance.poster,
      'Metascore': instance.metascore,
      'imdbRating': instance.imdbRating,
      'imdbVotes': instance.imdbVotes,
      'imdbID': instance.imdbId,
      'Type': instance.type,
      'Response': instance.response,
      'Images': instance.images,
      'ComingSoon': instance.comingSoon,
      'isFavorite': instance.isFavorite,
    };

Response _$ResponseFromJson(Map<String, dynamic> json) => Response(
      code: (json['code'] as num).toInt(),
      message: json['message'] as String,
    );

Map<String, dynamic> _$ResponseToJson(Response instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
    };
