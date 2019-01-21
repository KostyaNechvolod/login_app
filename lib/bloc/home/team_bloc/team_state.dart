import 'package:login_app/model/model.dart';

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