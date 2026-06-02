import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/core/theme/app_colors.dart';
import 'package:pokedex/core/widgets/common/app_network_image.dart';

class PokemonCard extends StatelessWidget {
  final int id;
  final String name;
  final String imageUrl;

  final List<String> types;

  final Color? backgroundColor;

  final VoidCallback? onTap;
  final bool showFavorite;
  final bool isFavorite;

  const PokemonCard({
    super.key,
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.types,
    this.backgroundColor,
    this.onTap,
    this.showFavorite = false,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final cardColor = backgroundColor ?? _getPokemonTypeColor(types.first);

    return Hero(
      tag: 'pokemon_$id',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(28),
          onTap: onTap ?? () => context.push('/pokemon/$id'),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [cardColor, cardColor.withValues(alpha: 0.82)],
              ),
              boxShadow: [
                BoxShadow(
                  color: cardColor.withValues(alpha: 0.25),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Pokeball background
                Positioned(
                  right: -18,
                  bottom: -18,
                  child: Opacity(
                    opacity: 0.14,
                    child: Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 6),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(height: 6, color: Colors.white),
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Pokemon ID
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.18),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Text(
                                    '#${id.toString().padLeft(3, '0')}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 14),

                                // Pokemon name
                                Text(
                                  name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.titleLarge?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 24,
                                  ),
                                ),

                                const SizedBox(height: 12),

                                // Types
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: types.map((type) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(
                                          alpha: 0.18,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          100,
                                        ),
                                      ),
                                      child: Text(
                                        type,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 12,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),

                          // Favorite button
                          if (showFavorite)
                            Container(
                              width: 42,
                              height: 42,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.16),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                isFavorite
                                    ? Icons.favorite_rounded
                                    : Icons.favorite_border_rounded,
                                color: Colors.white,
                              ),
                            ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Pokemon Image
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: AppNetworkImage(
                            imageUrl: imageUrl,
                            fit: BoxFit.contain,
                          ),
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
    );
  }

  Color _getPokemonTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'fire':
        return const Color(0xFFFF7043);

      case 'water':
        return const Color(0xFF42A5F5);

      case 'grass':
        return const Color(0xFF66BB6A);

      case 'electric':
        return const Color(0xFFFFCA28);

      case 'psychic':
        return const Color(0xFFEC407A);

      case 'ice':
        return const Color(0xFF26C6DA);

      case 'dragon':
        return const Color(0xFF7E57C2);

      case 'dark':
        return const Color(0xFF5D4037);

      case 'fairy':
        return const Color(0xFFF48FB1);

      case 'normal':
        return const Color(0xFFBDBDBD);

      case 'fighting':
        return const Color(0xFFE53935);

      case 'flying':
        return const Color(0xFF90CAF9);

      case 'poison':
        return const Color(0xFFAB47BC);

      case 'ground':
        return const Color(0xFFD4A373);

      case 'rock':
        return const Color(0xFFA1887F);

      case 'bug':
        return const Color(0xFF8BC34A);

      case 'ghost':
        return const Color(0xFF7E57C2);

      case 'steel':
        return const Color(0xFF90A4AE);

      default:
        return AppColors.primary;
    }
  }
}
