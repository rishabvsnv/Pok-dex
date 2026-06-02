import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/core/constants/app_spacing.dart';
import 'package:pokedex/core/widgets/cards/pokemon_card.dart';
import 'package:pokedex/core/widgets/common/app_appbar.dart';
import 'package:pokedex/core/widgets/common/app_scaffold.dart';
import 'package:pokedex/core/widgets/common/empty_state.dart';
import 'package:pokedex/features/favorites/providers/favorites_provider.dart';

class FavoritesPage extends ConsumerWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);

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
                        id: pokemon.id,

                        name: pokemon.name,

                        imageUrl: pokemon.imageUrl,

                        types: pokemon.types,

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
