part of 'book_get_bloc.dart';

abstract class BookGetEvent extends Equatable {
  const BookGetEvent();

  @override
  List<Object?> get props => [];
}

class LoadBooksEvent extends BookGetEvent {}
