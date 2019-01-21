abstract class SportListEvent {}
abstract class LeagueListEvent {}
abstract class TeamListEvent {}

class FetchSport extends SportListEvent {
  @override
  String toString() => 'Fetch sport';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is FetchSport && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;
}

class FetchLeagueWithParam extends LeagueListEvent {
  String _country = '';
  String _sport = '';

  String get country => _country;
  String get sport => _sport;

  FetchLeagueWithParam(this._country, this._sport);

  @override
  String toString() => 'Fetch league';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is FetchLeagueWithParam && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;
}

class FetchTeamByName extends TeamListEvent {
  String teamName;

  FetchTeamByName(this.teamName);

  @override
  String toString() => 'Fetch team';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is FetchSport && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;
}

class FetchTeam extends TeamListEvent {
  String leagueName;

  FetchTeam(this.leagueName);
    @override
  String toString() => 'Fetch team';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is FetchSport && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

}