import 'package:flutter/material.dart';
import 'dart:math';
import '../models/quote.dart';
import '../data/quotes_data.dart';
import 'details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = "All";
  List<Quote> displayedQuotes = [];
  Quote? randomQuote; // Add this variable

  @override
  void initState() {
    super.initState();
    displayedQuotes = List.from(quotesList);
    generateRandomQuote(); // Generate initial random quote
  }

  void generateRandomQuote() {
    if (displayedQuotes.isNotEmpty) {
      final random = Random();
      setState(() {
        randomQuote = displayedQuotes[random.nextInt(displayedQuotes.length)];
      });
    }
  }

  void filterQuotesByCategory(String category) {
    setState(() {
      selectedCategory = category;
      if (category == "All") {
        displayedQuotes = List.from(quotesList);
      } else {
        displayedQuotes = getQuotesByCategory(category);
      }
      generateRandomQuote(); // Generate new random quote when category changes
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Quotes',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.surface,
              Colors.white,
            ],
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    FilterChip(
                      label: const Text('All'),
                      selected: selectedCategory == 'All',
                      onSelected: (_) => filterQuotesByCategory('All'),
                      labelStyle: TextStyle(
                        color: selectedCategory == 'All'
                            ? Theme.of(context).colorScheme.onSecondary
                            : Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12), // Adjusted padding
                    ),
                    const SizedBox(width: 12),
                    ...categories.map((category) => Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: FilterChip(
                            label: Text(category),
                            selected: selectedCategory == category,
                            onSelected: (_) => filterQuotesByCategory(category),
                            labelStyle: TextStyle(
                              color: selectedCategory == category
                                  ? Theme.of(context).colorScheme.onSecondary
                                  : Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12), // Adjusted padding
                          ),
                        )),
                  ],
                ),
              ),
            ),
            // Quotes List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(
                    20, 8, 20, 32), // Adjusted padding
                itemCount: displayedQuotes.length,
                itemBuilder: (context, index) {
                  final quote = displayedQuotes[index];
                  return Hero(
                    tag: 'quote-card-${quote.text}',
                    child: Card(
                      margin:
                          const EdgeInsets.only(bottom: 24), // Adjusted margin
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsScreen(quote: quote),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.white,
                                Theme.of(context)
                                    .colorScheme
                                    .surface
                                    .withOpacity(0.5),
                              ],
                            ),
                          ),
                          padding: const EdgeInsets.all(28), // Adjusted padding
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '"${quote.text}"',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      height: 1.4,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '- ${quote.author}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary
                                            .withOpacity(0.2),
                                      ),
                                    ),
                                    child: Text(
                                      quote.category,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
