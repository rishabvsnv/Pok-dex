import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/core/constants/app_spacing.dart';
import 'package:pokedex/core/widgets/animations/fade_animation.dart';
import 'package:pokedex/core/widgets/cards/pokemon_card.dart';
import 'package:pokedex/core/widgets/common/app_appbar.dart';
import 'package:pokedex/core/widgets/common/app_loader.dart';
import 'package:pokedex/core/widgets/common/app_scaffold.dart';
import 'package:pokedex/core/widgets/common/app_search_bar.dart';
import 'package:pokedex/features/home/providers/pokemon_pagination_provider.dart';
import 'package:pokedex/features/search/providers/search_pokemon_provider.dart';
import 'package:pokedex/features/search/providers/search_provider.dart';
import 'package:pokedex/features/search/providers/search_suggestions_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 300) {
        ref.read(pokemonPaginationProvider.notifier).loadMore();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pokemonListAsync = ref.watch(pokemonPaginationProvider);

    final searchQuery = ref.watch(searchQueryProvider);

    final searchAsync = ref.watch(searchPokemonProvider(searchQuery));

    final isSearching = searchQuery.trim().isNotEmpty;

    final suggestions = ref.watch(searchSuggestionsProvider);

    return AppScaffold(
      // appBar: const AppAppbar(title: 'Pokédex'),
      appBar: AppAppbar(
        title: 'Pokédex',

        actions: [
          IconButton(
            onPressed: () {
              context.push('/favorites');
            },

            icon: const Icon(Icons.favorite_rounded),
          ),
        ],
      ),

      body: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),

        slivers: [
          // Header Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenPadding,
                12,
                AppSpacing.screenPadding,
                0,
              ),

              child: FadeAnimation(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      'Pokémon Encyclopedia',

                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.w800),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Search Pokémon by name and explore detailed information',

                      style: Theme.of(context).textTheme.bodyLarge,
                    ),

                    const SizedBox(height: 24),

                    AppSearchBar(
                      hintText: 'Search Pokémon...',

                      onChanged: (value) {
                        ref.read(searchQueryProvider.notifier).state = value;
                      },
                    ),

                    if (suggestions.isNotEmpty)
                      Container(
                        margin: const EdgeInsets.only(top: 16),

                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,

                          borderRadius: BorderRadius.circular(20),
                        ),

                        child: Column(
                          children: suggestions.take(5).map((pokemon) {
                            return ListTile(
                              title: Text(pokemon.name),

                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(pokemon.imageUrl),
                              ),

                              onTap: () {
                                ref.read(searchQueryProvider.notifier).state =
                                    pokemon.name;
                              },
                            );
                          }).toList(),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),

          // SEARCH MODE
          if (isSearching)
            searchAsync.when(
              loading: () => const SliverFillRemaining(child: AppLoader()),

              error: (_, _) => const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(40),

                  child: Center(child: Text('Pokemon not found')),
                ),
              ),

              data: (pokemon) {
                if (pokemon == null) {
                  return const SliverToBoxAdapter(child: SizedBox());
                }

                return SliverPadding(
                  padding: const EdgeInsets.all(AppSpacing.screenPadding),

                  sliver: SliverGrid(
                    delegate: SliverChildListDelegate([
                      PokemonCard(
                        id: pokemon.id,
                        name: pokemon.name,
                        imageUrl: pokemon.imageUrl,
                        types: pokemon.types,
                      ),
                    ]),

                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 18,
                          crossAxisSpacing: 18,
                          childAspectRatio: 0.65,
                        ),
                  ),
                );
              },
            )
          // PAGINATION MODE
          else
            pokemonListAsync.when(
              loading: () => const SliverFillRemaining(child: AppLoader()),

              error: (error, _) => SliverFillRemaining(
                child: Center(child: Text(error.toString())),
              ),

              data: (pokemons) {
                return SliverPadding(
                  padding: const EdgeInsets.all(AppSpacing.screenPadding),

                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final pokemon = pokemons[index];

                      return FadeAnimation(
                        delay: Duration(milliseconds: index * 120),

                        child: PokemonCard(
                          id: pokemon.id,
                          name: pokemon.name,
                          imageUrl: pokemon.imageUrl,
                          types: pokemon.types,
                        ),
                      );
                    }, childCount: pokemons.length),

                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 18,
                          crossAxisSpacing: 18,
                          childAspectRatio: 0.65,
                        ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
