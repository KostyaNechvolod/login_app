import 'package:login_app/model/model.dart';

class SportState {
  final bool isInitializing;
  final List<Sport> listElements;
  final bool isError;
  final bool hasReachedMax;

  SportState({
    this.isError,
    this.isInitializing,
    this.listElements,
    this.hasReachedMax,
  });

  factory SportState.initial() {
    return SportState(
      isInitializing: true,
      listElements: [],
      isError: false,
      hasReachedMax: false,
    );
  }

  factory SportState.success(List<Sport> listElements) {
    return SportState(
      isInitializing: false,
      listElements: listElements,
      isError: false,
      hasReachedMax: false,
    );
  }

  factory SportState.failure() {
    return SportState(
      isInitializing: false,
      listElements: [],
      isError: true,
      hasReachedMax: false,
    );
  }

  SportState copyWith({
    bool isInitializing,
    List<Sport> listElements,
    bool isError,
    bool hasReachedMax,
  }) {
    return SportState(
      isInitializing: isInitializing ?? this.isInitializing,
      listElements: listElements ?? this.listElements,
      isError: isError ?? this.isError,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() =>
      'SportState { isInitializing: $isInitializing, listElements: ${listElements.length.toString()}, isError: $isError, hasReachedMax: $hasReachedMax }';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is SportState &&
              runtimeType == other.runtimeType &&
              isInitializing == other.isInitializing &&
              listElements == other.listElements &&
              isError == other.isError;

  @override
  int get hashCode =>
      isInitializing.hashCode ^ listElements.hashCode ^ isError.hashCode;
}

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

class TeamState {
  final bool isInitializing;
  final List<Team> listElements;
  final bool isError;
  final bool hasReachedMax;

  TeamState({
    this.isError,
    this.isInitializing,
    this.listElements,
    this.hasReachedMax,
  });

  factory TeamState.initial() {
    return TeamState(
      isInitializing: true,
      listElements: [],
      isError: false,
      hasReachedMax: false,
    );
  }

  factory TeamState.success(List<Team> listElements) {
    return TeamState(
      isInitializing: false,
      listElements: listElements,
      isError: false,
      hasReachedMax: false,
    );
  }

  factory TeamState.failure() {
    return TeamState(
      isInitializing: false,
      listElements: [],
      isError: true,
      hasReachedMax: false,
    );
  }

  TeamState copyWith({
    bool isInitializing,
    List<Team> listElements,
    bool isError,
    bool hasReachedMax,
  }) {
    return TeamState(
      isInitializing: isInitializing ?? this.isInitializing,
      listElements: listElements ?? this.listElements,
      isError: isError ?? this.isError,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() =>
      'TeamState { isInitializing: $isInitializing, listElements: ${listElements.length.toString()}, isError: $isError, hasReachedMax: $hasReachedMax }';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is TeamState &&
              runtimeType == other.runtimeType &&
              isInitializing == other.isInitializing &&
              listElements == other.listElements &&
              isError == other.isError;

  @override
  int get hashCode =>
      isInitializing.hashCode ^ listElements.hashCode ^ isError.hashCode;
}
