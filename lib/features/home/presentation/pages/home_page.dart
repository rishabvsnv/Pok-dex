import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/constants/app_spacing.dart';
import 'package:pokedex/core/widgets/animations/fade_animation.dart';
import 'package:pokedex/core/widgets/cards/pokemon_card.dart';
import 'package:pokedex/core/widgets/common/app_appbar.dart';
import 'package:pokedex/core/widgets/common/app_scaffold.dart';
import 'package:pokedex/core/widgets/common/app_search_bar.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemons = [
      {
        'id': 1,
        'name': 'Bulbasaur',
        'image':
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png',
        'types': ['Grass', 'Poison'],
      },
      {
        'id': 4,
        'name': 'Charmander',
        'image':
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png',
        'types': ['Fire'],
      },
      {
        'id': 7,
        'name': 'Squirtle',
        'image':
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/7.png',
        'types': ['Water'],
      },
      {
        'id': 25,
        'name': 'Pikachu',
        'image':
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png',
        'types': ['Electric'],
      },
    ];

    return AppScaffold(
      appBar: const AppAppbar(title: 'Pokédex'),

      body: CustomScrollView(
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
          SliverPadding(
            padding: const EdgeInsets.all(AppSpacing.screenPadding),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate((context, index) {
                final pokemon = pokemons[index];

                return FadeAnimation(
                  delay: Duration(milliseconds: index * 120),
                  child: PokemonCard(
                    id: pokemon['id'] as int,
                    name: pokemon['name'] as String,
                    imageUrl: pokemon['image'] as String,
                    types: pokemon['types'] as List<String>,
                  ),
                );
              }, childCount: pokemons.length),

              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 18,
                crossAxisSpacing: 18,
                childAspectRatio: 0.72,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
