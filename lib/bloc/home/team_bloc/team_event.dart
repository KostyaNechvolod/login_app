abstract class TeamListEvent {}

class FetchTeamByName extends TeamListEvent {
  String teamName;

  FetchTeamByName(this.teamName);

  @override
  String toString() => 'Fetch team';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is FetchTeamByName && runtimeType == other.runtimeType;

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
          other is FetchTeam && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;
}