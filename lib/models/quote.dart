/// A model class representing a single quote.
///
/// Contains all the necessary information about a quote including
/// its text, author, category, and other metadata.
class Quote {
  /// The main text content of the quote
  final String text;

  /// The name of the quote's author
  final String author;

  /// The category this quote belongs to (e.g., "Motivation", "Wisdom")
  final String category;

  /// Detailed information about the quote or its author
  final String details;

  /// The source where this quote was obtained from
  final String source;

  /// Creates a new [Quote] instance.
  ///
  /// All parameters are required and must not be null.
  ///
  /// Example:
  /// ```dart
  /// final quote = Quote(
  ///   text: "Sample quote text",
  ///   author: "Author Name",
  ///   category: "Category",
  ///   details: "Details about the quote",
  ///   source: "Quote source"
  /// );
  /// ```
  Quote({
    required this.text,
    required this.author,
    required this.category,
    required this.details,
    required this.source,
  });
}
