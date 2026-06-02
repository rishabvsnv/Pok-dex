import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/core/constants/app_spacing.dart';
import 'package:pokedex/core/widgets/cards/pokemon_card.dart';
import 'package:pokedex/core/widgets/common/app_appbar.dart';
import 'package:pokedex/core/widgets/common/app_scaffold.dart';
import 'package:pokedex/core/widgets/common/app_search_bar.dart';
import 'package:pokedex/core/widgets/common/empty_state.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  String _query = '';

  final List<Map<String, dynamic>> _pokemons = [
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

    {
      'id': 149,
      'name': 'Dragonite',
      'image':
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/149.png',
      'types': ['Dragon', 'Flying'],
    },
  ];

  List<Map<String, dynamic>> get _filteredPokemons {
    if (_query.trim().isEmpty) {
      return _pokemons;
    }

    return _pokemons.where((pokemon) {
      final name = (pokemon['name'] as String).toLowerCase();

      final types = (pokemon['types'] as List<String>).join(' ').toLowerCase();

      final query = _query.toLowerCase();

      return name.contains(query) || types.contains(query);
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final results = _filteredPokemons;

    return AppScaffold(
      appBar: const AppAppbar(title: 'Search'),

      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),

        slivers: [
          // Search Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenPadding,
                18,
                AppSpacing.screenPadding,
                0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Find Pokémon',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    'Search by Pokémon name or type.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),

                  const SizedBox(height: 24),

                  AppSearchBar(
                    controller: _searchController,

                    hintText: 'Search Pokémon...',

                    autofocus: true,

                    onChanged: (value) {
                      setState(() {
                        _query = value;
                      });
                    },

                    onClear: () {
                      setState(() {
                        _query = '';
                      });
                    },
                  ),

                  const SizedBox(height: 22),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Search Results',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),

                      Text(
                        '${results.length} found',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Empty State
          if (results.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: EmptyState.noPokemon(
                onRetry: () {
                  _searchController.clear();

                  setState(() {
                    _query = '';
                  });
                },
              ),
            )
          // Pokemon Grid
          else
            SliverPadding(
              padding: const EdgeInsets.all(AppSpacing.screenPadding),

              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final pokemon = results[index];

                  return PokemonCard(
                    id: pokemon['id'] as int,

                    name: pokemon['name'] as String,

                    imageUrl: pokemon['image'] as String,

                    types: pokemon['types'] as List<String>,

                    onTap: () {
                      context.push('/pokemon/${pokemon['id']}');
                    },
                  );
                }, childCount: results.length),

                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
