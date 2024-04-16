# Cubit + StreamSubscription을 이용한 ToDo App


# Advanced Event Transformer
Bloc 7.2.0 부터 추가된 `EventTransformer`는 `EventMapper`를 인자로 받고 새로운 stream event를 반환한다.  

**EventTransformer**를 사용한 debounce
[Advanced Event Transformations 예제](https://bloclibrary.dev/bloc-concepts/#advanced-event-transformations)
```dart
EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}

CounterBloc() : super(0) {
on<Increment>(
(event, emit) => emit(state + 1),
/// Apply the custom `EventTransformer` to the `EventHandler`.
transformer: debounce(const Duration(milliseconds: 300)),
);
}
```

RxDart 로 Debounce 사용
