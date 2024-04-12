part of 'todo_search_cubit.dart';

// 단순 String만 갖는 state인데도 class로 만드는 이유
// 1. 모든 상태를 다루는데 있어서 일관성 유지
// 2. 타입 충돌 예방 (같은 타입의 다른 상태가 있으면 of(context)에서 잘못 찾을 수 있음
class TodoSearchState extends Equatable {
  final String searchTerm;

  const TodoSearchState({
    required this.searchTerm
  });

  factory TodoSearchState.initial() =>
      const TodoSearchState(searchTerm: '');

  @override
  List<Object> get props => [searchTerm];

  @override
  String toString() {
    return 'TodoSearchState{searchTerm: $searchTerm}';
  }

  TodoSearchState copyWith({
    String? searchTerm,
  }) {
    return TodoSearchState(
      searchTerm: searchTerm ?? this.searchTerm,
    );
  }
}
