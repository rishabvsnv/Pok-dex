import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/constants/app_spacing.dart';
import 'package:pokedex/core/widgets/animations/fade_animation.dart';
import 'package:pokedex/core/widgets/cards/pokemon_card.dart';
import 'package:pokedex/core/widgets/common/app_appbar.dart';
import 'package:pokedex/core/widgets/common/app_scaffold.dart';
import 'package:pokedex/core/widgets/common/app_search_bar.dart';
import 'package:pokedex/features/home/providers/pokemon_pagination_provider.dart';

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
  Widget build(BuildContext context) {
    final pokemonAsync = ref.watch(pokemonPaginationProvider);

    return AppScaffold(
      appBar: const AppAppbar(title: 'Pokédex'),

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
                      'Discover Pokémon',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.w800),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Search and explore your favorite Pokémon.',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),

                    const SizedBox(height: 24),

                    AppSearchBar(
                      hintText: 'Search Pokémon...',
                      onChanged: (value) {},
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Pokemon Grid
          pokemonAsync.when(
            loading: () => const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            ),

            error: (error, _) => SliverFillRemaining(
              child: Center(child: Text(error.toString())),
            ),

            data: (pokemons) => SliverPadding(
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

                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 18,
                  crossAxisSpacing: 18,
                  childAspectRatio: 0.65,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
