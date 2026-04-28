import 'package:flutter_bloc/flutter_bloc.dart';
import 'book.dart';
import 'book_event.dart';
import 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  List<Book> allBooks = [];

  BookBloc() : super(BookLoading()) {
    on<LoadBooks>(_loadBooks);
    on<SortByAuthor>(_sortByAuthor);
    on<SortByTitle>(_sortByTitle);
    on<SelectBook>(_selectBook);
    on<BackToList>(_backToList);
  }

  void _loadBooks(LoadBooks event, Emitter<BookState> emit) {
    allBooks = [
      const Book(
        id: '1',
        title: 'The Midnight Library',
        author: 'Matt Haig',
        description:
            'Between life and death there is a library, and the story Nora Seed tells herself about her own life is about to change.\n\n'
            'Nora has always dreamed of a different life — one where she pursued her passion for swimming, stayed with her first love, or moved to Australia with her best friend. Instead, at the age of 35, she finds herself utterly alone, her cat dead, her job gone, her music career abandoned, and feeling like a failure at everything.\n\n'
            'When she finds herself in the Midnight Library — a magical place between life and death, filled with an infinite number of books each representing a different life she could have lived — she is given the chance to undo her regrets. Each book she opens transports her into a different version of herself. But which life is the right one?\n\n'
            'A moving, funny, and uplifting novel about the choices we make, the paths not taken, and what it truly means to live a full and meaningful life.',
        imageUrl: 'https://covers.openlibrary.org/b/id/10909258-L.jpg',
      ),
      const Book(
        id: '2',
        title: 'Lessons in Chemistry',
        author: 'Bonnie Garmus',
        description:
            'Chemist Elizabeth Zott is not your average woman. In fact, Elizabeth Zott would be the first to point out that there is no such thing as an average woman.\n\n'
            'But it\'s 1961, and her all-male team at Hastings Research Institute takes a very different view. When her boss, Calvin Evans — the lonely, brilliant, Nobel Prize–nominated scientist — falls in love with her, life takes an unexpected and actually quite wonderful turn. But like the best of science, things can change quickly: with a few failed experiments, a tragic accident, and a far-fetched idea that leads to a wildly successful cooking show called Supper at Six.\n\n'
            'Elizabeth Zott\'s unusual approach to cooking ("combine one tablespoon acetic acid with a pinch of sodium chloride") proves revolutionary. But as her fame grows, so does the danger of her past catching up to her. Because if there\'s one thing Elizabeth Zott knows, it\'s that women are capable of so much more than anyone believes.\n\n'
            'Laugh-out-loud funny, shrewdly observant, and enormously entertaining, Lessons in Chemistry is a novel about a woman ahead of her time and the power of a single person to change the world.',
        imageUrl: 'https://covers.openlibrary.org/b/id/12716726-L.jpg',
      ),
      const Book(
        id: '3',
        title: 'James and the Giant Peach',
        author: 'Roald Dahl',
        description:
            'James Henry Trotter is miserable. He lives with his two horrible aunts — the beastly Aunt Sponge and the horrific Aunt Spiker — who treat him terribly and make his life a misery.\n\n'
            'But one day a magic bag of crocodile tongues spills onto the roots of the old peach tree in the garden, and something extraordinary begins to happen. A single peach grows and grows until it is the size of a house — and inside it, James discovers a whole new world.\n\n'
            'Together with a cast of oversized, talking insects including a Centipede, an Earthworm, a Grasshopper, a Ladybird, a Glowworm, a Silkworm, and a Spider, James embarks on a spectacular journey across the Atlantic Ocean — riding the giant peach all the way to New York City.\n\n'
            'A beloved classic full of Roald Dahl\'s signature dark humour, imaginative storytelling, and unforgettable characters that has delighted readers of all ages for generations.',
        imageUrl: 'https://covers.openlibrary.org/b/id/8739161-L.jpg',
      ),
      const Book(
        id: '5',
        title: "Don't Look Back",
        author: 'Isaac Nelson',
        description:
            'When a woman wakes up on a rain-soaked road with no memory of who she is or how she got there, she has nothing — no name, no past, no idea who she can trust.\n\n'
            'Taken in by a small-town family who insist they\'ve never seen her before, she begins to piece together fragments of a life that grows more disturbing with every clue. Someone has gone to great lengths to make her disappear. And when the threats start, it becomes clear that whoever erased her memory has no intention of letting her remember.\n\n'
            'Racing against time as her past closes in, she must decide: some secrets are buried because the truth is too dangerous to survive. And some doors, once opened, cannot be closed.\n\n'
            'A propulsive, twisty psychological thriller about identity, memory, and the terrifying possibility that the person you were is not the person you want to be.',
        imageUrl: 'https://covers.openlibrary.org/b/id/10624058-L.jpg',
      ),
      const Book(
        id: '6',
        title: 'Circe',
        author: 'Madeline Miller',
        description:
            'In the house of Helios, god of the sun and mightiest of the Titans, a daughter is born. But Circe is a strange child — not powerful like her father, nor cruel like her mother. Scorned and dismissed, she turns to a realm the gods have not mastered: witchcraft.\n\n'
            'When her power grows too great for Olympus to ignore, Circe is exiled to the island of Aiaia. There she hones her craft, tames wild beasts, and begins to encounter the full sweep of a world on the cusp of change — the birth of humanity, the Minotaur, the craft of Daedalus, the voyage of the Argonauts.\n\n'
            'But there are those who will not let her live in peace. Among her enemies is Odysseus, the mortal who is her match in cunning; Penelope, his brilliant wife; and the dark power of Athena. Most threatening of all: Circe\'s own family, who will stop at nothing to protect Olympus from her growing strength.\n\n'
            'Madeline Miller brings the enchantress of the Odyssey fully to life in this spellbinding novel — part epic, part love story, part feminist myth-retelling.',
        imageUrl: 'https://covers.openlibrary.org/b/id/8737739-L.jpg',
      ),
      const Book(
        id: '7',
        title: 'The Great Alone',
        author: 'Kristin Hannah',
        description:
            'Alaska, 1974. Ernt Allbright comes home from the Vietnam War a changed and dangerous man. When he convinces his family to leave everything behind and move to remote, wild Alaska, his wife Cora and their teenage daughter Leni have no choice but to follow.\n\n'
            'In a place of staggering beauty and unforgiving wilderness, the Allbrights struggle to survive their first winter. As the days grow shorter and the darkness deepens, Ernt\'s fragile mental state begins to crack — and the land that once seemed like salvation reveals itself as something far more perilous.\n\n'
            'Leni falls in love for the first time, finding warmth and hope in a young man from a neighbouring family. But in Alaska, love must fight to survive against forces both natural and human — and some battles cannot be won.\n\n'
            'The Great Alone is a sweeping, heartbreaking story of a family in crisis and a young woman finding the courage to fight for her own survival in the most beautiful and brutal place on earth.',
        imageUrl: 'https://covers.openlibrary.org/b/id/8739355-L.jpg',
      ),
      const Book(
        id: '8',
        title: 'Normal People',
        author: 'Sally Rooney',
        description:
            'Connell and Marianne grew up in the same small town in rural Ireland, but the similarities end there. At school, Connell is popular and well-liked, while Marianne is a loner. But when Connell comes to pick up his mother from her job at Marianne\'s house, something sparks between them — something they are both determined to keep secret.\n\n'
            'A year later, they\'re both studying at Trinity College Dublin. Marianne has found her feet in a new world while Connell hangs at the edges, uncertain. Throughout their years at university, the two are pulled together and apart, by their own choices and the world\'s forces, and they fail, repeatedly, to say what they mean and mean what they say.\n\n'
            'Normal People is a novel about how a person can change another person\'s life — about the strange alchemy of compatibility, about why some relationships break us and others put us back together.\n\n'
            'Sally Rooney\'s second novel is a tender, precise, and utterly compelling portrayal of modern love, desire, and the quiet devastation of miscommunication.',
        imageUrl: 'https://covers.openlibrary.org/b/id/9264645-L.jpg',
      ),
    ];

    // Default: sort by author on load
    add(SortByAuthor());
  }

  void _sortByAuthor(SortByAuthor event, Emitter<BookState> emit) {
    // Emit BookLoading first (shimmer trick) then SortedByAuthor
    emit(BookLoading());
    final sorted = List<Book>.from(allBooks)
      ..sort((a, b) => a.author.compareTo(b.author));
    emit(SortedByAuthor(books: sorted));
  }

  void _sortByTitle(SortByTitle event, Emitter<BookState> emit) {
    // Emit BookLoading first (shimmer trick) then SortedByTitle
    emit(BookLoading());
    final sorted = List<Book>.from(allBooks)
      ..sort((a, b) => a.title.compareTo(b.title));
    emit(SortedByTitle(books: sorted));
  }

  void _selectBook(SelectBook event, Emitter<BookState> emit) {
    final current = state;
    // Preserve books list and current sort type for when user navigates back
    if (current is SortedByAuthor) {
      emit(BookDetailView(
        book: event.book,
        books: current.books,
        sortType: SortType.author,
      ));
    } else if (current is SortedByTitle) {
      emit(BookDetailView(
        book: event.book,
        books: current.books,
        sortType: SortType.title,
      ));
    }
  }

  void _backToList(BackToList event, Emitter<BookState> emit) {
    final current = state;
    if (current is BookDetailView) {
      // Re-emit the correct sorted state based on what was active before
      if (current.sortType == SortType.author) {
        emit(SortedByAuthor(books: current.books));
      } else {
        emit(SortedByTitle(books: current.books));
      }
    }
  }
}