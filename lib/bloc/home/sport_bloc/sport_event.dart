abstract class SportListEvent {}

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