part of 'filter_mark_cubit.dart';

enum FilterMark { title, author }

@immutable
final class FilterMarkState extends Equatable {
  final FilterMark filter;

  const FilterMarkState._({required this.filter});

  factory FilterMarkState.title(FilterMark filterMark){
    return FilterMarkState._(filter: filterMark);
  }

  factory FilterMarkState.author(FilterMark filterMark){
    return FilterMarkState._(filter: filterMark);
  }

  @override
  List<Object?> get props => [filter];
}
