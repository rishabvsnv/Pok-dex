import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/constants/app_spacing.dart';
import 'package:pokedex/core/utils/formatters/height_formatter.dart';
import 'package:pokedex/core/utils/formatters/id_formatter.dart';
import 'package:pokedex/core/utils/formatters/weight_formatter.dart';
import 'package:pokedex/core/widgets/buttons/favorite_button.dart';
import 'package:pokedex/core/widgets/cards/pokemon_info_tile.dart';
import 'package:pokedex/core/widgets/cards/pokemon_stat_card.dart';
import 'package:pokedex/core/widgets/cards/pokemon_type_chip.dart';
import 'package:pokedex/core/widgets/common/app_appbar.dart';
import 'package:pokedex/core/widgets/common/app_loader.dart';
import 'package:pokedex/core/widgets/common/app_network_image.dart';
import 'package:pokedex/core/widgets/common/app_scaffold.dart';
import 'package:pokedex/features/pokemon_detail/providers/pokemon_detail_provider.dart';

class PokemonDetailPage extends ConsumerWidget {
  final int pokemonId;

  const PokemonDetailPage({super.key, required this.pokemonId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final pokemonAsync = ref.watch(pokemonDetailProvider(pokemonId));

    return AppScaffold(
      appBar: AppAppbar(
        title: 'Pokémon Details',
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: FavoriteButton(isFavorite: false),
          ),
        ],
      ),

      body: pokemonAsync.when(
        loading: () {
          return Center(child: const AppLoader());
          // return const Center(child: CircularProgressIndicator());
        },

        error: (error, _) {
          return Center(child: Text(error.toString()));
        },

        data: (pokemon) {
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Header Section
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.screenPadding),
                  child: Column(
                    children: [
                      // Pokemon ID
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.primary.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Text(
                          IdFormatter.format(pokemon.id),
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Pokemon Image
                      Hero(
                        tag: 'pokemon_${pokemon.id}',
                        child: SizedBox(
                          height: 240,
                          child: AppNetworkImage(imageUrl: pokemon.imageUrl),
                        ),
                      ),

                      const SizedBox(height: 24),

                      Text(
                        pokemon.name[0].toUpperCase() +
                            pokemon.name.substring(1),

                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Types
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        alignment: WrapAlignment.center,
                        children: (pokemon.types)
                            .map((type) => PokemonTypeChip(type: type))
                            .toList(),
                      ),

                      const SizedBox(height: 28),

                      // Description
                      Text(
                        pokemon.description,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge?.copyWith(height: 1.7),
                      ),
                    ],
                  ),
                ),
              ),

              // Info Tiles
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenPadding,
                ),
                sliver: SliverGrid(
                  delegate: SliverChildListDelegate([
                    PokemonInfoTile(
                      title: 'Height',
                      value: HeightFormatter.format(pokemon.height),
                      icon: Icons.height_rounded,
                    ),

                    PokemonInfoTile(
                      title: 'Weight',
                      value: WeightFormatter.format(pokemon.weight),
                      icon: Icons.monitor_weight_rounded,
                    ),

                    PokemonInfoTile(
                      title: 'Ability',
                      value: pokemon.abilities.join(', '),
                      // value: pokemon['ability'] as String,
                      icon: Icons.flash_on_rounded,
                    ),

                    PokemonInfoTile(
                      title: 'Type',
                      value: pokemon.types.join(', '),
                      // value: (pokemon['types'] as List<String>).join(', '),
                      icon: Icons.category_rounded,
                    ),
                  ]),

                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    mainAxisExtent: 120,
                  ),
                ),
              ),

              // Stats Section
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.screenPadding,
                    34,
                    AppSpacing.screenPadding,
                    16,
                  ),
                  child: Text(
                    'Base Stats',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),

              // Stats List
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenPadding,
                ),
                sliver: SliverList.separated(
                  itemCount: pokemon.stats.length,

                  // itemCount: (pokemon['stats'] as Map<String, int>).length,
                  separatorBuilder: (_, _) => const SizedBox(height: 16),

                  itemBuilder: (context, index) {
                    final entry = pokemon.stats.entries.elementAt(index);
                    // final entry = (pokemon['stats'] as Map<String, int>).entries
                    //     .elementAt(index);

                    return PokemonStatCard(
                      statName: entry.key,
                      value: entry.value,
                    );
                  },
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 40)),
            ],
          );
          /* return CustomScrollView(
            physics: const BouncingScrollPhysics(),

            slivers: [
              // Header Section
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.screenPadding),

                  child: Column(
                    children: [
                      // Pokemon ID
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),

                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.primary.withValues(alpha: 0.12),

                          borderRadius: BorderRadius.circular(100),
                        ),

                        child: Text(
                          IdFormatter.format(pokemon.id),

                          style: theme.textTheme.labelLarge?.copyWith(
                            color: Theme.of(context).colorScheme.primary,

                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Pokemon Image
                      Hero(
                        tag: 'pokemon_${pokemon.id}',

                        child: SizedBox(
                          height: 240,

                          child: AppNetworkImage(imageUrl: pokemon.imageUrl),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Types
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        alignment: WrapAlignment.center,

                        children: pokemon.types
                            .map((type) => PokemonTypeChip(type: type))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 40)),
            ],
          ); */
        },
      ),
    );
  }
}
