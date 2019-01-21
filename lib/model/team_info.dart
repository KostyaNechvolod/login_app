import 'package:json_annotation/json_annotation.dart';

part 'team_info.g.dart';

@JsonSerializable()
class Team {
  final String strTeam;
  final String intFormedYear;
  final String strLeague;
  final String strManager;
  final String strStadium;
  final String strStadiumThumb;
  final String strStadiumLocation;
  final String intStadiumCapacity;
  final String strTeamBadge;
  final String strTeamJersey;
  final String strDescriptionEN;
  final String strYoutube;
  final String strTwitter;
  final String strInstagram;
  final String strFacebook;
  final String strWebsite;

  Team(
      this.strTeam,
      this.intFormedYear,
      this.strLeague,
      this.strManager,
      this.strStadium,
      this.strStadiumThumb,
      this.strStadiumLocation,
      this.intStadiumCapacity,
      this.strTeamBadge,
      this.strTeamJersey,
      this.strDescriptionEN,
      this.strYoutube,
      this.strTwitter,
      this.strInstagram,
      this.strFacebook,
      this.strWebsite);

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);
}
