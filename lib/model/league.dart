import 'package:json_annotation/json_annotation.dart';

part 'league.g.dart';

@JsonSerializable()
class League {
  final String strLeague;
  final String strSport;
  final String strLeagueAlternate;

  League(this.strLeague, this.strSport, this.strLeagueAlternate);

  factory League.fromJson(Map<String, dynamic> json) => _$LeagueFromJson(json);




}