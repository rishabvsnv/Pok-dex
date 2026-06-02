import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:pokedex/core/widgets/common/app_error_widget.dart';

import 'package:pokedex/features/favorites/presentation/pages/favorites_page.dart';
import 'package:pokedex/features/home/presentation/pages/home_page.dart';
import 'package:pokedex/features/pokemon_detail/presentation/pages/pokemon_detail_page.dart';
import 'package:pokedex/features/search/presentation/pages/search_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',

    debugLogDiagnostics: true,

    errorBuilder: (context, state) {
      return AppErrorWidget(route: state.uri.toString());
    },

    routes: [
      // Home
      GoRoute(
        path: '/',
        name: 'home',
        pageBuilder: (context, state) {
          return _buildPage(child: const HomePage(), state: state);
        },
      ),

      // Pokémon Detail
      GoRoute(
        path: '/pokemon/:id',
        name: 'pokemon-detail',
        pageBuilder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);

          return _buildPage(
            child: PokemonDetailPage(pokemonId: id),
            state: state,
          );
        },
      ),

      // Search
      GoRoute(
        path: '/search',
        name: 'search',
        pageBuilder: (context, state) {
          return _buildPage(child: const SearchPage(), state: state);
        },
      ),

      // Favorites
      GoRoute(
        path: '/favorites',
        name: 'favorites',
        pageBuilder: (context, state) {
          return _buildPage(child: const FavoritesPage(), state: state);
        },
      ),
    ],
  );
});

CustomTransitionPage<dynamic> _buildPage({
  required Widget child,
  required GoRouterState state,
}) {
  return CustomTransitionPage(
    key: state.pageKey,

    child: child,

    transitionDuration: const Duration(milliseconds: 300),

    reverseTransitionDuration: const Duration(milliseconds: 250),

    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.04, 0),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
          child: child,
        ),
      );
    },
  );
}
