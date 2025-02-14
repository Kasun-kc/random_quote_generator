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

  @override
  void initState() {
    super.initState();
    displayedQuotes = List.from(quotesList);
  }

  void filterQuotesByCategory(String category) {
    setState(() {
      selectedCategory = category;
      if (category == "All") {
        displayedQuotes = List.from(quotesList);
      } else {
        displayedQuotes = getQuotesByCategory(category);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Quotes',
            style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.shuffle),
              onPressed: () {
                if (displayedQuotes.isNotEmpty) {
                  final random = Random();
                  final randomQuote =
                      displayedQuotes[random.nextInt(displayedQuotes.length)];
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsScreen(quote: randomQuote),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.background,
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
                          horizontal: 12, vertical: 12),
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
                                horizontal: 12, vertical: 12),
                          ),
                        )),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                itemCount: displayedQuotes.length,
                itemBuilder: (context, index) {
                  final quote = displayedQuotes[index];
                  return Hero(
                    tag: 'quote-card-${quote.text}',
                    child: Card(
                      margin: const EdgeInsets.only(bottom: 20),
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
                                    .background
                                    .withOpacity(0.5),
                              ],
                            ),
                          ),
                          padding: const EdgeInsets.all(24),
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
