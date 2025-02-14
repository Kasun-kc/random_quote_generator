import 'package:flutter/material.dart';
import '../models/quote.dart';

class DetailsScreen extends StatelessWidget {
  final Quote? quote; // Make quote nullable
  const DetailsScreen({super.key, required this.quote});

  @override
  Widget build(BuildContext context) {
    // Handle case when quote is null
    if (quote == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Quote Details'),
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
          child: Center(
            child: Text(
              'Failed to load quote. Please try again.',
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
          ),
        ),
      );
    }

    return Scaffold(
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
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              pinned: true,
              title: Text(
                quote!.author,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(24),
              sliver: SliverToBoxAdapter(
                child: Hero(
                  tag: 'quote-card-${quote!.text}',
                  child: Card(
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
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "\"${quote!.text}\"",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                  height: 1.4,
                                ),
                          ),
                          const SizedBox(height: 24),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                            child: Text(
                              quote!.category,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            "Source: ${quote!.source}",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.tertiary,
                                  fontStyle: FontStyle.italic,
                                ),
                          ),
                          const SizedBox(height: 32),
                          Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.05),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "About the Author",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  quote!.details,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        height: 1.6,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
