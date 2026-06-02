import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/core/constants/app_spacing.dart';
import 'package:pokedex/core/widgets/cards/pokemon_card.dart';
import 'package:pokedex/core/widgets/common/app_appbar.dart';
import 'package:pokedex/core/widgets/common/app_scaffold.dart';
import 'package:pokedex/core/widgets/common/empty_state.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Temporary mock favorites
    final favorites = [
      {
        'id': 25,
        'name': 'Pikachu',
        'image':
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png',
        'types': ['Electric'],
      },

      {
        'id': 6,
        'name': 'Charizard',
        'image':
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/6.png',
        'types': ['Fire', 'Flying'],
      },

      {
        'id': 149,
        'name': 'Dragonite',
        'image':
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/149.png',
        'types': ['Dragon', 'Flying'],
      },
    ];

    final isEmpty = favorites.isEmpty;

    return AppScaffold(
      appBar: const AppAppbar(title: 'Favorites'),

      body: isEmpty
          ? EmptyState.noFavorites(
              onExplore: () {
                context.go('/');
              },
            )
          : CustomScrollView(
              physics: const BouncingScrollPhysics(),

              slivers: [
                // Header
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.screenPadding,
                      20,
                      AppSpacing.screenPadding,
                      0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Pokémon Team',
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          '${favorites.length} Pokémon saved to favorites',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ),

                // Grid
                SliverPadding(
                  padding: const EdgeInsets.all(AppSpacing.screenPadding),

                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final pokemon = favorites[index];

                      return PokemonCard(
                        id: pokemon['id'] as int,

                        name: pokemon['name'] as String,

                        imageUrl: pokemon['image'] as String,

                        types: pokemon['types'] as List<String>,

                        showFavorite: true,

                        isFavorite: true,
                      );
                    }, childCount: favorites.length),

                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 18,
                          crossAxisSpacing: 18,
                          childAspectRatio: 0.72,
                        ),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 40)),
              ],
            ),
    );
  }
}
