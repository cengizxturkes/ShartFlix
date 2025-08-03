// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_favorite_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SetFavoriteResponse _$SetFavoriteResponseFromJson(Map<String, dynamic> json) =>
    SetFavoriteResponse(
      response: Response.fromJson(json['response'] as Map<String, dynamic>),
      data: Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SetFavoriteResponseToJson(
        SetFavoriteResponse instance) =>
    <String, dynamic>{
      'response': instance.response,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      movie: Movie.fromJson(json['movie'] as Map<String, dynamic>),
      action: json['action'] as String,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'movie': instance.movie,
      'action': instance.action,
    };

Movie _$MovieFromJson(Map<String, dynamic> json) => Movie(
      id: json['_id'] as String,
      movieId: json['id'] as String,
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

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      '_id': instance.id,
      'id': instance.movieId,
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
