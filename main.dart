import 'dart:io';

// Item Interface
abstract class Item {
  String getTitle();
  String getAuthor();
  int getYear();
}

// Book Class
class Book implements Item {
  String title;
  String author;
  int year;

  Book(this.title, this.author, this.year);

  @override
  String getTitle() => title;

  @override
  String getAuthor() => author;

  @override
  int getYear() => year;

  String getDescription() {
    return '$title by $author, published in $year';
  }
}

// EBook Class (Overrides Book's getDescription method)
class EBook extends Book {
  double fileSize;

  EBook(String title, String author, int year, this.fileSize)
      : super(title, author, year);

  @override
  String getDescription() {
    return '${super.getDescription()} (File Size: ${fileSize}MB)';
  }
}

// Library Class
class Library {
  List<Book> books = [];

  void addBook(Book book) {
    books.add(book);
  }

  void displayBooks() {
    print('Library Books:');
    for (var book in books) {
      print(book.getDescription());
    }
  }
}

// Function to read book data from file and initialize Library instance
Future<Library> initializeLibrary(String filePath) async {
  final library = Library();
  final file = File(filePath);
  final lines = await file.readAsLines();

  for (var line in lines) {
    if (line.trim().isNotEmpty) {
      final parts = line.split(', ');
      final title = parts[0];
      final author = parts[1];
      final year = int.parse(parts[2]);

      final book = Book(title, author, year);
      library.addBook(book);
    }
  }

  return library;
}

void main() async {
  final library = await initializeLibrary('data.txt');
  library.displayBooks();
}
