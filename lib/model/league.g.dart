// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'league.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

League _$LeagueFromJson(Map<String, dynamic> json) {
  return League(json['strLeague'] as String, json['strSport'] as String,
      json['strLeagueAlternate'] as String);
}

Map<String, dynamic> _$LeagueToJson(League instance) => <String, dynamic>{
      'strLeague': instance.strLeague,
      'strSport': instance.strSport,
      'strLeagueAlternate': instance.strLeagueAlternate
    };
