import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'todo_search_event.dart';
part 'todo_search_state.dart';

class TodoSearchBloc extends Bloc<TodoSearchEvent, TodoSearchState> {
  TodoSearchBloc() : super(TodoSearchState.initial()) {
    on<SetSearchTermEvent>((event, emit) {
      emit(state.copyWith(searchTerm: event.newSearchTerm));
    }, transformer: debounce(const Duration(milliseconds: 1500)));
  }

  // RxDart에서 제공하는 debounce 사용
  EventTransformer<SetSearchTermEvent> debounce<SetSearchTermEvent>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
