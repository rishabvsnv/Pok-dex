import 'package:flutter/material.dart';
import 'package:pokedex/core/constants/app_spacing.dart';
import 'package:pokedex/core/utils/formatters/height_formatter.dart';
import 'package:pokedex/core/utils/formatters/id_formatter.dart';
import 'package:pokedex/core/utils/formatters/weight_formatter.dart';
import 'package:pokedex/core/utils/helpers/image_helper.dart';
import 'package:pokedex/core/widgets/buttons/favorite_button.dart';
import 'package:pokedex/core/widgets/cards/pokemon_info_tile.dart';
import 'package:pokedex/core/widgets/cards/pokemon_stat_card.dart';
import 'package:pokedex/core/widgets/cards/pokemon_type_chip.dart';
import 'package:pokedex/core/widgets/common/app_appbar.dart';
import 'package:pokedex/core/widgets/common/app_network_image.dart';
import 'package:pokedex/core/widgets/common/app_scaffold.dart';

class PokemonDetailPage extends StatelessWidget {
  final int pokemonId;

  const PokemonDetailPage({super.key, required this.pokemonId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Temporary mock data
    final pokemon = {
      'id': pokemonId,
      'name': 'Pikachu',
      'image': ImageHelper.getPokemonImage(pokemonId),
      'types': ['Electric'],
      'height': 4,
      'weight': 60,
      'ability': 'Static',
      'description':
          'Whenever Pikachu comes across something new, it blasts it with a jolt of electricity.',
      'stats': {
        'HP': 35,
        'Attack': 55,
        'Defense': 40,
        'Sp. Attack': 50,
        'Sp. Defense': 50,
        'Speed': 90,
      },
    };

    return AppScaffold(
      appBar: AppAppbar(
        title: pokemon['name'] as String,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: FavoriteButton(isFavorite: false),
          ),
        ],
      ),

      body: CustomScrollView(
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
                      IdFormatter.format(pokemon['id'] as int),
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Pokemon Image
                  Hero(
                    tag: 'pokemon_${pokemon['id']}',
                    child: SizedBox(
                      height: 240,
                      child: AppNetworkImage(
                        imageUrl: pokemon['image'] as String,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Types
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    alignment: WrapAlignment.center,
                    children: (pokemon['types'] as List<String>)
                        .map((type) => PokemonTypeChip(type: type))
                        .toList(),
                  ),

                  const SizedBox(height: 28),

                  // Description
                  Text(
                    pokemon['description'] as String,
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
                  value: HeightFormatter.format(pokemon['height'] as int),
                  icon: Icons.height_rounded,
                ),

                PokemonInfoTile(
                  title: 'Weight',
                  value: WeightFormatter.format(pokemon['weight'] as int),
                  icon: Icons.monitor_weight_rounded,
                ),

                PokemonInfoTile(
                  title: 'Ability',
                  value: pokemon['ability'] as String,
                  icon: Icons.flash_on_rounded,
                ),

                PokemonInfoTile(
                  title: 'Type',
                  value: (pokemon['types'] as List<String>).join(', '),
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
              itemCount: (pokemon['stats'] as Map<String, int>).length,

              separatorBuilder: (_, _) => const SizedBox(height: 16),

              itemBuilder: (context, index) {
                final entry = (pokemon['stats'] as Map<String, int>).entries
                    .elementAt(index);

                return PokemonStatCard(statName: entry.key, value: entry.value);
              },
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }
}
