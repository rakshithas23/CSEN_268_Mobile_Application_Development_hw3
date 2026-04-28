import 'package:equatable/equatable.dart';
import 'book.dart';

enum SortType { author, title }

abstract class BookState extends Equatable {
  @override
  List<Object?> get props => [];
}

class BookLoading extends BookState {}

class BookListView extends BookState {
  final List<Book> books;
  final SortType sortType;

  BookListView({
    required this.books,
    required this.sortType,
  });

  
  @override
  List<Object?> get props => [];
}

class BookDetailView extends BookState {
  final Book book;
  final List<Book> books;
  final SortType sortType;

  BookDetailView({
    required this.book,
    required this.books,
    required this.sortType,
  });

  @override
  List<Object?> get props => [book];
}