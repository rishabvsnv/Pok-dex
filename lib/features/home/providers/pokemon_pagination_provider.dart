import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:pokedex/data/models/pokemon/pokemon_model.dart';
import 'package:pokedex/features/home/repositories/pokemon_repository.dart';

final pokemonPaginationProvider =
    StateNotifierProvider<
      PokemonPaginationNotifier,
      AsyncValue<List<PokemonModel>>
    >((ref) {
      return PokemonPaginationNotifier(ref.watch(pokemonRepositoryProvider));
    });

class PokemonPaginationNotifier
    extends StateNotifier<AsyncValue<List<PokemonModel>>> {
  final PokemonRepository repository;

  PokemonPaginationNotifier(this.repository)
    : super(const AsyncValue.loading()) {
    loadInitial();
  }

  int _offset = 0;

  final int _limit = 10;

  bool _hasMore = true;

  bool _isLoading = false;

  List<PokemonModel> _pokemons = [];

  Future<void> loadInitial() async {
    state = const AsyncValue.loading();

    final result = await repository.getPokemons(limit: _limit, offset: 0);

    if (!result.success) {
      state = AsyncValue.error(result.message ?? 'Error', StackTrace.current);

      return;
    }

    _pokemons = result.data ?? [];

    _offset = _limit;

    state = AsyncValue.data(_pokemons);
  }

  Future<void> loadMore() async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;

    final result = await repository.getPokemons(limit: _limit, offset: _offset);

    if (result.success) {
      final newPokemons = result.data ?? [];

      if (newPokemons.isEmpty) {
        _hasMore = false;
      } else {
        _offset += _limit;

        _pokemons = [..._pokemons, ...newPokemons];

        state = AsyncValue.data(_pokemons);
      }
    }

    _isLoading = false;
  }
}
