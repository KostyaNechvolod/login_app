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