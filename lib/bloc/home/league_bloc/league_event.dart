abstract class LeagueListEvent {}

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