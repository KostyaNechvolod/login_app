import 'package:login_app/model/model.dart';

class LeagueState {
  final bool isInitializing;
  final List<League> listElements;
  final bool isError;
  final bool hasReachedMax;

  LeagueState({
    this.isError,
    this.isInitializing,
    this.listElements,
    this.hasReachedMax,
  });

  factory LeagueState.initial() {
    return LeagueState(
      isInitializing: true,
      listElements: [],
      isError: false,
      hasReachedMax: false,
    );
  }

  factory LeagueState.success(List<League> listElements) {
    return LeagueState(
      isInitializing: false,
      listElements: listElements,
      isError: false,
      hasReachedMax: false,
    );
  }

  factory LeagueState.failure() {
    return LeagueState(
      isInitializing: false,
      listElements: [],
      isError: true,
      hasReachedMax: false,
    );
  }

  LeagueState copyWith({
    bool isInitializing,
    List<League> listElements,
    bool isError,
    bool hasReachedMax,
  }) {
    return LeagueState(
      isInitializing: isInitializing ?? this.isInitializing,
      listElements: listElements ?? this.listElements,
      isError: isError ?? this.isError,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() =>
      'LeagueState { isInitializing: $isInitializing, listElements: ${listElements.length.toString()}, isError: $isError, hasReachedMax: $hasReachedMax }';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is LeagueState &&
              runtimeType == other.runtimeType &&
              isInitializing == other.isInitializing &&
              listElements == other.listElements &&
              isError == other.isError;

  @override
  int get hashCode =>
      isInitializing.hashCode ^ listElements.hashCode ^ isError.hashCode;
}