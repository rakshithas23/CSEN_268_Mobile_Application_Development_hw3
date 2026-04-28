import 'package:equatable/equatable.dart';
import 'book.dart';

enum SortType { author, title }

abstract class BookState extends Equatable {
  const BookState();
  @override
  List<Object?> get props => [];
}

class BookLoading extends BookState {}

class SortedByAuthor extends BookState {
  final List<Book> books;

  const SortedByAuthor({required this.books});

  @override
  List<Object?> get props => [books];
}

class SortedByTitle extends BookState {
  final List<Book> books;

  const SortedByTitle({required this.books});

  @override
  List<Object?> get props => [books];
}

class BookDetailView extends BookState {
  final Book book;
  final List<Book> books;
  final SortType sortType;

  const BookDetailView({
    required this.book,
    required this.books,
    required this.sortType,
  });

  @override
  List<Object?> get props => [book, books, sortType];
}