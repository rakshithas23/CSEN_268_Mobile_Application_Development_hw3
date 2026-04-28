import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'book_bloc.dart';
import 'book_event.dart';
import 'book_state.dart';
import 'book.dart';

void main() {
  runApp(const BookClubApp());
}

class BookClubApp extends StatelessWidget {
  const BookClubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BookBloc()..add(LoadBooks()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Book Club',
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFFFEF7FF),
            foregroundColor: Colors.black,
            elevation: 0,
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookBloc, BookState>(
      builder: (context, state) {

        if (state is BookLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (state is BookDetailView) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text('Book Detail'),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => context.read<BookBloc>().add(BackToList()),
              ),
              actions: const [
                Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: Icon(Icons.person_outline),
                ),
              ],
            ),
            body: BookDetailWidget(book: state.book),
          );
        }

        if (state is SortedByAuthor || state is SortedByTitle) {
          final books = state is SortedByAuthor
              ? (state as SortedByAuthor).books
              : (state as SortedByTitle).books;

          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              leading: const Icon(Icons.menu),
              title: const Text(
                'Book Club Home',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
              ),
              actions: const [
                Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: Icon(Icons.person_outline),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Sort by',
                        style: TextStyle(fontSize: 13, color: Colors.black54),
                      ),
                      const SizedBox(width: 10),
                      _SortChip(
                        label: 'Author',
                        selected: state is SortedByAuthor,
                        onTap: () =>
                            context.read<BookBloc>().add(SortByAuthor()),
                      ),
                      const SizedBox(width: 8),
                      _SortChip(
                        label: 'Title',
                        // Selected when state runtimeType is SortedByTitle
                        selected: state is SortedByTitle,
                        onTap: () =>
                            context.read<BookBloc>().add(SortByTitle()),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Books',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 160,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: books.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 10),
                      itemBuilder: (context, index) {
                        final book = books[index];
                        return GestureDetector(
                          onTap: () =>
                              context.read<BookBloc>().add(SelectBook(book)),
                          child: BookThumbnailWidget(book: book),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}

class _SortChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _SortChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFE8DEF8) : Colors.transparent,
          border: Border.all(
            color: selected ? const Color(0xFFE8DEF8) : Colors.grey.shade400,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}

class BookThumbnailWidget extends StatelessWidget {
  final Book book;

  const BookThumbnailWidget({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        book.imageUrl,
        width: 100,
        height: 160,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          width: 100,
          height: 160,
          color: Colors.grey.shade300,
          child: const Icon(Icons.book, size: 36, color: Colors.grey),
        ),
        loadingBuilder: (_, child, progress) {
          if (progress == null) return child;
          return Container(
            width: 100,
            height: 160,
            color: Colors.grey.shade200,
            child: const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        },
      ),
    );
  }
}

class BookDetailWidget extends StatelessWidget {
  final Book book;

  const BookDetailWidget({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      book.imageUrl,
                      height: 280,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        height: 280,
                        color: Colors.grey.shade300,
                        child: const Icon(Icons.book,
                            size: 60, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  book.title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Text(
                  book.author,
                  style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 16),
                Text(
                  book.description,
                  style: const TextStyle(fontSize: 14, height: 1.6),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}